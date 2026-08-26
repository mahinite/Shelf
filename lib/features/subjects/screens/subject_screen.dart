import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/subject.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/app_scaffold.dart';
import '../../../core/widgets/tactile.dart';
import '../../chapters/models/chapter.dart';
import '../../chapters/screens/chapter_screen.dart';

class SubjectScreen extends StatefulWidget {
  const SubjectScreen({super.key, required this.subject});

  final Subject subject;

  @override
  State<SubjectScreen> createState() => _SubjectScreenState();
}

class _SubjectScreenState extends State<SubjectScreen> {
  late Future<List<Chapter>> _chaptersFuture;

  @override
  void initState() {
    super.initState();
    _chaptersFuture = _loadChapters();
  }

  Future<List<Chapter>> _loadChapters() async {
    final data = await Supabase.instance.client
        .from('chapters')
        .select('*')
        .eq('subject_id', widget.subject.id)
        .order('position', ascending: true);

    return (data as List)
        .map((json) => Chapter.fromJson(json))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final accent = AppColors.subjectAccent(widget.subject.name);

    return AppScaffold(
      title: widget.subject.name,
      showBackButton: true,
      body: FutureBuilder<List<Chapter>>(
        future: _chaptersFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(
                'Could not load chapters.\n${snapshot.error}',
                textAlign: TextAlign.center,
              ),
            );
          }

          final chapters = snapshot.data ?? [];

          if (chapters.isEmpty) {
            return const Center(
              child: Text('No chapters yet.'),
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.all(AppSpacing.containerMargin),
            itemCount: chapters.length,
            separatorBuilder: (_, __) => const Divider(),
            itemBuilder: (context, index) {
              final chapter = chapters[index];

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
                  padding: const EdgeInsets.symmetric(
                    vertical: AppSpacing.sm,
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 6,
                        height: 6,
                        margin: const EdgeInsets.only(
                          right: AppSpacing.sm,
                        ),
                        decoration: BoxDecoration(
                          color: accent,
                          shape: BoxShape.circle,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          chapter.name,
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
            },
          );
        },
      ),
    );
  }
}