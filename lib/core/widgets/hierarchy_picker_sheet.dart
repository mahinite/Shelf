import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../features/rooms/models/room.dart';
import '../../features/rooms/widgets/room_card.dart';
import '../../features/subjects/models/subject.dart';
import '../../features/subjects/widgets/subject_list_item.dart';
import '../../features/chapters/models/chapter.dart';
import '../../features/documents/models/document.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_text_styles.dart';
import '../widgets/tactile.dart';

/// Mode determines the final selection type.
enum HierarchyPickerMode { pickChapter, pickDocument }

/// A reusable hierarchical picker sheet that drills from Rooms → Subjects → Chapters
/// and optionally into Documents. It mirrors the existing UI components.
class HierarchyPickerSheet extends StatefulWidget {
  const HierarchyPickerSheet({
    super.key,
    required this.mode,
    required this.onChapterPicked,
    this.onDocumentPicked,
  });

  final HierarchyPickerMode mode;
  final void Function(Chapter) onChapterPicked;
  final void Function(Document)? onDocumentPicked;

  @override
  State<HierarchyPickerSheet> createState() => _HierarchyPickerSheetState();
}

class _HierarchyPickerSheetState extends State<HierarchyPickerSheet> {
  // 0: rooms, 1: subjects, 2: chapters, 3: documents (only in pickDocument mode)
  int _level = 0;
  List<Room> _rooms = [];
  List<Subject> _subjects = [];
  List<Chapter> _chapters = [];
  List<Document> _documents = [];

