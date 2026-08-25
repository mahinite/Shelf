import 'package:flutter/material.dart';
import '../models/chapter.dart';
import '../../documents/models/note.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/app_scaffold.dart';
import '../../documents/widgets/document_list_item.dart';
import '../../documents/screens/notes_screen.dart';

class ChapterScreen extends StatelessWidget {
  const ChapterScreen({super.key, required this.chapter, required this.accent});

  final Chapter chapter;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    final hasExercises = chapter.exercises.isNotEmpty;

    return AppScaffold(
      title: chapter.name,
      showBackButton: true,
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.containerMargin),
        children: [
          DocumentListItem(
            document: chapter.notes,
            onTap: () => _openNotes(context, chapter.notes),
          ),
          // Exercises are optional — this whole section simply doesn't
          // render when a chapter has none, per the brief.
          if (hasExercises) ...[
            const SizedBox(height: AppSpacing.lg),
            Text('Exercises', style: AppTextStyles.sectionTitle),
            const SizedBox(height: AppSpacing.sm),
            for (final exercise in chapter.exercises)
              DocumentListItem(
                document: exercise,
                accent: accent,
                onTap: () => _openNotes(context, exercise),
              ),
          ],
        ],
      ),
    );
  }

  void _openNotes(BuildContext context, NoteDocument document) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => NotesScreen(document: document)),
    );
  }
}
