import 'package:flutter/material.dart';
import '../models/note.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/tactile.dart';

/// A single row representing a document (Notes or an Exercise) inside
/// a chapter. Plain divider-separated row — no card chrome — so the
/// document content it links to stays the visual focus, not the list.
class DocumentListItem extends StatelessWidget {
  const DocumentListItem({
    super.key,
    required this.document,
    required this.onTap,
    this.accent,
  });

  final NoteDocument document;
  final VoidCallback onTap;

  /// Optional small accent pip (used for exercises within a subject's
  /// chapter, if you want to tie it back to the subject color subtly).
  final Color? accent;

  @override
  Widget build(BuildContext context) {
    return Tactile(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
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
            ] else
              const Icon(
                Icons.description_outlined,
                size: 20,
                color: AppColors.textSecondary,
              ),
            if (accent == null) const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: Text(document.title, style: AppTextStyles.body),
            ),
            Text(
              '${document.pageCount} pages',
              style: AppTextStyles.metadata,
            ),
            const SizedBox(width: AppSpacing.xs),
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
