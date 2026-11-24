import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/app_text_styles.dart';
import '../theme/notebook_background.dart';
import '../theme/shelf_colors.dart';
import 'bottom_action_bar.dart';
import '../../features/settings/screens/settings_screen.dart';
import '../../features/documents/screens/scan_config_screen.dart';
import '../../core/platform/platform_support.dart';
import '../../core/platform/scanner.dart';

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
    this.actions,
  });

  final String title;
  final Widget body;
  final bool showBackButton;
  final List<Widget>? actions;

  void _goHome(BuildContext context) {
    Navigator.of(context).popUntil((route) => route.isFirst);
  }

void _handleScanTap(BuildContext context) async {
  debugPrint('[scan] _handleScanTap ENTERED, context.mounted=${context.mounted}');
  final scanner = ScannerImpl();
  final imagePaths = await scanner.scanDocument(pageLimit: 100);
  debugPrint('[scan] scanner returned. imagePaths==null? ${imagePaths == null}.count=${imagePaths?.length}');
  if (imagePaths == null || imagePaths.isEmpty) {
    debugPrint('[scan] no images -> user cancelled or unsupported, returning');
    return;
  }
  debugPrint('[scan] imagePaths count=${imagePaths.length}');
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
}

  void _goToSettings(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const SettingsScreen()),
    );
  }

  bool _canGoBack(BuildContext context) {
    final route = ModalRoute.of(context);
    return route != null && route.isCurrent && Navigator.of(context).canPop();
  }

  void _handleBack(BuildContext context) {
    if (_canGoBack(context)) {
      Navigator.of(context).maybePop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool canScan = PlatformSupport.supportsScan;
    final bool isDesktop = PlatformSupport.isDesktop;
    final bool enableBackShortcuts = showBackButton && isDesktop;

    Widget child = NotebookBackground(child: body);

    if (enableBackShortcuts) {
      child = Focus(
        autofocus: false,
        canRequestFocus: false,
        descendantsAreFocusable: true,
        descendantsAreTraversable: true,
        child: CallbackShortcuts(
          bindings: {
            const SingleActivator(LogicalKeyboardKey.escape): () => _handleBack(context),
            const SingleActivator(LogicalKeyboardKey.arrowLeft, alt: true): () => _handleBack(context),
          },
          child: child,
        ),
      );
    }

    return Scaffold(
      backgroundColor: context.colors.background,
      appBar: AppBar(
        backgroundColor: context.colors.background,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: showBackButton,
        iconTheme: IconThemeData(color: context.colors.textPrimary),
        title: Text(title, style: context.textStyles.sectionTitle(context.colors)),
        actions: actions,
      ),
      body: child,
      bottomNavigationBar: BottomActionBar(
        onHomeTap: () => _goHome(context),
        onScanTap: canScan ? () => _handleScanTap(context) : () {},
        onSettingsTap: () => _goToSettings(context),
        showScan: canScan,
      ),
    );
  }
}
