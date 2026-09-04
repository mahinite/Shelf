import 'dart:io';

import 'dart:typed_data';

import 'package:image/image.dart' as img;
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf_combiner/pdf_combiner.dart';
import 'package:pdf_combiner/models/merge_input.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:shelf/core/network/worker_client.dart';


/// Service handling scan‑related uploads and PDF generation.
class ScanService {
  ScanService._();

  static const int maxDimension = 2000;

  /// Process an image file: grayscale, contrast boost, downscale, JPEG encode.
  static Future<Uint8List> _processImageFile(String path) async {
    final resolvedPath = path.startsWith('file://') ? Uri.parse(path).toFilePath() : path;
    final file = File(resolvedPath);
    final bytes = await file.readAsBytes();
    final decoded = img.decodeImage(bytes);
    if (decoded == null) throw Exception('Failed to decode image at $path');

    // Resize if needed
    img.Image resized = decoded;
    if (decoded.width > maxDimension || decoded.height > maxDimension) {
      resized = img.copyResize(
        decoded,
        width: decoded.width > decoded.height ? maxDimension : null,
        height: decoded.height > decoded.width ? maxDimension : null,
        interpolation: img.Interpolation.cubic,
      );
    }

    // Grayscale & contrast
    final gray = img.grayscale(resized);
    final enhanced = img.contrast(gray, contrast: 130);
    final jpeg = img.encodeJpg(enhanced, quality: 80);
    return Uint8List.fromList(jpeg);
  }

  static Future<void> _uploadPdf({
    required String documentId,
    required Uint8List pdfBytes,
  }) async {
    await WorkerClient.instance.putBytes(
      objectPath: 'documents/$documentId.pdf',
      bytes: pdfBytes,
      contentType: 'application/pdf',
    );
  }

  static Future<String> _createDocument({required String chapterId, required String title}) async {
    final client = Supabase.instance.client;
    final result = await client.from('documents').insert({
      'chapter_id': chapterId,
      'title': title,
      'position': 0,
    }).select('id').single();
    return result['id'] as String;
  }

  static Future<String> _createScanBatch({required String documentId}) async {
    final client = Supabase.instance.client;
    final userId = client.auth.currentUser?.id;
    if (userId == null) throw Exception('Not authenticated');
    final result = await client.from('scan_batches').insert({
      'document_id': documentId,
      'scanned_by': userId,
    }).select('id').single();
    return result['id'] as String;
  }

  static Future<void> _updateDocument({required String documentId, required int pageCount, required int fileSize}) async {
    final client = Supabase.instance.client;
    await client.from('documents').update({
      'file_path': 'documents/$documentId.pdf',
      'page_count': pageCount,
      'file_size': fileSize,
      'updated_at': DateTime.now().toIso8601String(),
    }).eq('id', documentId);
  }

  /// Upload a brand‑new document.
  static Future<void> uploadNewDocument({
    required List<String> imagePaths,
    required String title,
    required String chapterId,
  }) async {
    // 1. Process images
    final processed = <Uint8List>[];
    for (final path in imagePaths) {
      processed.add(await _processImageFile(path));
    }

    // 2. Insert document row
    final documentId = await _createDocument(chapterId: chapterId, title: title);

    // 3. Create scan batch
    await _createScanBatch(documentId: documentId);

    // 4. Assemble PDF from processed images
    final pdfDoc = pw.Document();
    for (final bytes in processed) {
      final imgPdf = pw.MemoryImage(bytes);
      pdfDoc.addPage(pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: pw.EdgeInsets.zero,
        build: (c) => pw.Center(child: pw.Image(imgPdf, fit: pw.BoxFit.contain)),
      ));
    }
    final pdfBytes = await pdfDoc.save();

    // 6. Upload PDF
    await _uploadPdf(documentId: documentId, pdfBytes: pdfBytes);

    // 7. Update document metadata
    await _updateDocument(documentId: documentId, pageCount: processed.length, fileSize: pdfBytes.length);
  }

  /// Append images to an existing document.
  static Future<void> uploadToExistingDocument({
    required List<String> imagePaths,
    required String documentId,
  }) async {
    final client = Supabase.instance.client;

    // 1. Process new images
    final processed = <Uint8List>[];
    for (final path in imagePaths) {
      processed.add(await _processImageFile(path));
    }

    // 2. Read current page_count from documents row (replaces scan_pages query)
    final docInfo = await client.from('documents').select('page_count').eq('id', documentId).single();
    final currentCount = (docInfo['page_count'] as int?) ?? 0;

    // 3. Create new scan batch
    await _createScanBatch(documentId: documentId);

    // 4. Download existing PDF via Worker (mandatory)
    Uint8List existingPdf = await WorkerClient.instance.getBytes('documents/$documentId.pdf');

    // 5. Build PDF for new pages only
    final newPdfDoc = pw.Document();
    for (final bytes in processed) {
      final imgPdf = pw.MemoryImage(bytes);
      newPdfDoc.addPage(pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: pw.EdgeInsets.zero,
        build: (c) => pw.Center(child: pw.Image(imgPdf, fit: pw.BoxFit.contain)),
      ));
    }
    final newPdfBytes = await newPdfDoc.save();

    // 6. Merge PDFs using pdf_combiner (write to temp files)
    Uint8List mergedPdf;
    final tempDir = Directory.systemTemp.createTempSync('pdf_combiner_temp.');
    try {
      final existingFile = File('${tempDir.path}/existing.pdf');
      await existingFile.writeAsBytes(existingPdf);
      final newFile = File('${tempDir.path}/new.pdf');
      await newFile.writeAsBytes(newPdfBytes);
      final outputFile = File('${tempDir.path}/merged.pdf');
      await PdfCombiner.mergeMultiplePDFs(
        inputs: [
          MergeInput.path(existingFile.path),
          MergeInput.path(newFile.path),
        ],
        outputPath: outputFile.path,
      );
      mergedPdf = await outputFile.readAsBytes();
    } finally {
      // Clean up temp files
      try {
        await tempDir.delete(recursive: true);
      } catch (_) {
        // Ignore cleanup errors
      }
    }

    // 7. Upload merged PDF
    await _uploadPdf(documentId: documentId, pdfBytes: mergedPdf);

    // 8. Update document metadata (page count & file size)
    final newCount = currentCount + processed.length;
    await _updateDocument(documentId: documentId, pageCount: newCount, fileSize: mergedPdf.length);
  }
}
