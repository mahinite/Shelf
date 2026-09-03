import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import '../theme/notebook_background.dart';
import 'bottom_action_bar.dart';
import '../../features/settings/screens/settings_screen.dart';
import 'package:flutter_doc_scanner/flutter_doc_scanner.dart';
import 'package:flutter/services.dart';
import '../../features/documents/screens/scan_config_screen.dart';

/// Shared scaffold for every screen past login: subtle grid background,
/// a plain back-enabled app bar, and the persistent bottom action bar.
/// Kept as one small widget rather than a navigation package/controller —
/// there's no shared state to manage, just a consistent shell.
class AppScaffold extends StatelessWidget {
  const AppScaffold({
    super.key,
    required this.title,
    required this.body,
    this.showBackButton = false,
  });

  final String title;
  final Widget body;
  final bool showBackButton;

  void _goHome(BuildContext context) {
    Navigator.of(context).popUntil((route) => route.isFirst);
  }

void _handleScanTap(BuildContext context) async {
  debugPrint('[scan] _handleScanTap ENTERED, context.mounted=${context.mounted}');
  try {
    debugPrint('[scan] calling FlutterDocScanner().getScannedDocumentAsImages()');
    final dynamic result = await FlutterDocScanner().getScannedDocumentAsImages();
    debugPrint('[scan] scanner returned. result==null? ${result == null}. runtimeType=${result?.runtimeType}. toString="$result"');
    if (result == null) {
      debugPrint('[scan] result is null -> user cancelled, returning');
      return;
    }
    // Resolve scanner result to a list of image file paths.
    List<String> imagePaths;
    if (result is ImageScanResult) {
      imagePaths = result.images;
    } else if (result is List) {
      imagePaths = result.map((e) => e.toString()).toList();
    } else {
      debugPrint('[scan] Unexpected scanner result type: ${result.runtimeType}.');
      return;
    }
    debugPrint('[scan] imagePaths count=${imagePaths.length}');
    // Optionally warn if any element wasn't a string originally (but toString safe).
    if (imagePaths.any((path) => path.isEmpty)) {
      debugPrint('[scan] Scanner returned empty path(s): $imagePaths');
    }
    if (imagePaths.isEmpty) {
      debugPrint('[scan] imagePaths empty after normalization -> returning');
      return;
    }
    debugPrint('[scan] imagePaths=${imagePaths.length} paths. About to call Navigator.push to ScanConfigScreen.');
    // Navigate to configuration screen.
    if (!context.mounted) {
      debugPrint('[scan] context not mounted before push -> returning');
      return;
    }
    debugPrint('[scan] calling Navigator.of(context).push(MaterialPageRoute(builder: ScanConfigScreen))');
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => ScanConfigScreen(imagePaths: imagePaths),
      ),
    );
    debugPrint('[scan] Navigator.push returned (sync). Awaiting frame.');
  } on PlatformException catch (e) {
    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Camera error: ${e.message}'),
        action: SnackBarAction(
          label: 'Open Settings',
          onPressed: () {
            // Placeholder for opening settings.
          },
        ),
      ),
    );
  }
}

  void _goToSettings(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const SettingsScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: showBackButton,
        iconTheme: const IconThemeData(color: AppColors.textPrimary),
        title: Text(title, style: AppTextStyles.sectionTitle),
      ),
      body: NotebookBackground(child: body),
      bottomNavigationBar: BottomActionBar(
        onHomeTap: () => _goHome(context),
        onScanTap: () => _handleScanTap(context),
        onSettingsTap: () => _goToSettings(context),
      ),
    );
  }
}
