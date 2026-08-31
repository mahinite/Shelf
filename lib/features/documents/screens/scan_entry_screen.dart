import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/app_scaffold.dart';
import '../../../core/widgets/tactile.dart';
import '../../chapters/models/chapter.dart';
import '../../documents/models/document.dart';
import '../../documents/screens/new_document_capture_screen.dart';
import '../../documents/screens/add_to_existing_capture_screen.dart';

class ScanEntryScreen extends StatefulWidget {
  const ScanEntryScreen({super.key});

  @override
  State<ScanEntryScreen> createState() => _ScanEntryScreenState();
}

class _ScanEntryScreenState extends State<ScanEntryScreen> {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Scan Document',
      showBackButton: true,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.containerMargin),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.document_scanner_outlined,
                size: 64,
                color: AppColors.primaryButton,
              ),
              const SizedBox(height: AppSpacing.xl),
              Text(
                'Start a new scan',
                style: AppTextStyles.largeTitle,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.md),
              Text(
                'Choose how you want to save the scanned pages',
                style: AppTextStyles.bodySecondary,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.xxl),
              _buildOptionButton(
                icon: Icons.note_add_outlined,
                title: 'New Document',
                subtitle: 'Create a new document from scanned pages',
                onTap: _startNewDocumentFlow,
              ),
              const SizedBox(height: AppSpacing.md),
              _buildOptionButton(
                icon: Icons.note_alt_outlined,
                title: 'Add to Existing Document',
                subtitle: 'Append scanned pages to an existing document',
                onTap: _startAddToExistingFlow,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOptionButton({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Tactile(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(AppSpacing.lg),
        decoration: BoxDecoration(
          color: AppColors.surfaceCard,
          border: Border.all(color: AppColors.border, width: 1),
          borderRadius: BorderRadius.circular(AppRadius.md),
        ),
        child: Row(
          children: [
            Icon(icon, size: 28, color: AppColors.primaryButton),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: AppTextStyles.body.copyWith(fontWeight: FontWeight.w500)),
                  const SizedBox(height: 2),
                  Text(subtitle, style: AppTextStyles.metadata),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: AppColors.textSecondary),
          ],
        ),
      ),
    );
  }

  Future<void> _startNewDocumentFlow() async {
    final client = Supabase.instance.client;
    final userId = client.auth.currentUser?.id;
    if (userId == null) return;

    // Load rooms for the user
    final roomsData = await client
        .from('rooms')
        .select('id, name')
        .order('position', ascending: true);

    if (!mounted) return;

    final rooms = (roomsData as List).cast<Map<String, dynamic>>();

    if (rooms.isEmpty) {
      _showErrorSnackBar('No rooms found. Create a room first.');
      return;
    }

    // Show room picker
    final selectedRoom = await _showRoomPicker(rooms);
    if (selectedRoom == null || !mounted) return;

    // Load subjects for the selected room
    final subjectsData = await client
        .from('subjects')
        .select('id, name')
        .eq('room_id', selectedRoom['id'] as String)
        .order('position', ascending: true);

    if (!mounted) return;

    final subjects = (subjectsData as List).cast<Map<String, dynamic>>();

    if (subjects.isEmpty) {
      _showErrorSnackBar('No subjects in this room. Create a subject first.');
      return;
    }

    // Show subject picker
    final selectedSubject = await _showSubjectPicker(subjects);
    if (selectedSubject == null || !mounted) return;

    // Load chapters for the selected subject
    final chaptersData = await client
        .from('chapters')
        .select('id, name')
        .eq('subject_id', selectedSubject['id'] as String)
        .order('position', ascending: true);

    if (!mounted) return;

    final chapters = (chaptersData as List).map((json) => Chapter.fromJson(json)).toList();

    if (chapters.isEmpty) {
      _showErrorSnackBar('No chapters in this subject. Create a chapter first.');
      return;
    }

    // Show chapter picker
    final selectedChapter = await _showChapterPicker(chapters);
    if (selectedChapter == null || !mounted) return;

    // Prompt for document title
    final title = await _promptForTitle();
    if (title == null || title.isEmpty || !mounted) return;

    // Navigate to capture screen
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => NewDocumentCaptureScreen(
          chapterId: selectedChapter.id,
          documentTitle: title,
        ),
      ),
    );
  }

  Future<void> _startAddToExistingFlow() async {
    final client = Supabase.instance.client;
    final userId = client.auth.currentUser?.id;
    if (userId == null) return;

    // Load all documents the user has access to
    final documentsData = await client
        .from('documents')
        .select('id, title, chapter_id, page_count')
        .order('updated_at', ascending: false);

    if (!mounted) return;

    final documents = (documentsData as List).map((json) => Document.fromJson(json)).toList();

    if (documents.isEmpty) {
      _showErrorSnackBar('No documents found. Create a document first.');
      return;
    }

    // Show document picker
    final selectedDocument = await _showDocumentPicker(documents);
    if (selectedDocument == null || !mounted) return;

    // Navigate to capture screen with existing document context
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => AddToExistingCaptureScreen(
          existingDocument: selectedDocument,
        ),
      ),
    );
  }

  Future<Map<String, dynamic>?> _showRoomPicker(List<Map<String, dynamic>> rooms) async {
    return await showModalBottomSheet<Map<String, dynamic>>(
      context: context,
      isScrollControlled: true,
      builder: (context) => _ListPickerSheet<Map<String, dynamic>>(
        title: 'Select Room',
        items: rooms,
        getTitle: (item) => item['name'] as String,
      ),
    );
  }

  Future<Map<String, dynamic>?> _showSubjectPicker(List<Map<String, dynamic>> subjects) async {
    return await showModalBottomSheet<Map<String, dynamic>>(
      context: context,
      isScrollControlled: true,
      builder: (context) => _ListPickerSheet<Map<String, dynamic>>(
        title: 'Select Subject',
        items: subjects,
        getTitle: (item) => item['name'] as String,
      ),
    );
  }

  Future<Chapter?> _showChapterPicker(List<Chapter> chapters) async {
    return await showModalBottomSheet<Chapter>(
      context: context,
      isScrollControlled: true,
      builder: (context) => _ListPickerSheet<Chapter>(
        title: 'Select Chapter',
        items: chapters,
        getTitle: (item) => item.name,
      ),
    );
  }

  Future<String?> _promptForTitle() async {
    final controller = TextEditingController();

    final title = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Document Title'),
        content: TextField(
          controller: controller,
          autofocus: true,
          textCapitalization: TextCapitalization.words,
          decoration: const InputDecoration(hintText: 'Enter document title'),
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
      ),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.dispose();
    });

    return title;
  }

  Future<Document?> _showDocumentPicker(List<Document> documents) async {
    return await showModalBottomSheet<Document>(
      context: context,
      isScrollControlled: true,
      builder: (context) => _DocumentPickerSheet(documents: documents),
    );
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}

