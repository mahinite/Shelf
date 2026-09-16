import 'package:flutter/material.dart';
import '../models/subject.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/theme/shelf_colors.dart';
import '../../../core/widgets/tactile.dart';

/// A subject's accent color shows up ONLY as a thin 4px left border strip —
/// per the brief, no large colored surfaces or gradients.
class SubjectListItem extends StatelessWidget {
  const SubjectListItem({
    super.key,
    required this.subject,
    required this.onTap,
    this.onLongPress,
  });

  final Subject subject;
  final VoidCallback onTap;
  final VoidCallback? onLongPress;

  @override
  Widget build(BuildContext context) {
    final accent = AppColors.subjectAccent(subject.name);

    return Tactile(
      onTap: onTap,
      onLongPress: onLongPress,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: context.colors.surface,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: context.colors.border),
        ),
        child: Row(
          children: [
            Container(
              width: 4,
              height: 56,
              decoration: BoxDecoration(
                color: accent,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8),
                  bottomLeft: Radius.circular(8),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.md,
                  vertical: AppSpacing.sm,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(subject.name, style: context.textStyles.sectionTitle(context.colors)),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      '${subject.chapterCount ?? 0} chapter${subject.chapterCount == 1 ? '' : 's'}',
                      style: context.textStyles.metadata(context.colors),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: AppSpacing.md),
              child: Icon(Icons.chevron_right, color: context.colors.textSecondary),
            ),
          ],
        ),
      ),
    );
  }
}
