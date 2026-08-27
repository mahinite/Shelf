import 'package:flutter/material.dart';

import '../models/document.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/app_scaffold.dart';

/// Placeholder document view.
///
/// Actual PDF loading and rendering will be added later.
class DocumentScreen extends StatelessWidget {
  const DocumentScreen({
    super.key,
    required this.document,
  });

  final Document document;

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: document.title,
      showBackButton: true,
      body: Padding(
        padding: const EdgeInsets.all(AppSpacing.containerMargin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              document.title,
              style: AppTextStyles.largeTitle,
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              'Document pages will appear here.',
              style: AppTextStyles.bodySecondary,
            ),
          ],
        ),
      ),
    );
  }
}