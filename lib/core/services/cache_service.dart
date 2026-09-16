import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';

/// Singleton JSON-file cache service.
///
/// Stores list data as JSON files under `<appDocumentsDir>/cache/<key>.json`
/// to support stale-while-revalidate loading on list screens.
///
/// Mirrors the singleton pattern used by [WorkerClient]:
/// `CacheService._()` private constructor with a single `instance` accessor.
class CacheService {
  CacheService._();

  static final CacheService instance = CacheService._();

  /// Resolves (and creates if necessary) the cache directory at
  /// `<appDocumentsDir>/cache`.
  Future<Directory> _getCacheDir() async {
    final base = await getApplicationDocumentsDirectory();
    final cacheDir = Directory('${base.path}/cache');
    if (!await cacheDir.exists()) {
      await cacheDir.create(recursive: true);
    }
    return cacheDir;
  }

  /// Reads a cached list identified by [key].
  ///
  /// Returns the decoded list, or `null` if the file does not exist or
  /// cannot be parsed. Never throws — caching failures must not break
  /// the calling screen.
  Future<List<Map<String, dynamic>>?> readList(String key) async {
    try {
      final cacheDir = await _getCacheDir();
      final file = File('${cacheDir.path}/$key.json');
      if (!await file.exists()) return null;
      final contents = await file.readAsString();
      final data = jsonDecode(contents);
      if (data is! List) return null;
      return data
          .map((e) => Map<String, dynamic>.from(e as Map))
          .toList();
    } catch (e, stack) {
      debugPrint('CacheService.readList failed for key=$key: $e');
      debugPrintStack(stackTrace: stack);
      return null;
    }
  }

  /// Writes [items] to cache under [key], creating the `cache/` subdirectory
  /// if needed. Failures are logged via [debugPrint] rather than rethrown.
  Future<void> writeList(String key, List<Map<String, dynamic>> items) async {
    try {
      final cacheDir = await _getCacheDir();
      final file = File('${cacheDir.path}/$key.json');
      await file.writeAsString(jsonEncode(items));
    } catch (e, stack) {
      debugPrint('CacheService.writeList failed for key=$key: $e');
      debugPrintStack(stackTrace: stack);
    }
  }

  /// Deletes the entire `cache/` directory and all cached files.
  /// Intended to be wired to a Settings "clear cache" button in a later phase.
  Future<void> clearAll() async {
    try {
      final cacheDir = await _getCacheDir();
      if (await cacheDir.exists()) {
        await cacheDir.delete(recursive: true);
      }
    } catch (e, stack) {
      debugPrint('CacheService.clearAll failed: $e');
      debugPrintStack(stackTrace: stack);
    }
  }
}