class _ListPickerSheet<T> extends StatelessWidget {
  const _ListPickerSheet({
    required this.title,
    required this.items,
    required this.getTitle,
  });

  final String title;
  final List<T> items;
  final String Function(T) getTitle;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(AppSpacing.containerMargin),
            child: Text(title, style: AppTextStyles.sectionTitle),
          ),
          Flexible(
            child: ListView.separated(
              shrinkWrap: true,
              itemCount: items.length,
              separatorBuilder: (_, __) => const Divider(),
              itemBuilder: (context, index) {
                final item = items[index];
                return ListTile(
                  title: Text(getTitle(item), style: AppTextStyles.body),
                  trailing: const Icon(Icons.chevron_right, color: AppColors.textSecondary),
                  onTap: () => Navigator.of(context).pop(item),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _DocumentPickerSheet extends StatelessWidget {
  const _DocumentPickerSheet({required this.documents});

  final List<Document> documents;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(AppSpacing.containerMargin),
            child: Text('Select Document', style: AppTextStyles.sectionTitle),
          ),
          Flexible(
            child: ListView.separated(
              shrinkWrap: true,
              itemCount: documents.length,
              separatorBuilder: (_, __) => const Divider(),
              itemBuilder: (context, index) {
                final doc = documents[index];
                return ListTile(
                  title: Text(doc.title, style: AppTextStyles.body),
                  subtitle: Text(
                    '${doc.pageCount ?? 0} page${(doc.pageCount ?? 0) != 1 ? 's' : ''}',
                    style: AppTextStyles.metadata,
                  ),
                  trailing: const Icon(Icons.chevron_right, color: AppColors.textSecondary),
                  onTap: () => Navigator.of(context).pop(doc),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}