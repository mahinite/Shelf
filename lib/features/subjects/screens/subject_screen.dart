import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/subject.dart';
import '../../../core/services/cache_service.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/theme/shelf_colors.dart';
import '../../../core/widgets/app_scaffold.dart';
import '../../../core/widgets/rename_delete_sheet.dart';
import '../../../core/widgets/tactile.dart';
import '../../chapters/models/chapter.dart';
import '../../chapters/screens/chapter_screen.dart';

class SubjectScreen extends StatefulWidget {
  const SubjectScreen({
    super.key,
    required this.subject,
    required this.roomCreatedBy,
  });

  final Subject subject;
  final String roomCreatedBy;

  @override
  State<SubjectScreen> createState() => _SubjectScreenState();
}

class _SubjectScreenState extends State<SubjectScreen> {
  List<Chapter> _chapters = [];
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final cacheKey = 'chapters_${widget.subject.id}';

    final cached = await CacheService.instance.readList(cacheKey);
    if (!mounted) return;

    if (cached != null) {
      setState(() {
        _chapters = cached.map((json) => Chapter.fromJson(json)).toList();
        _isLoading = false;
        _error = null;
      });
    }

    try {
      final chapters = await _loadChapters();
      if (!mounted) return;
      setState(() {
        _chapters = chapters;
        _isLoading = false;
        _error = null;
      });
      await CacheService.instance.writeList(
        cacheKey,
        chapters.map((c) => c.toJson()).toList(),
      );
    } catch (e) {
      if (!mounted) return;
      if (_chapters.isNotEmpty) {
        return;
      }
      setState(() {
        _error = 'Could not load chapters.\n$e';
        _isLoading = false;
      });
    }
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

      _load();
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

      _load();

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
      final result = await Supabase.instance.client
          .from('chapters')
          .delete()
          .eq('id', chapter.id)
          .select();

      if (!mounted) return;

      if (result.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('You don\'t have permission to delete this chapter')),
        );
        return;
      }

      _load();

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
    final currentUserId = Supabase.instance.client.auth.currentUser?.id;
    final isRoomCreator = currentUserId == widget.roomCreatedBy;

    showRenameDeleteSheet(
      context: context,
      currentName: chapter.name,
      itemType: 'Chapter',
      hasChildren: true,
      onRename: (newName) => _renameChapter(chapter, newName), // rename is allowed for all members
      onDelete: isRoomCreator ? () => _deleteChapter(chapter) : null,
    );
  }

  @override
  Widget build(BuildContext context) {
    final accent = AppColors.subjectAccent(widget.subject.name);

    return AppScaffold(
      title: widget.subject.name,
      showBackButton: true,
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
              ? Center(
                  child: Text(
                    _error!,
                    style: context.textStyles.body(context.colors),
                    textAlign: TextAlign.center,
                  ),
                )
              : Stack(
                  children: [
                    if (_chapters.isEmpty)
                      const Center(child: Text('No chapters yet.'))
                    else
                      ListView.separated(
                        padding: const EdgeInsets.all(
                          AppSpacing.containerMargin,
                        ),
                        itemCount: _chapters.length,
                        separatorBuilder: (_, __) => const Divider(),
                        itemBuilder: (context, index) {
                          final chapter = _chapters[index];

                          return Tactile(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => ChapterScreen(
                                    chapter: chapter,
                                    accent: accent,
                                    roomCreatedBy: widget.roomCreatedBy,
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
                                      style: context.textStyles.body(context.colors),
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
                ),
    );
  }
}
