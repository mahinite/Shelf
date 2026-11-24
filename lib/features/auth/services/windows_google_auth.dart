import 'dart:async';
import 'dart:io';

import 'package:supabase_flutter/supabase_flutter.dart';

/// Windows-specific Google Sign-In using Supabase OAuth (PKCE) via loopback redirect.
class WindowsGoogleAuth {
  WindowsGoogleAuth._();

  static const _ports = [54123, 54124, 54125];
  static const _callbackPath = '/auth-callback';
  static const _timeout = Duration(minutes: 3);

  /// Signs in the user with Google on Windows.
  ///
  /// Opens the default browser to complete Supabase OAuth, then exchanges
  /// the authorization code for a session via a local loopback HTTP server.
  static Future<void> signIn() async {
    final port = await _bindLoopbackServer();
    if (port == null) {
      throw Exception(
        'Another app is using the sign-in port. Close it and try again.',
      );
    }

    final server = await HttpServer.bind(InternetAddress.loopbackIPv4, port);
    final redirectTo = 'http://127.0.0.1:$port$_callbackPath';

    try {
      final launched = await Supabase.instance.client.auth.signInWithOAuth(
        OAuthProvider.google,
        redirectTo: redirectTo,
        authScreenLaunchMode: LaunchMode.externalApplication,
      );

      if (!launched) {
        await server.close();
        throw Exception('Could not open browser for sign-in. Please try again.');
      }

      final code = await _waitForCallback(server).timeout(_timeout);

      if (code == null) {
        throw Exception('Sign-in timed out. Please try again.');
      }

      await Supabase.instance.client.auth.exchangeCodeForSession(code);
    } finally {
      await server.close(force: true);
    }
  }

  static Future<int?> _bindLoopbackServer() async {
    for (final port in _ports) {
      try {
        final testServer = await HttpServer.bind(InternetAddress.loopbackIPv4, port);
        await testServer.close();
        return port;
      } on SocketException {
        // Port in use, try next
        continue;
      }
    }
    return null;
  }

  static Future<String?> _waitForCallback(HttpServer server) async {
    final completer = Completer<String?>();

    void handleRequest(HttpRequest request) {
      if (request.uri.path == _callbackPath) {
        final code = request.uri.queryParameters['code'];
        final error = request.uri.queryParameters['error'];
        final errorDescription = request.uri.queryParameters['error_description'];

        if (error != null || errorDescription != null) {
          _respondWithStaticPage(request, _failureHtml);
          completer.complete(null);
          return;
        }

        if (code != null) {
          _respondWithStaticPage(request, _successHtml);
          completer.complete(code);
          return;
        }

        // No code or error - treat as failure
        _respondWithStaticPage(request, _failureHtml);
        completer.complete(null);
      } else {
        // Ignore other paths (e.g., /favicon.ico)
        request.response.statusCode = HttpStatus.notFound;
        request.response.close();
      }
    }

    server.listen(handleRequest);

    return completer.future;
  }

  static void _respondWithStaticPage(HttpRequest request, String html) {
    request.response.statusCode = HttpStatus.ok;
    request.response.headers.contentType = ContentType.html;
    request.response.write(html);
    request.response.close();
  }

  static const _successHtml = '''
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <title>Signed In</title>
    <style>
      body { font-family: system-ui, sans-serif; padding: 2rem; text-align: center; }
    </style>
  </head>
  <body>
    <h1>Signed in</h1>
    <p>You can close this tab and return to Shelf.</p>
  </body>
</html>
''';

  static const _failureHtml = '''
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <title>Sign-In Failed</title>
    <style>
      body { font-family: system-ui, sans-serif; padding: 2rem; text-align: center; }
    </style>
  </head>
  <body>
    <h1>Sign-In Failed</h1>
    <p>An error occurred. Please close this tab and try again in the app.</p>
  </body>
</html>
''';
}