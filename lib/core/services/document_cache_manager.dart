import 'dart:typed_data';

import 'package:flutter_cache_manager/flutter_cache_manager.dart';

import '../network/worker_client.dart';
import '../../features/documents/models/document.dart';

/// Custom [FileService] that routes cache-miss downloads through the Shelf
/// Worker proxy instead of a plain URL.
///
/// flutter_cache_manager's default HTTP service cannot be used for document
/// fetches: they require a Supabase Bearer token, which
/// [WorkerClient.getBytes] attaches. The `url` argument is actually the B2
/// object path (e.g. `documents/<id>.pdf`), passed via
/// `getSingleFile(objectPath, key: cacheKey)`.
class WorkerFileService extends FileService {
  @override
  Future<FileServiceResponse> get(
    String url, {
    Map<String, String>? headers,
  }) async {
    final bytes = await WorkerClient.instance.getBytes(url);
    return WorkerGetResponse(bytes);
  }
}

/// In-memory [FileServiceResponse] wrapping the bytes returned by the Worker.
/// Mirrors [HttpGetResponse]'s defaults: status 200, no eTag, and a 7-day
/// validity window (the Worker does not send cache-control headers).
class WorkerGetResponse implements FileServiceResponse {
  WorkerGetResponse(this._bytes) : _receivedTime = DateTime.now();

  final Uint8List _bytes;
  final DateTime _receivedTime;

  @override
  Stream<List<int>> get content => Stream<List<int>>.value(_bytes);

  @override
  int? get contentLength => _bytes.length;

  @override
  int get statusCode => 200;

  @override
  DateTime get validTill => _receivedTime.add(const Duration(days: 7));

  @override
  String? get eTag => null;

  @override
  String get fileExtension => '.pdf';
}

/// Singleton cache manager for offline PDF documents.
///
/// Mirrors the singleton pattern used by [WorkerClient]:
/// `DocumentCacheManager._()` private constructor with a single `instance`
/// accessor. PDFs rarely change, so a 30-day stale period with LRU eviction
/// over 50 objects is generous for a personal study app.
class DocumentCacheManager extends CacheManager {
  DocumentCacheManager._()
    : super(
        Config(
          'documentPdfCache',
          stalePeriod: const Duration(days: 30),
          maxNrOfCacheObjects: 50,
          fileService: WorkerFileService(),
        ),
      );

  static final DocumentCacheManager instance = DocumentCacheManager._();

  /// Cache key for [document]. Includes `updatedAt` so a re-uploaded or
  /// updated document is treated as a cache miss and re-fetched instead of
  /// being served stale; entries for previous versions age out via the
  /// package's own LRU/maxNrOfCacheObjects eviction.
  static String cacheKeyFor(Document document) {
    return '${document.id}_${document.updatedAt.millisecondsSinceEpoch}';
  }
}