  Room? _selectedRoom;
  Subject? _selectedSubject;
  Chapter? _selectedChapter;
  Document? _selectedDocument;
  bool _isLoading = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadRooms();
  }

  Future<void> _loadRooms() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });
    try {
      final supabase = Supabase.instance.client;
      final userId = supabase.auth.currentUser?.id;
      if (userId == null) {
        throw Exception('Not authenticated');
      }
      final data = await supabase
          .from('rooms')
          .select(
            'id, name, created_by, created_at, subjects(count), room_members!inner(user_id)',
          )
          .eq('room_members.user_id', userId)
          .order('created_at', ascending: true);
      setState(() {
        _rooms = (data as List).map((json) => Room.fromJson(json)).toList();
        _level = 0;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to load rooms: $e';
        _isLoading = false;
      });
    }
  }

  Future<void> _loadSubjects(String roomId) async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });
    try {
      final data = await Supabase.instance.client
          .from('subjects')
          .select('id, room_id, name, color, position, created_at, chapters(count)')
          .eq('room_id', roomId)
          .order('position', ascending: true);
      setState(() {
        _subjects = (data as List).map((json) => Subject.fromJson(json)).toList();
        _level = 1;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to load subjects: $e';
        _isLoading = false;
      });
    }
  }

  Future<void> _loadChapters(String subjectId) async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });
    try {
      final data = await Supabase.instance.client
          .from('chapters')
          .select('id, subject_id, name, position, created_at')
          .eq('subject_id', subjectId)
          .order('position', ascending: true);
      setState(() {
        _chapters = (data as List).map((json) => Chapter.fromJson(json)).toList();
        _level = 2;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to load chapters: $e';
        _isLoading = false;
      });
    }
  }

  Future<void> _loadDocuments(String chapterId) async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });
    try {
      final data = await Supabase.instance.client
          .from('documents')
          .select('id, chapter_id, title, created_at, updated_at, file_path, file_size, page_count, position')
          .eq('chapter_id', chapterId)
          .order('position', ascending: true);
      setState(() {
        _documents = (data as List).map((json) => Document.fromJson(json)).toList();
        _level = 3;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to load documents: $e';
        _isLoading = false;
      });
    }
  }

  void _goBack() {
    if (_level == 0) return;
    setState(() {
      if (_level == 3) {
        // back from documents to chapters
        _level = 2;
        _documents = [];
      } else if (_level == 2) {
        // back from chapters to subjects
        _level = 1;
        _chapters = [];
        _selectedChapter = null;
      } else if (_level == 1) {
        // back from subjects to rooms
        _level = 0;
        _subjects = [];
        _selectedSubject = null;
      }
    });
  }

  Widget _buildHeader() {
    String title;
    switch (_level) {
      case 0:
        title = 'Select Room';
        break;
      case 1:
        title = 'Select Subject';
        break;
      case 2:
        title = 'Select Chapter';
        break;
      case 3:
        title = 'Select Document';
        break;
      default:
        title = '';
    }
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.containerMargin),
      child: Row(
        children: [
          if (_level > 0)
            IconButton(
              icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
              onPressed: _goBack,
            ),
          Expanded(
            child: Text(title, style: AppTextStyles.sectionTitle),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          _buildHeader(),
          const Divider(height: 1, thickness: 1),
          Expanded(
            child: _buildBody(),
          ),
          if ((_level == 2 && widget.mode == HierarchyPickerMode.pickChapter) ||
              (_level == 3 && widget.mode == HierarchyPickerMode.pickDocument))
            Padding(
              padding: const EdgeInsets.all(AppSpacing.containerMargin),
              child: Tactile(
                onTap: () {
                  if (widget.mode == HierarchyPickerMode.pickChapter && _selectedChapter != null) {
                    widget.onChapterPicked(_selectedChapter!);
                    Navigator.of(context).pop();
                  } else if (widget.mode == HierarchyPickerMode.pickDocument && _selectedDocument != null) {
                    widget.onDocumentPicked!(_selectedDocument!);
                    Navigator.of(context).pop();
                  }
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
color: ((widget.mode == HierarchyPickerMode.pickChapter && _selectedChapter != null) ||
                             (widget.mode == HierarchyPickerMode.pickDocument && _selectedDocument != null))
                         ? AppColors.primaryButton
                         : AppColors.border,
                    borderRadius: BorderRadius.circular(AppRadius.md),
                  ),
                  child: Text(
                    'Select',
                    style: AppTextStyles.buttonLabel.copyWith(
color: ((widget.mode == HierarchyPickerMode.pickChapter && _selectedChapter != null) ||
                               (widget.mode == HierarchyPickerMode.pickDocument && _selectedDocument != null))
                           ? AppColors.onPrimaryButton
                           : AppColors.textSecondary,
                    ),
                  ),
),
               ),
             ),
         ],
      ),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (_errorMessage != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.containerMargin),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                _errorMessage!,
                style: AppTextStyles.body.copyWith(color: AppColors.destructive),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.md),
              Tactile(
                onTap: () {
                  if (_level == 0) {
                    _loadRooms();
                  } else if (_level == 1 && _selectedRoom != null) {
                    _loadSubjects(_selectedRoom!.id);
                  } else if (_level == 2 && _selectedSubject != null) {
                    _loadChapters(_selectedSubject!.id);
                  } else if (_level == 3 && _selectedChapter != null) {
                    _loadDocuments(_selectedChapter!.id);
                  }
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.lg,
                    vertical: AppSpacing.md,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primaryButton,
                    borderRadius: BorderRadius.circular(AppRadius.md),
                  ),
                  child: Text(
                    'Retry',
                    style: AppTextStyles.buttonLabel.copyWith(
                      color: AppColors.onPrimaryButton,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }
    switch (_level) {
      case 0:
        return ListView.builder(
          padding: const EdgeInsets.all(AppSpacing.containerMargin),
          itemCount: _rooms.length,
          itemBuilder: (c, i) {
            final room = _rooms[i];
            return RoomCard(
              room: room,
              onTap: () {
                _selectedRoom = room;
                _loadSubjects(room.id);
              },
            );
          },
        );
      case 1:
        return ListView.builder(
          padding: const EdgeInsets.all(AppSpacing.containerMargin),
          itemCount: _subjects.length,
          itemBuilder: (c, i) {
            final subject = _subjects[i];
            return SubjectListItem(
              subject: subject,
              onTap: () {
                _selectedSubject = subject;
                _loadChapters(subject.id);
              },
            );
          },
        );
      case 2:
        return ListView.separated(
          padding: const EdgeInsets.all(AppSpacing.containerMargin),
          itemCount: _chapters.length,
          separatorBuilder: (_, __) => const Divider(height: 1),
          itemBuilder: (c, i) {
            final chapter = _chapters[i];
            return ListTile(
              title: Text(chapter.name, style: AppTextStyles.body),
              trailing: _selectedChapter == chapter
                  ? const Icon(Icons.check, color: AppColors.primaryButton)
                  : const Icon(Icons.chevron_right, color: AppColors.textSecondary),
              selected: _selectedChapter == chapter,
              selectedTileColor: AppColors.surfaceCard,
              onTap: () async {
                setState(() => _selectedChapter = chapter);
                if (widget.mode == HierarchyPickerMode.pickChapter) {
                  // wait for user to confirm via Select button
                } else {
                  // pick document mode – load documents
                  await _loadDocuments(chapter.id);
                }
              },
            );
          },
        );
      case 3:
        return ListView.separated(
          padding: const EdgeInsets.all(AppSpacing.containerMargin),
          itemCount: _documents.length,
          separatorBuilder: (_, __) => const Divider(height: 1),
          itemBuilder: (c, i) {
            final doc = _documents[i];
            return ListTile(
              title: Text(doc.title, style: AppTextStyles.body),
              trailing: _selectedDocument == doc
                  ? const Icon(Icons.check, color: AppColors.primaryButton)
                  : const Icon(Icons.chevron_right, color: AppColors.textSecondary),
              selected: _selectedDocument == doc,
              selectedTileColor: AppColors.surfaceCard,
              onTap: () {
                setState(() => _selectedDocument = doc);
              },
            );
          },
        );
      default:
        return const SizedBox.shrink();
    }
  }
}