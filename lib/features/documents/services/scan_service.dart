import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/foundation.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf_combiner/pdf_combiner.dart';
import 'package:pdf_combiner/models/merge_input.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:shelf/core/network/worker_client.dart';


/// Service handling scan‑related uploads and PDF generation.
class ScanService {
  ScanService._();

  /// Max pixel dimension for processed images. Lowered to 1600 for low-end
  /// device memory/CPU headroom; tune upward if quality demands it.
  static const int maxDimension = 1600;

  /// JPEG quality for processed page images. Conservative 75 to bound
  /// encode size and CPU on weak devices; tune if needed.
  /// This is now the ONLY lossy pass (native downscale uses this quality).
  static const int jpegQuality = 75;

  /// Fallback threshold: if source exceeds this and native compression fails,
  /// throw instead of falling back (4 MB guess; tune from SHELF_PERF logs).
  static const int _fallbackMaxBytes = 4 * 1024 * 1024;

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
  /// The image at imagePath is expected to be a JPEG (from native downscale or scanner).
  /// No decode/resize/filter/re-encode — embed JPEG bytes directly.
  static Future<String> processPageToTempPdf(Map<String, Object> args) async {
    final String imagePath = args['imagePath'] as String;
    final int index = args['index'] as int;
    final resolvedPath = imagePath.startsWith('file://')
        ? Uri.parse(imagePath).toFilePath()
        : imagePath;

    final totalSw = Stopwatch()..start();

    final readSw = Stopwatch()..start();
    final bytes = await File(resolvedPath).readAsBytes();
    final readMs = readSw.elapsedMilliseconds;

    // Embed JPEG bytes directly — MemoryImage reads EXIF orientation and embeds raw
    final pdfDoc = pw.Document();
    final imgPdf = pw.MemoryImage(bytes);
    pdfDoc.addPage(pw.Page(
      pageFormat: PdfPageFormat.a4,
      margin: pw.EdgeInsets.zero,
      build: (c) => pw.Center(child: pw.Image(imgPdf, fit: pw.BoxFit.contain)),
    ));

    final pdfSw = Stopwatch()..start();
    final pdfBytes = await pdfDoc.save();
    final pdfMs = pdfSw.elapsedMilliseconds;

    // Write to unique temp file
    final tempDir = Directory.systemTemp;
    final tempFile = File('${tempDir.path}/scan_page_${index}_${DateTime.now().microsecondsSinceEpoch}.pdf');
    final writeSw = Stopwatch()..start();
    await tempFile.writeAsBytes(pdfBytes);
    final writeMs = writeSw.elapsedMilliseconds;

    final totalMs = totalSw.elapsedMilliseconds;
    debugPrint('SHELF_PERF page=$index read_bytes=${bytes.length} read_ms=$readMs pdf_bytes=${pdfBytes.length} pdf_ms=$pdfMs write_ms=$writeMs total_ms=$totalMs');
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

  /// Native downscale + process page to temp PDF.
  static Future<String> _processPage({
    required String imagePath,
    required int index,
    required Directory workDir,
  }) async {
    // a. Resolve file:// URIs exactly as line 45 does
    final resolvedPath = imagePath.startsWith('file://')
        ? Uri.parse(imagePath).toFilePath()
        : imagePath;

    // b. Read pixel dimensions WITHOUT decoding pixels
    int? srcWidth;
    int? srcHeight;
    ui.ImmutableBuffer? buffer;
    ui.ImageDescriptor? descriptor;
    try {
      buffer = await ui.ImmutableBuffer.fromFilePath(resolvedPath);
      descriptor = await ui.ImageDescriptor.encoded(buffer);
      srcWidth = descriptor.width.toInt();
      srcHeight = descriptor.height.toInt();
    } catch (_) {
      // Treat dimensions as unknown
    } finally {
      descriptor?.dispose();
      buffer?.dispose();
    }

    // c. If dimensions known and max(w,h) <= maxDimension: SKIP native compression
    if (srcWidth != null && srcHeight != null) {
      final maxDim = srcWidth > srcHeight ? srcWidth : srcHeight;
      if (maxDim <= maxDimension) {
        final srcBytes = await File(resolvedPath).length();
        final scheme = imagePath.startsWith('file://') ? 'file' : imagePath.startsWith('content://') ? 'content' : 'plain';
        debugPrint('SHELF_PERF page=$index scheme=$scheme skip_native src_w=$srcWidth src_h=$srcHeight src_bytes=$srcBytes');
        // Use original path unchanged; let processPageToTempPdf handle it
        return compute(processPageToTempPdf, {'imagePath': resolvedPath, 'index': index});
      }
    }

    // d. Compute sampleSize = largest power of two (1,2,4,8) such that
    //    max(w,h)/sampleSize >= maxDimension. Use 1 if dimensions unknown.
    int sampleSize = 1;
    if (srcWidth != null && srcHeight != null) {
      final maxDim = srcWidth > srcHeight ? srcWidth : srcHeight;
      while (sampleSize < 8 && (maxDim / (sampleSize * 2)) >= maxDimension) {
        sampleSize <<= 1;
      }
    }

    // e. Target path inside workDir, different from source, ends in .jpg
    final targetPath = '${workDir.path}/page_${index}_downscaled_${DateTime.now().microsecondsSinceEpoch}.jpg';

    // f. Call native compression
    final nativeSw = Stopwatch()..start();
    String? compressedPath;
    String? nativeErrorType;
    try {
      final result = await FlutterImageCompress.compressAndGetFile(
        resolvedPath,
        targetPath,
        minWidth: maxDimension,
        minHeight: maxDimension,
        quality: jpegQuality,
        inSampleSize: sampleSize,
        keepExif: false,
        autoCorrectionAngle: true,
        format: CompressFormat.jpeg,
      );
      compressedPath = result?.path;
    } catch (e) {
      nativeErrorType = e.runtimeType.toString();
    }
    final nativeMs = nativeSw.elapsedMilliseconds;

    // Unified handler for: exception thrown OR null result
    if (compressedPath == null) {
      final srcBytes = await File(resolvedPath).length();
      if (srcBytes > _fallbackMaxBytes) {
        throw Exception('Couldn\'t process page ${index + 1}: image too large for this device');
      }
      if (nativeErrorType != null) {
        debugPrint('SHELF_PERF page=$index native_error_type=$nativeErrorType fallback src_bytes=$srcBytes');
      } else {
        debugPrint('SHELF_PERF page=$index native_null fallback src_bytes=$srcBytes');
      }
    }

    String chosenPath;
    int outWidth = 0;
    int outHeight = 0;
    int outBytes = 0;

    if (compressedPath != null) {
      // Read output header for logging
      try {
        final outBuffer = await ui.ImmutableBuffer.fromFilePath(compressedPath);
        final outDescriptor = await ui.ImageDescriptor.encoded(outBuffer);
        outWidth = outDescriptor.width.toInt();
        outHeight = outDescriptor.height.toInt();
        outDescriptor.dispose();
        outBuffer.dispose();
      } catch (_) {}
      outBytes = await File(compressedPath).length();
      chosenPath = compressedPath;
    } else {
      // Fallback to original
      chosenPath = resolvedPath;
      final srcBytes = await File(resolvedPath).length();
      outBytes = srcBytes;
    }

    // g. Log native step — include scheme= field
    final scheme = imagePath.startsWith('file://') ? 'file' : imagePath.startsWith('content://') ? 'content' : 'plain';
    debugPrint('SHELF_PERF page=$index scheme=$scheme src_w=${srcWidth ?? 0} src_h=${srcHeight ?? 0} sampleSize=$sampleSize out_w=$outWidth out_h=$outHeight out_bytes=$outBytes native_ms=$nativeMs');

    // h. Run processPageToTempPdf in isolate, cleanup downscaled file in finally
    try {
      return await compute(processPageToTempPdf, {'imagePath': chosenPath, 'index': index});
    } finally {
      if (compressedPath != null) {
        try {
          await File(compressedPath).delete();
        } catch (_) {}
      }
    }
  }

  /// Upload a brand‑new document.
  static Future<void> uploadNewDocument({
    required List<String> imagePaths,
    required String title,
    required String chapterId,
    void Function(int current, int total)? onProgress,
  }) async {
    final saveSw = Stopwatch()..start();

    // 1. Insert document row first (needed for object path)
    final documentId = await _createDocument(chapterId: chapterId, title: title);

    // Variables needed in finally
    final pagePdfPaths = <String>[];
    Directory? tempDir;
    bool uploadSucceeded = false;

    try {
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

      // Create temp dir inside try so finally can clean it up if needed
      tempDir = Directory.systemTemp.createTempSync('pdf_merge_temp.');

      // 4. Process each page in an isolate, writing single-page PDFs to temp files.
      // Sequential only — concurrent isolates each holding a full-res image spikes memory.
      final loopSw = Stopwatch()..start();
      for (int i = 0; i < imagePaths.length; i++) {
        onProgress?.call(i + 1, imagePaths.length);
        final path = await _processPage(
          imagePath: imagePaths[i],
          index: i,
          workDir: tempDir,
        );
        pagePdfPaths.add(path);
      }
      final loopMs = loopSw.elapsedMilliseconds;
      debugPrint('SHELF_PERF loop_pages=${imagePaths.length} loop_ms=$loopMs');

      // 5. Merge all single-page PDFs into final PDF via PdfCombiner (temp files).
      Uint8List mergedPdf;
      final outputFile = File('${tempDir.path}/merged.pdf');
      final mergeSw = Stopwatch()..start();
      await PdfCombiner.mergeMultiplePDFs(
        inputs: pagePdfPaths.map((p) => MergeInput.path(p)).toList(),
        outputPath: outputFile.path,
      );
      final mergeMs = mergeSw.elapsedMilliseconds;
      mergedPdf = await outputFile.readAsBytes();
      debugPrint('SHELF_PERF merge_ms=$mergeMs merged_bytes=${mergedPdf.length}');

      // 6. Upload merged PDF
      final uploadSw = Stopwatch()..start();
      await _uploadPdf(objectPath: objectPath, pdfBytes: mergedPdf);
      final uploadMs = uploadSw.elapsedMilliseconds;
      debugPrint('SHELF_PERF upload_ms=$uploadMs');
      uploadSucceeded = true;

      // 7. Update document metadata
      await _updateDocument(
        documentId: documentId,
        pageCount: pagePdfPaths.length,
        fileSize: mergedPdf.length,
        filePath: objectPath,
      );
    } catch (e) {
      if (!uploadSucceeded) {
        // Cleanup on upload failure - delete document row only (cascades to scan_batches, scan_pages)
        final client = Supabase.instance.client;
        try {
          final docResult = await client
              .from('documents')
              .delete()
              .eq('id', documentId)
              .select();
          if ((docResult as List).isEmpty) {
            debugPrint('Warning: documents delete returned 0 rows for document $documentId');
          }
        } catch (_) {
          // Ignore cleanup errors, don't mask original
        }
      }
      rethrow; // Preserve original exception
    } finally {
      // Clean up all per-page temp files and merge temp dir
      for (final p in pagePdfPaths) {
        try {
          await File(p).delete();
        } catch (_) {}
      }
      try {
        await tempDir?.delete(recursive: true);
      } catch (_) {}
    }

    final saveTotalMs = saveSw.elapsedMilliseconds;
    debugPrint('SHELF_PERF save_total_ms=$saveTotalMs pages=${imagePaths.length}');
  }

  /// Append images to an existing document.
  static Future<void> uploadToExistingDocument({
    required List<String> imagePaths,
    required String documentId,
    void Function(int current, int total)? onProgress,
  }) async {
    final saveSw = Stopwatch()..start();

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
    final tempDir = Directory.systemTemp.createTempSync('pdf_merge_temp.');
    final newPagePdfPaths = <String>[];
    try {
      final loopSw = Stopwatch()..start();
      for (int i = 0; i < imagePaths.length; i++) {
        onProgress?.call(i + 1, imagePaths.length);
        final path = await _processPage(
          imagePath: imagePaths[i],
          index: i,
          workDir: tempDir,
        );
        newPagePdfPaths.add(path);
      }
      final loopMs = loopSw.elapsedMilliseconds;
      debugPrint('SHELF_PERF loop_pages=${imagePaths.length} loop_ms=$loopMs');

      // 5. Write existing PDF to a temp file, then merge it with all new single-page PDFs
      // directly — skipping the intermediate "build one big new-pages PDF" step.
      final existingFile = File('${tempDir.path}/existing.pdf');
      await existingFile.writeAsBytes(existingPdf);
      final existingPdfTempPath = existingFile.path;

      final outputFile = File('${tempDir.path}/merged.pdf');
      final inputs = <MergeInput>[MergeInput.path(existingPdfTempPath)];
      inputs.addAll(newPagePdfPaths.map((p) => MergeInput.path(p)));

      final mergeSw = Stopwatch()..start();
      await PdfCombiner.mergeMultiplePDFs(
        inputs: inputs,
        outputPath: outputFile.path,
      );
      final mergeMs = mergeSw.elapsedMilliseconds;
      final mergedPdf = await outputFile.readAsBytes();
      debugPrint('SHELF_PERF merge_ms=$mergeMs merged_bytes=${mergedPdf.length}');

      // 6. Upload merged PDF to the same object path (overwrite)
      final uploadSw = Stopwatch()..start();
      await _uploadPdf(objectPath: filePath, pdfBytes: mergedPdf);
      final uploadMs = uploadSw.elapsedMilliseconds;
      debugPrint('SHELF_PERF upload_ms=$uploadMs');

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
      try {
        await File('${tempDir.path}/existing.pdf').delete();
      } catch (_) {}
      try {
        await tempDir.delete(recursive: true);
      } catch (_) {}
    }

    final saveTotalMs = saveSw.elapsedMilliseconds;
    debugPrint('SHELF_PERF save_total_ms=$saveTotalMs pages=${imagePaths.length}');
  }
}