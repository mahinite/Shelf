import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../features/rooms/models/room.dart';
import '../../features/rooms/widgets/room_card.dart';
import '../../features/subjects/models/subject.dart';
import '../../features/subjects/widgets/subject_list_item.dart';
import '../../features/chapters/models/chapter.dart';
import '../../features/documents/models/document.dart';
import '../../features/documents/widgets/document_list_item.dart';
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

  @override
  void initState() {
    super.initState();
    _loadRooms();
  }

  Future<void> _loadRooms() async {
    final data = await Supabase.instance.client
        .from('rooms')
        .select('id, name, subject_count')
        .order('position', ascending: true);
    setState(() {
      _rooms = (data as List).map((json) => Room.fromJson(json)).toList();
      _level = 0;
    });
  }

  Future<void> _loadSubjects(String roomId) async {
    final data = await Supabase.instance.client
        .from('subjects')
        .select('id, name, chapter_count')
        .eq('room_id', roomId)
        .order('position', ascending: true);
    setState(() {
      _subjects = (data as List).map((json) => Subject.fromJson(json)).toList();
      _level = 1;
    });
  }

  Future<void> _loadChapters(String subjectId) async {
    final data = await Supabase.instance.client
        .from('chapters')
        .select('id, name, position')
        .eq('subject_id', subjectId)
        .order('position', ascending: true);
    setState(() {
      _chapters = (data as List).map((json) => Chapter.fromJson(json)).toList();
      _level = 2;
    });
  }

  Future<void> _loadDocuments(String chapterId) async {
    final data = await Supabase.instance.client
        .from('documents')
        .select('id, title, page_count, chapter_id')
        .eq('chapter_id', chapterId)
        .order('position', ascending: true);
    setState(() {
      _documents = (data as List).map((json) => Document.fromJson(json)).toList();
      _level = 3;
    });
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
        ],
      ),
    );
  }

  Widget _buildBody() {
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
              trailing: const Icon(Icons.chevron_right, color: AppColors.textSecondary),
              onTap: () async {
                _selectedChapter = chapter;
                if (widget.mode == HierarchyPickerMode.pickChapter) {
                  widget.onChapterPicked(chapter);
                  Navigator.of(context).pop();
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
            return DocumentListItem(
              document: doc,
              accent: null,
              onTap: () {
                if (widget.onDocumentPicked != null) {
                  widget.onDocumentPicked!(doc);
                  Navigator.of(context).pop();
                }
              },
            );
          },
        );
      default:
        return const SizedBox.shrink();
    }
  }
}
