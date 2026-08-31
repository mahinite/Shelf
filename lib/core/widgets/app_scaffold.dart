import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import '../theme/notebook_background.dart';
import 'bottom_action_bar.dart';
import '../../features/settings/screens/settings_screen.dart';
import '../../features/documents/screens/scan_entry_screen.dart';

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

  void _handleScanTap(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const ScanEntryScreen()),
    );
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
