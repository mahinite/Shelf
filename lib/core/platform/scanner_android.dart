import 'package:flutter/services.dart';
import 'package:flutter_doc_scanner/flutter_doc_scanner.dart';

import '../platform/platform_support.dart';

/// Android implementation of scanner using FlutterDocScanner.
class ScannerImpl {
  /// Scans a document and returns a list of image file paths.
  /// Returns null if cancelled or on error.
  Future<List<String>?> scanDocument({int pageLimit = 100}) async {
    if (!PlatformSupport.supportsScan) {
      return null;
    }

    try {
      final dynamic result = await FlutterDocScanner().getScannedDocumentAsImages(page: pageLimit);
      if (result == null) return null;

      List<String> imagePaths;
      if (result is ImageScanResult) {
        imagePaths = result.images;
      } else if (result is List) {
        imagePaths = result.map((e) => e.toString()).toList();
      } else {
        return null;
      }
      if (imagePaths.any((path) => path.isEmpty)) return null;
      if (imagePaths.isEmpty) return null;
      return imagePaths;
    } on PlatformException {
      return null;
    }
  }
}