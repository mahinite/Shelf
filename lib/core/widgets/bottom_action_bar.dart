import 'package:flutter/material.dart';
import '../theme/app_spacing.dart';
import '../theme/app_text_styles.dart';
import '../theme/shelf_colors.dart';
import 'tactile.dart';

/// The app's persistent bottom action area: Home on the left, a
/// visually prominent Scan action in the center (when enabled), Settings on the right.
class BottomActionBar extends StatelessWidget {
  const BottomActionBar({
    super.key,
    required this.onHomeTap,
    required this.onScanTap,
    required this.onSettingsTap,
    this.showScan = true,
  });

  final VoidCallback onHomeTap;
  final VoidCallback onScanTap;
  final VoidCallback onSettingsTap;
  final bool showScan;

  @override
  Widget build(BuildContext context) {
    final List<Widget> children = [
      Tactile(
        onTap: onHomeTap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.home_outlined, color: context.colors.textPrimary),
            const SizedBox(height: 2),
            Text('Home', style: context.textStyles.metadata(context.colors)),
          ],
        ),
      ),
      if (showScan)
        // Prominent but still simple: solid charcoal circle, no glow,
        // no gradient, no shadow drama.
        Tactile(
          onTap: onScanTap,
          child: Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: context.colors.accent,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.camera_alt,
              color: context.colors.onAccent,
              size: 28,
            ),
          ),
        ),
      Tactile(
        onTap: onSettingsTap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.settings_outlined, color: context.colors.textPrimary),
            const SizedBox(height: 2),
            Text('Settings', style: context.textStyles.metadata(context.colors)),
          ],
        ),
      ),
    ];

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: context.colors.surface,
        border: Border(top: BorderSide(color: context.colors.border, width: 1)),
      ),
      child: SafeArea(
        top: false,
        child: Row(
          mainAxisAlignment: showScan
              ? MainAxisAlignment.spaceBetween
              : MainAxisAlignment.spaceEvenly,
          children: children,
        ),
      ),
    );
  }
}
