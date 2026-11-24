import '../platform/platform_support.dart';

/// Stub implementation of scanner for non-Android platforms.
class ScannerImpl {
  /// Scans a document and returns a list of image file paths.
  /// Returns null on non-Android platforms (scanning not supported).
  Future<List<String>?> scanDocument({int pageLimit = 100}) async {
    if (!PlatformSupport.supportsScan) {
      return null;
    }
    // This should never be reached on non-Android platforms
    // but we keep the method signature for interface consistency
    return null;
  }
}