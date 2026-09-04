import 'package:flutter/material.dart';

import '../models/document.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/pdf_badge_icon.dart';
import '../../../core/widgets/tactile.dart';

/// A single row representing a document inside a chapter.
class DocumentListItem extends StatelessWidget {
  const DocumentListItem({
    super.key,
    required this.document,
    required this.onTap,
    this.accent,
    this.onLongPress,
  });

  final Document document;
  final VoidCallback onTap;
  final Color? accent;
  final VoidCallback? onLongPress;

  @override
  Widget build(BuildContext context) {
    return Tactile(
      onTap: onTap,
      onLongPress: onLongPress,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: AppSpacing.sm,
        ),
        child: Row(
          children: [
            if (accent != null) ...[
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: accent,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
            ] else ...[
              const PdfBadgeIcon(size: 20),
              const SizedBox(width: AppSpacing.sm),
            ],
            Expanded(
              child: Text(
                document.title,
                style: AppTextStyles.body,
              ),
            ),
            const Icon(
              Icons.chevron_right,
              size: 18,
              color: AppColors.textSecondary,
            ),
          ],
        ),
      ),
    );
  }
}