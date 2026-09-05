import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';

class CrashLogger {
  static const int _maxFileSize = 1024 * 1024; // ~1MB
  static const String _logFileName = 'crash_log.txt';

  static Future<File> _getLogFile() async {
    final directory = await getApplicationDocumentsDirectory();
    return File('${directory.path}/$_logFileName');
  }

  static Future<void> logError(Object error, StackTrace stackTrace) async {
    try {
      final file = await _getLogFile();
      final timestamp = DateTime.now().toIso8601String();
      final entry =
          '=== $timestamp ===\nError: $error\nStackTrace:\n$stackTrace\n\n';

      await _appendAndTruncate(file, entry);
    } catch (e) {
      // If logging fails, we can't do much — fail silently to avoid recursion
      debugPrint('CrashLogger failed to write: $e');
    }
  }

  static Future<void> _appendAndTruncate(File file, String newEntry) async {
    final exists = await file.exists();
    String content = '';

    if (exists) {
      content = await file.readAsString();
    }

    content += newEntry;

    // Truncate if over size limit — keep newest entries
    if (content.length > _maxFileSize) {
      // Find the first '=== ' after we've removed enough to be under limit
      final targetLength = _maxFileSize - newEntry.length;
      if (targetLength > 0) {
        final cutIndex = content.indexOf('=== ', content.length - targetLength);
        if (cutIndex > 0) {
          content = content.substring(cutIndex);
        }
      }
    }

    await file.writeAsString(content);
  }

  static Future<String> readLogs() async {
    try {
      final file = await _getLogFile();
      if (await file.exists()) {
        return await file.readAsString();
      }
      return 'No crash logs found.';
    } catch (e) {
      return 'Error reading crash logs: $e';
    }
  }

  static Future<void> clearLogs() async {
    try {
      final file = await _getLogFile();
      if (await file.exists()) {
        await file.delete();
      }
    } catch (e) {
      debugPrint('CrashLogger failed to clear: $e');
    }
  }

  static Future<File> getLogFile() async {
    return _getLogFile();
  }
}