import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ota_update/ota_update.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:version/version.dart';

/// Service for checking and applying updates via GitHub Releases and ota_update.
class UpdateService {
  /// The GitHub repository in the format 'owner/repo'.
  static const String _githubRepo = 'mahinite/Shelf';

  /// Checks for updates and shows a dialog if a newer version is available.
  ///
  /// This method should be called after the first frame is rendered (e.g., using
  /// WidgetsBinding.instance.addPostFrameCallback).
  static Future<void> checkForUpdate(BuildContext context) async {
    try {
      // Ignore if the platform is not Android.
      if (!kIsWeb && Platform.isAndroid) {
        final PackageInfo packageInfo = await PackageInfo.fromPlatform();
        final String currentVersion = packageInfo.version;

        // Fetch the latest release from GitHub.
        final http.Response response = await http.get(
          Uri.parse('https://api.github.com/repos/$_githubRepo/releases/latest'),
        ).timeout(const Duration(seconds: 10));

        if (response.statusCode == 200) {
          final Map<String, dynamic> releaseData =
              jsonDecode(response.body) as Map<String, dynamic>;
          final String? tagName = releaseData['tag_name'] as String?;
          final String? downloadUrl = releaseData['assets']
              .firstWhere(
                (asset) => (asset['name'] as String).endsWith('.apk'),
                orElse: () => null,
              )?['browser_download_url'] as String?;

          if (downloadUrl != null && tagName != null && tagName.isNotEmpty) {
            // Strip leading 'v' from tag_name if present.
            String latestVersion = tagName.startsWith('v')
                ? tagName.substring(1)
                : tagName;

            final Version current = Version.parse(currentVersion);
            final Version latest = Version.parse(latestVersion);

            if (latest > current) {
              // Show update dialog.
              if (context.mounted) {
                await showDialog<void>(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext dialogContext) {
                    return AlertDialog(
                      title: Text('Update available (v$latestVersion)'),
                      content: const Text(
                          'A new version of Shelf is available. Would you like to update now?'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.of(dialogContext).pop();
                          },
                          child: const Text('Later'),
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            Navigator.of(dialogContext).pop();
                            // Execute the update.
                            await _executeUpdate(context, downloadUrl);
                          },
                          child: const Text('Update now'),
                        ),
                      ],
                    );
                  },
                );
              }
            }
          }
        }
        // If any step fails, we silently ignore (no-op) as per requirements.
      }
    } catch (e, stack) {
      // Silently ignore any errors to avoid blocking app startup.
      debugPrint('Update check failed: $e');
      debugPrintStack(stackTrace: stack);
    }
  }

  /// Executes the update using ota_update and shows a progress dialog.
  static Future<void> _executeUpdate(
      BuildContext context, String apkDownloadUrl) async {
    try {
      await _showUpdateDialog(context, apkDownloadUrl);
    } catch (e) {
      debugPrint('Update execution failed: $e');
      // Show a failure message to the user.
      if (context.mounted) {
        await showDialog<void>(
          context: context,
          builder: (BuildContext dialogContext) {
            return AlertDialog(
              title: const Text('Update failed'),
              content: Text('An error occurred while updating: $e'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(dialogContext).pop();
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      }
    }
  }

  /// Shows a dialog that displays the update progress and handles success/failure.
  static Future<void> _showUpdateDialog(
      BuildContext context, String apkDownloadUrl) async {
    double? progress;
    String? status;
    bool isCompleted = false;
    bool hasError = false;
    String errorMessage = '';

    // Listen to the OtaUpdate events.
    final StreamSubscription<OtaEvent> subscription =
        OtaUpdate().execute(apkDownloadUrl).listen(
      (OtaEvent event) {
        switch (event.status) {
          case OtaStatus.DOWNLOADING:
            // event.value is a string like "50"
            if (event.value != null) {
              progress = double.parse(event.value!) / 100.0;
              status = 'Downloading... ${event.value}%';
            }
            break;
          case OtaStatus.INSTALLING:
            progress = null;
            status = 'Installing...';
            break;
          case OtaStatus.INSTALLATION_DONE:
            isCompleted = true;
            status = 'Installation successful';
            break;
          case OtaStatus.ALREADY_RUNNING_ERROR:
          case OtaStatus.INSTALLATION_ERROR:
          case OtaStatus.PERMISSION_NOT_GRANTED_ERROR:
          case OtaStatus.INTERNAL_ERROR:
          case OtaStatus.DOWNLOAD_ERROR:
          case OtaStatus.CHECKSUM_ERROR:
          case OtaStatus.CANCELED:
            hasError = true;
            errorMessage = event.value ?? 'Unknown error';
            status = 'Update failed: $errorMessage';
            break;
        }
      },
      onError: (Object e, StackTrace st) {
        hasError = true;
        errorMessage = e.toString();
        status = 'Update failed: $errorMessage';
      },
      onDone: () {
        // If not already completed or errored, we consider it done.
        if (!isCompleted && !hasError) {
          isCompleted = true;
          status = 'Update completed';
        }
      },
    );

    // Show the dialog and wait for it to be dismissed.
    await showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: Text(isCompleted
                  ? 'Update successful'
                  : hasError
                      ? 'Update failed'
                      : 'Updating...'),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
  if (status != null) Text(status!),
  if (progress != null)
    LinearProgressIndicator(value: progress!),
],
                ),
              ),
              actions: <Widget>[
                if (!isCompleted && !hasError)
                  TextButton(
                    onPressed: () {
                      // Cancel the update? ota_update may not support cancellation.
                      // We'll just close the dialog and let it continue in background?
                      // For now, we'll just dismiss.
                      Navigator.of(dialogContext).pop();
                      subscription.cancel();
                    },
                    child: const Text('Cancel'),
                  ),
                if (isCompleted || hasError)
                  TextButton(
                    onPressed: () {
                      Navigator.of(dialogContext).pop();
                    },
                    child: const Text('OK'),
                  ),
              ],
            );
          },
        );
      },
    );

    // Cancel the subscription when the dialog is closed.
    subscription.cancel();
  }
}