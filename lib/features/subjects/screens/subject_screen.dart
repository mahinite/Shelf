import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/subject.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/app_scaffold.dart';
import '../../../core/widgets/item_action_sheet.dart';
import '../../../core/widgets/tactile.dart';
import '../../chapters/models/chapter.dart';
import '../../chapters/screens/chapter_screen.dart';

class SubjectScreen extends StatefulWidget {
  const SubjectScreen({
    super.key,
    required this.subject,
  });

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
        .select()
        .eq('subject_id', widget.subject.id)
        .order('position', ascending: true);

    return (data as List).map((json) => Chapter.fromJson(json)).toList();
  }

  Future<void> _createChapter() async {
    final controller = TextEditingController();

    final name = await showDialog<String>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('New Chapter'),
          content: TextField(
            controller: controller,
            autofocus: true,
            decoration: const InputDecoration(
              hintText: 'Chapter name',
            ),
            onSubmitted: (value) {
              final trimmed = value.trim();

              if (trimmed.isNotEmpty) {
                Navigator.of(context).pop(trimmed);
              }
            },
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () {
                final trimmed = controller.text.trim();

                if (trimmed.isNotEmpty) {
                  Navigator.of(context).pop(trimmed);
                }
              },
              child: const Text('Create'),
            ),
          ],
        );
      },
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.dispose();
    });

    if (name == null || name.isEmpty) {
      return;
    }

    try {
      final nextPosition = await _nextChapterPosition();

      await Supabase.instance.client.from('chapters').insert({
        'subject_id': widget.subject.id,
        'name': name,
        'position': nextPosition,
      });

      if (!mounted) return;

      setState(() {
        _chaptersFuture = _loadChapters();
      });
    } catch (error) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Could not create chapter.\n$error'),
        ),
      );
    }
  }

  Future<int> _nextChapterPosition() async {
    final data = await Supabase.instance.client
        .from('chapters')
        .select('position')
        .eq('subject_id', widget.subject.id)
        .order('position', ascending: false)
        .limit(1);

    if (data.isEmpty) {
      return 0;
    }

    return (data.first['position'] as int) + 1;
  }

  Future<void> _renameChapter(Chapter chapter, String newName) async {
    try {
      await Supabase.instance.client
          .from('chapters')
          .update({'name': newName}).eq('id', chapter.id);

      if (!mounted) return;

      setState(() {
        _chaptersFuture = _loadChapters();
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Chapter renamed to $newName')),
        );
      }
    } catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not rename chapter.\n$error')),
      );
    }
  }

  Future<void> _deleteChapter(Chapter chapter) async {
    try {
      await Supabase.instance.client
          .from('chapters')
          .delete()
          .eq('id', chapter.id);

      if (!mounted) return;

      setState(() {
        _chaptersFuture = _loadChapters();
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Chapter deleted')),
        );
      }
    } catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not delete chapter.\n$error')),
      );
    }
  }

  void _showChapterActions(Chapter chapter) {
    showItemActionSheet(
      context: context,
      itemName: chapter.name,
      onRename: () async {
        final controller = TextEditingController(text: chapter.name);
        final name = await showDialog<String>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Rename Chapter'),
            content: TextField(
              controller: controller,
              autofocus: true,
              textCapitalization: TextCapitalization.words,
              decoration: const InputDecoration(hintText: 'Chapter name'),
              onSubmitted: (value) {
                final trimmed = value.trim();
                if (trimmed.isNotEmpty && trimmed != chapter.name) {
                  Navigator.of(context).pop(trimmed);
                } else {
                  Navigator.of(context).pop();
                }
              },
            ),
            actions: [
              TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Cancel')),
              FilledButton(
                onPressed: () {
                  final trimmed = controller.text.trim();
                  if (trimmed.isNotEmpty && trimmed != chapter.name) {
                    Navigator.of(context).pop(trimmed);
                  } else {
                    Navigator.of(context).pop();
                  }
                },
                child: const Text('Save'),
              ),
            ],
          ),
        );
        if (name != null && name.isNotEmpty && name != chapter.name) {
          await _renameChapter(chapter, name);
        }
      },
      onDelete: () async {
        final confirm = await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Delete Chapter?'),
            content: Text(
              'Are you sure you want to delete "${chapter.name}"?\n\n'
              'This will also delete all documents inside this chapter. This cannot be undone.',
            ),
            actions: [
              TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: const Text('Cancel')),
              FilledButton(
                style: FilledButton.styleFrom(backgroundColor: Colors.red[600]),
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text('Delete'),
              ),
            ],
          ),
        );
        if (confirm == true) {
          await _deleteChapter(chapter);
        }
      },
    );
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
                style: AppTextStyles.body,
                textAlign: TextAlign.center,
              ),
            );
          }

          final chapters = snapshot.data ?? [];

          return Stack(
            children: [
              if (chapters.isEmpty)
                const Center(
                  child: Text('No chapters yet.'),
                )
              else
                ListView.separated(
                  padding: const EdgeInsets.all(
                    AppSpacing.containerMargin,
                  ),
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
                      onLongPress: () => _showChapterActions(chapter),
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
                ),
              Positioned(
                right: AppSpacing.containerMargin,
                bottom: AppSpacing.containerMargin,
                child: FloatingActionButton(
                  onPressed: _createChapter,
                  child: const Icon(Icons.add),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
