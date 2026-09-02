import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Singleton client for communicating with the Cloudflare Worker that proxies
/// requests to Backblaze B2. It uses the Supabase session access token for
/// authentication.
class WorkerClient {
  // Private constructor
  WorkerClient._();

  static final WorkerClient instance = WorkerClient._();

  // Resolve the base URL once on first use.
  final String _baseUrl = dotenv.env['WORKER_BASE_URL'] ?? (throw Exception('WORKER_BASE_URL not set in .env'));

  /// Obtain the current Supabase session access token.
  String _accessToken() {
    final token = Supabase.instance.client.auth.currentSession?.accessToken;
    if (token == null) throw Exception('Not authenticated: no Supabase session');
    return token;
  }

  /// PUT bytes to the worker at `$baseUrl/files/<objectPath>`.
  /// Throws a descriptive exception on failure.
  Future<void> putBytes({
    required String objectPath,
    required Uint8List bytes,
    required String contentType,
  }) async {
    final uri = Uri.parse('$_baseUrl/files/$objectPath');
    final request = await HttpClient().putUrl(uri);
    request.headers.set('Authorization', 'Bearer ${_accessToken()}');
    request.headers.set('Content-Type', contentType);
    request.add(bytes);
    final response = await request.close();
    if (response.statusCode < 200 || response.statusCode >= 300) {
      final body = await response.transform(utf8.decoder).join();
      throw Exception('Worker PUT failed ${response.statusCode}: $body');
    }
    await response.drain();
  }

  /// GET bytes from the worker at `$baseUrl/files/<objectPath>`.
  /// Returns the response body as [Uint8List] or throws on error.
  Future<Uint8List> getBytes(String objectPath) async {
    final uri = Uri.parse('$_baseUrl/files/$objectPath');
    final request = await HttpClient().getUrl(uri);
    request.headers.set('Authorization', 'Bearer ${_accessToken()}');
    final response = await request.close();
    if (response.statusCode < 200 || response.statusCode >= 300) {
      final body = await response.transform(utf8.decoder).join();
      throw Exception('Worker GET failed ${response.statusCode}: $body');
    }
    final List<int> data = await response.expand((b) => b).toList();
    return Uint8List.fromList(data);
  }
}
