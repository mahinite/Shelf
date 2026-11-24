// Conditional export: picks Android implementation on Android, stub elsewhere.
// The Dart compiler selects the appropriate file based on target platform.

export 'scanner_android.dart'
    if (dart.library.io) 'scanner_stub.dart'
    if (dart.library.html) 'scanner_stub.dart';