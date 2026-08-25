import 'package:flutter/material.dart';
import '../models/subject.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/app_scaffold.dart';
import '../../../core/widgets/tactile.dart';
import '../../chapters/screens/chapter_screen.dart';

class SubjectScreen extends StatelessWidget {
  const SubjectScreen({super.key, required this.subject});

  final Subject subject;

  @override
  Widget build(BuildContext context) {
    final accent = AppColors.subjectAccent(subject.name);

    return AppScaffold(
      title: subject.name,
      showBackButton: true,
      body: ListView.separated(
        padding: const EdgeInsets.all(AppSpacing.containerMargin),
        itemCount: subject.chapters.length,
        separatorBuilder: (_, __) => const Divider(),
        itemBuilder: (context, index) {
          final chapter = subject.chapters[index];
          return Tactile(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => ChapterScreen(
                    chapter: chapter,
                    accent: accent,
                  ),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
              child: Row(
                children: [
                  // A small underline-style pip ties the chapter back to
                  // its subject color without any large colored surface.
                  Container(
                    width: 6,
                    height: 6,
                    margin: const EdgeInsets.only(right: AppSpacing.sm),
                    decoration: BoxDecoration(
                      color: accent,
                      shape: BoxShape.circle,
                    ),
                  ),
                  Expanded(
                    child: Text(chapter.name, style: AppTextStyles.body),
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
        },
      ),
    );
  }
}
