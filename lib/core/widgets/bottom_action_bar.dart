import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_text_styles.dart';
import 'tactile.dart';

/// The app's persistent bottom action area: Home on the left, a
/// visually prominent Scan action on the right. Scan doesn't do
/// anything yet — it's wired up but intentionally inert.
class BottomActionBar extends StatelessWidget {
  const BottomActionBar({
    super.key,
    required this.onHomeTap,
    required this.onScanTap,
    required this.onSettingsTap,
  });

  final VoidCallback onHomeTap;
  final VoidCallback onScanTap;
  final VoidCallback onSettingsTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.sm,
      ),
      decoration: const BoxDecoration(
        color: AppColors.surfaceCard,
        border: Border(top: BorderSide(color: AppColors.border, width: 1)),
      ),
      child: SafeArea(
        top: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Tactile(
              onTap: onHomeTap,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.home_outlined, color: AppColors.textPrimary),
                  const SizedBox(height: 2),
                  Text('Home', style: AppTextStyles.metadata),
                ],
              ),
            ),
            // Prominent but still simple: solid charcoal circle, no glow,
            // no gradient, no shadow drama.
            Tactile(
              onTap: onScanTap,
              child: Container(
                width: 56,
                height: 56,
                decoration: const BoxDecoration(
                  color: AppColors.primaryButton,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.add,
                  color: AppColors.onPrimaryButton,
                  size: 28,
                ),
              ),
            ),
            Tactile(
              onTap: onSettingsTap,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.settings_outlined, color: AppColors.textPrimary),
                  const SizedBox(height: 2),
                  Text('Settings', style: AppTextStyles.metadata),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
