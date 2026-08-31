import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:image/image.dart' as img;
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:supabase_flutter/supabase_flutter.dart';

class ScanService {
  ScanService._();

  static const int maxDimension = 2048;

  static Future<File> processImage(File imageFile) async {
    final bytes = await imageFile.readAsBytes();
    final image = img.decodeImage(bytes);
    if (image == null) {
      throw Exception('Failed to decode image');
    }

    // Resize if needed
    img.Image resized = image;
    if (image.width > maxDimension || image.height > maxDimension) {
      resized = img.copyResize(
        image,
        width: image.width > image.height ? maxDimension : null,
        height: image.height > image.width ? maxDimension : null,
        interpolation: img.Interpolation.cubic,
      );
    }

    // Convert to grayscale
    final grayscale = img.grayscale(resized);

    // Enhance contrast
    final enhanced = img.contrast(grayscale, contrast: 1.3);

    // Save as JPEG
    final jpegBytes = img.encodeJpg(enhanced, quality: 85);
    final processedFile = File('${imageFile.path}.processed.jpg');
    await processedFile.writeAsBytes(jpegBytes);

    return processedFile;
  }

  static Future<Uint8List> assemblePdf(List<File> pageImages) async {
    final pdf = pw.Document();

    for (final pageImage in pageImages) {
      final bytes = await pageImage.readAsBytes();
      final pdfImage = pw.MemoryImage(bytes);

      pdf.addPage(
        pw.Page(
          pageFormat: PdfPageFormat.a4,
          margin: pw.EdgeInsets.zero,
          build: (context) {
            return pw.Center(
              child: pw.Image(
                pdfImage,
                fit: pw.BoxFit.contain,
              ),
            );
          },
        ),
      );
    }

    return pdf.save();
  }

  static Future<void> uploadPageImage({
    required String documentId,
    required int pageOrder,
    required File imageFile,
  }) async {
    final client = Supabase.instance.client;
    final userId = client.auth.currentUser?.id;
    if (userId == null) throw Exception('Not authenticated');

    final filePath = 'pages/$documentId/$pageOrder.jpg';
    final bytes = await imageFile.readAsBytes();

    await client.storage.from('documents').uploadBinary(
      filePath,
      bytes,
      fileOptions: const FileOptions(contentType: 'image/jpeg', upsert: true),
    );
  }

  static Future<void> uploadDocumentPdf({
    required String documentId,
    required Uint8List pdfBytes,
  }) async {
    final client = Supabase.instance.client;
    final userId = client.auth.currentUser?.id;
    if (userId == null) throw Exception('Not authenticated');

    final filePath = 'documents/$documentId.pdf';

    await client.storage.from('documents').uploadBinary(
      filePath,
      pdfBytes,
      fileOptions: const FileOptions(contentType: 'application/pdf', upsert: true),
    );
  }

  static Future<List<File>> downloadPageImages(String documentId, int pageCount) async {
    final client = Supabase.instance.client;
    final tempDir = Directory.systemTemp.createTempSync('scan_pages_');
    final files = <File>[];

    for (int i = 1; i <= pageCount; i++) {
      final filePath = 'pages/$documentId/$i.jpg';
      final bytes = await client.storage.from('documents').download(filePath);
      final file = File('${tempDir.path}/$i.jpg');
      await file.writeAsBytes(bytes);
      files.add(file);
    }

    return files;
  }

  static Future<void> deletePageImages(String documentId, int pageCount) async {
    final client = Supabase.instance.client;
    final paths = List.generate(pageCount, (i) => 'pages/$documentId/${i + 1}.jpg');
    await client.storage.from('documents').remove(paths);
  }

  static Future<String> createScanBatch({
    required String documentId,
    required int pageCount,
  }) async {
    final client = Supabase.instance.client;
    final userId = client.auth.currentUser?.id;
    if (userId == null) throw Exception('Not authenticated');

    final result = await client.from('scan_batches').insert({
      'document_id': documentId,
      'scanned_by': userId,
    }).select('id').single();

    return result['id'] as String;
  }

  static Future<void> createScanPages({
    required String batchId,
    required String documentId,
    required int pageCount,
  }) async {
    final client = Supabase.instance.client;
    final pages = List.generate(pageCount, (i) => {
      'batch_id': batchId,
      'document_id': documentId,
      'page_order': i + 1,
      'file_path': 'pages/$documentId/${i + 1}.jpg',
    });
    await client.from('scan_pages').insert(pages);
  }

  static Future<void> createScanPagesForAddition({
    required String batchId,
    required String documentId,
    required int startPageOrder,
    required int newPageCount,
  }) async {
    final client = Supabase.instance.client;
    final pages = List.generate(newPageCount, (i) => {
      'batch_id': batchId,
      'document_id': documentId,
      'page_order': startPageOrder + i,
      'file_path': 'pages/$documentId/${startPageOrder + i}.jpg',
    });
    await client.from('scan_pages').insert(pages);
  }

  static Future<void> updateDocumentPdf({
    required String documentId,
    required int pageCount,
    required int fileSize,
  }) async {
    final client = Supabase.instance.client;
    await client.from('documents').update({
      'file_path': 'documents/$documentId.pdf',
      'page_count': pageCount,
      'file_size': fileSize,
      'updated_at': DateTime.now().toIso8601String(),
    }).eq('id', documentId);
  }
}