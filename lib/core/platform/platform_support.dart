import 'dart:io' show Platform;

import 'package:flutter/foundation.dart' show kIsWeb;

/// Centralized platform capability checks.
/// All feature code must use these getters instead of direct `Platform.isX` checks.
class PlatformSupport {
  PlatformSupport._();

  /// True when running on Android.
  static bool get isAndroid => !kIsWeb && Platform.isAndroid;

  /// True when running on Windows.
  static bool get isWindows => !kIsWeb && Platform.isWindows;

  /// True when running on a desktop platform (Windows, macOS, Linux).
  static bool get isDesktop => !kIsWeb && (Platform.isWindows || Platform.isMacOS || Platform.isLinux);

  /// True only on Android — scanning uses FlutterDocScanner which is Android-only.
  static bool get supportsScan => isAndroid;

  /// True only on Android — native Google Sign-In via google_sign_in plugin.
  /// On Windows/web we will use a different auth flow (Phase 3).
  static bool get supportsNativeGoogleSignIn => isAndroid;

  /// True only on Android — OTA updates via ota_update package (APK only).
  static bool get supportsOtaUpdate => isAndroid;
}