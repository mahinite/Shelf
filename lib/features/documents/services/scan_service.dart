import 'dart:io';

import 'package:flutter/foundation.dart';
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

  /// Max pixel dimension for processed images. Lowered to 1600 for low-end
  /// device memory/CPU headroom; tune upward if quality demands it.
  static const int maxDimension = 1600;

  /// JPEG quality for processed page images. Conservative 75 to bound
  /// encode size and CPU on weak devices; tune if needed.
  static const int jpegQuality = 75;

  /// Build a B2 object path from a document title and documentId.
  /// Lowercases, replaces non-alphanumeric with '-', collapses repeated '-',
  /// trims leading/trailing '-', caps at ~60 chars, appends '-<first 8 chars of id>'.
  static String _buildObjectPath({required String title, required String documentId}) {
    final slug = title
        .toLowerCase()
        .replaceAll(RegExp(r'[^a-z0-9]+'), '-')
        .replaceAll(RegExp(r'-+'), '-')
        .replaceAll(RegExp(r'^-|-$'), '');
    final cappedSlug = slug.length > 60 ? slug.substring(0, 60) : slug;
    final idPrefix = documentId.length >= 8 ? documentId.substring(0, 8) : documentId;
    return 'documents/$cappedSlug-$idPrefix.pdf';
  }

  /// Isolate entry point: process a single image to a one-page PDF temp file.
  /// Receives a map with keys 'imagePath' (String) and 'index' (int) for
  /// unique temp filename. Returns the temp PDF file path (String).
  static Future<String> processPageToTempPdf(Map<String, Object> args) async {
    final String imagePath = args['imagePath'] as String;
    final int index = args['index'] as int;
    final resolvedPath = imagePath.startsWith('file://') ? Uri.parse(imagePath).toFilePath() : imagePath;

    final file = File(resolvedPath);
    final bytes = await file.readAsBytes();
    final decoded = img.decodeImage(bytes);
    if (decoded == null) throw Exception('Failed to decode image at $imagePath');

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
    final jpeg = img.encodeJpg(enhanced, quality: jpegQuality);
    final jpegBytes = Uint8List.fromList(jpeg);

    // Build single-page PDF
    final pdfDoc = pw.Document();
    final imgPdf = pw.MemoryImage(jpegBytes);
    pdfDoc.addPage(pw.Page(
      pageFormat: PdfPageFormat.a4,
      margin: pw.EdgeInsets.zero,
      build: (c) => pw.Center(child: pw.Image(imgPdf, fit: pw.BoxFit.contain)),
    ));
    final pdfBytes = await pdfDoc.save();

    // Write to unique temp file
    final tempDir = Directory.systemTemp;
    final tempFile = File('${tempDir.path}/scan_page_${index}_${DateTime.now().microsecondsSinceEpoch}.pdf');
    await tempFile.writeAsBytes(pdfBytes);
    return tempFile.path;
  }

  static Future<void> _uploadPdf({
    required String objectPath,
    required Uint8List pdfBytes,
  }) async {
    await WorkerClient.instance.putBytes(
      objectPath: objectPath,
      bytes: pdfBytes,
      contentType: 'application/pdf',
    );
  }

  static Future<String> _createDocument({required String chapterId, required String title}) async {
    final client = Supabase.instance.client;
    final userId = client.auth.currentUser?.id;
    if (userId == null) throw Exception('Not authenticated');
    final result = await client.from('documents').insert({
      'chapter_id': chapterId,
      'title': title,
      'position': 0,
      'created_by': userId,
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

  static Future<void> _updateDocument({
    required String documentId,
    required int pageCount,
    required int fileSize,
    required String filePath,
  }) async {
    final client = Supabase.instance.client;
    await client.from('documents').update({
      'file_path': filePath,
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
    void Function(int current, int total)? onProgress,
  }) async {
    // 1. Insert document row first (needed for object path)
    final documentId = await _createDocument(chapterId: chapterId, title: title);

    // 2. Create scan batch
    await _createScanBatch(documentId: documentId);

    // 3. Compute object path from title + documentId (once)
    final objectPath = _buildObjectPath(title: title, documentId: documentId);

    // 3b. Stamp file_path on the document row NOW so the Worker's
    // authorization check (file_path exact match) succeeds at PUT time.
    await Supabase.instance.client
        .from('documents')
        .update({'file_path': objectPath})
        .eq('id', documentId);

    // 4. Process each page in an isolate, writing single-page PDFs to temp files.
    // Sequential only — concurrent isolates each holding a full-res image spikes memory.
    final pagePdfPaths = <String>[];
    for (int i = 0; i < imagePaths.length; i++) {
      onProgress?.call(i + 1, imagePaths.length);
      final path = await compute(
        processPageToTempPdf,
        {'imagePath': imagePaths[i], 'index': i},
      );
      pagePdfPaths.add(path);
    }

    // 5. Merge all single-page PDFs into final PDF via PdfCombiner (temp files).
    final tempDir = Directory.systemTemp.createTempSync('pdf_merge_temp.');
    Uint8List mergedPdf;
    try {
      final outputFile = File('${tempDir.path}/merged.pdf');
      await PdfCombiner.mergeMultiplePDFs(
        inputs: pagePdfPaths.map((p) => MergeInput.path(p)).toList(),
        outputPath: outputFile.path,
      );
      mergedPdf = await outputFile.readAsBytes();

      // 6. Upload merged PDF
      await _uploadPdf(objectPath: objectPath, pdfBytes: mergedPdf);

      // 7. Update document metadata
      await _updateDocument(
        documentId: documentId,
        pageCount: pagePdfPaths.length,
        fileSize: mergedPdf.length,
        filePath: objectPath,
      );
    } finally {
      // Clean up all per-page temp files and merge temp dir
      for (final p in pagePdfPaths) {
        try {
          await File(p).delete();
        } catch (_) {}
      }
      try {
        await tempDir.delete(recursive: true);
      } catch (_) {}
    }
  }

  /// Append images to an existing document.
  static Future<void> uploadToExistingDocument({
    required List<String> imagePaths,
    required String documentId,
    void Function(int current, int total)? onProgress,
  }) async {
    final client = Supabase.instance.client;

    // 1. Read current page_count and file_path from documents row
    final docInfo = await client
        .from('documents')
        .select('page_count, file_path')
        .eq('id', documentId)
        .single();
    final currentCount = (docInfo['page_count'] as int?) ?? 0;
    final filePath = docInfo['file_path'] as String? ?? 'documents/$documentId.pdf';

    // 2. Create new scan batch
    await _createScanBatch(documentId: documentId);

    // 3. Download existing PDF via Worker using stored file_path
    Uint8List existingPdf = await WorkerClient.instance.getBytes(filePath);

    // 4. Process each NEW page in an isolate, writing single-page PDFs to temp files.
    // Sequential only — concurrent isolates each holding a full-res image spikes memory.
    final newPagePdfPaths = <String>[];
    for (int i = 0; i < imagePaths.length; i++) {
      onProgress?.call(i + 1, imagePaths.length);
      final path = await compute(
        processPageToTempPdf,
        {'imagePath': imagePaths[i], 'index': i},
      );
      newPagePdfPaths.add(path);
    }

    // 5. Write existing PDF to a temp file, then merge it with all new single-page PDFs
    // directly — skipping the intermediate "build one big new-pages PDF" step.
    final tempDir = Directory.systemTemp.createTempSync('pdf_merge_temp.');
    Uint8List mergedPdf;
    String existingPdfTempPath = '';
    try {
      final existingFile = File('${tempDir.path}/existing.pdf');
      await existingFile.writeAsBytes(existingPdf);
      existingPdfTempPath = existingFile.path;

      final outputFile = File('${tempDir.path}/merged.pdf');
      final inputs = <MergeInput>[MergeInput.path(existingPdfTempPath)];
      inputs.addAll(newPagePdfPaths.map((p) => MergeInput.path(p)));

      await PdfCombiner.mergeMultiplePDFs(
        inputs: inputs,
        outputPath: outputFile.path,
      );
      mergedPdf = await outputFile.readAsBytes();

      // 6. Upload merged PDF to the same object path (overwrite)
      await _uploadPdf(objectPath: filePath, pdfBytes: mergedPdf);

      // 7. Update document metadata (page count & file size)
      final newCount = currentCount + newPagePdfPaths.length;
      await _updateDocument(
        documentId: documentId,
        pageCount: newCount,
        fileSize: mergedPdf.length,
        filePath: filePath,
      );
    } finally {
      // Clean up all temp files: existing PDF temp, per-page PDFs, merge temp dir
      for (final p in newPagePdfPaths) {
        try {
          await File(p).delete();
        } catch (_) {}
      }
      if (existingPdfTempPath.isNotEmpty) {
        try {
          await File(existingPdfTempPath).delete();
        } catch (_) {}
      }
      try {
        await tempDir.delete(recursive: true);
      } catch (_) {}
    }
  }
}
