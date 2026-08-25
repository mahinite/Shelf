import 'package:flutter/material.dart';
import '../models/note.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/app_scaffold.dart';

/// Placeholder document view. This intentionally does NOT build a real
/// PDF viewer or scanned-page renderer — just enough to show the title,
/// page count, and a stand-in for each page.
class NotesScreen extends StatelessWidget {
  const NotesScreen({super.key, required this.document});

  final NoteDocument document;

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: document.title,
      showBackButton: true,
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.containerMargin),
        children: [
          Text(
            '${document.pageCount} page${document.pageCount == 1 ? '' : 's'}',
            style: AppTextStyles.metadata,
          ),
          const SizedBox(height: AppSpacing.lg),
          for (var i = 1; i <= document.pageCount; i++) ...[
            _PlaceholderPage(pageNumber: i),
            const SizedBox(height: AppSpacing.md),
          ],
        ],
      ),
    );
  }
}

class _PlaceholderPage extends StatelessWidget {
  const _PlaceholderPage({required this.pageNumber});

  final int pageNumber;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 3 / 4,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surfaceCard,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.border),
        ),
        alignment: Alignment.center,
        child: Text('Page $pageNumber', style: AppTextStyles.bodySecondary),
      ),
    );
  }
}
