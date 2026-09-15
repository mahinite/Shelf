import 'package:flutter/material.dart';
import 'package:file_saver/file_saver.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/chapter.dart';
import '../../documents/models/document.dart';
import '../../../core/network/worker_client.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/app_scaffold.dart';
import '../../../core/widgets/rename_delete_sheet.dart';
import '../../documents/widgets/document_list_item.dart';
import '../../documents/screens/document_screen.dart';

class ChapterScreen extends StatefulWidget {
  const ChapterScreen({
    super.key,
    required this.chapter,
    required this.accent,
    required this.roomCreatedBy,
  });

  final Chapter chapter;
  final Color accent;
  final String roomCreatedBy;

  @override
  State<ChapterScreen> createState() => _ChapterScreenState();
}

class _ChapterScreenState extends State<ChapterScreen> {
  late Future<List<Document>> _documentsFuture;

  @override
  void initState() {
    super.initState();
    _documentsFuture = _loadDocuments();
  }

  Future<List<Document>> _loadDocuments() async {
    final data = await Supabase.instance.client
        .from('documents')
        .select()
        .eq('chapter_id', widget.chapter.id)
        .order('position', ascending: true);

    return (data as List).map((json) => Document.fromJson(json)).toList();
  }

  Future<void> _renameDocument(Document document, String newName) async {
    try {
      await Supabase.instance.client
          .from('documents')
          .update({'title': newName}).eq('id', document.id);

      if (!mounted) return;

      setState(() {
        _documentsFuture = _loadDocuments();
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Document renamed to $newName')),
        );
      }
    } catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not rename document.\n$error')),
      );
    }
  }

  Future<void> _deleteDocument(Document document) async {
    try {
      final result = await Supabase.instance.client
          .from('documents')
          .delete()
          .eq('id', document.id)
          .select();

      if (!mounted) return;

      if (result.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('You don\'t have permission to delete this document')),
        );
        return;
      }

      setState(() {
        _documentsFuture = _loadDocuments();
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Document deleted')),
        );
      }
    } catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not delete document.\n$error')),
      );
    }
  }

  Future<void> _downloadDocument(Document document) async {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Downloading...')),
    );
    try {
      final objectPath = document.filePath ?? 'documents/${document.id}.pdf';
      final bytes = await WorkerClient.instance.getBytes(objectPath);
      final fileName = _sanitizeFilename(document.title);
      final savedPath = await FileSaver.instance.saveAs(
        name: fileName,
        bytes: bytes,
        fileExtension: 'pdf',
        mimeType: MimeType.pdf,
      );
      if (!mounted) return;
      if (savedPath == null) {
        // User cancelled the system save dialog.
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Saved "$fileName.pdf"')),
      );
    } catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not download document.\n$error')),
      );
    }
  }

  String _sanitizeFilename(String title) {
    final sanitized = title
        .replaceAll(RegExp(r'[\\/:*?"<>|]'), '_')
        .trim()
        .replaceAll(RegExp(r'^\.+|\.+$'), '');
    return sanitized.isEmpty ? 'document' : sanitized;
  }

  void _showDocumentActions(Document document) {
    final currentUserId = Supabase.instance.client.auth.currentUser?.id;
    final isRoomCreator = currentUserId == widget.roomCreatedBy;
    final isUploader = currentUserId == document.createdBy;
    final canDelete = isRoomCreator || isUploader;

    showRenameDeleteSheet(
      context: context,
      currentName: document.title,
      itemType: 'Document',
      hasChildren: false,
      onRename: (newName) => _renameDocument(document, newName), // rename is allowed for all members
      onDownload: () => _downloadDocument(document),
      onDelete: canDelete ? () => _deleteDocument(document) : null,
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: widget.chapter.name,
      showBackButton: true,
      body: FutureBuilder<List<Document>>(
        future: _documentsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(
                'Could not load documents.\n${snapshot.error}',
                style: AppTextStyles.body,
                textAlign: TextAlign.center,
              ),
            );
          }

          final documents = snapshot.data ?? [];

          if (documents.isEmpty) {
            return const Center(
              child: Text('No documents yet.'),
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.all(AppSpacing.containerMargin),
            itemCount: documents.length,
            separatorBuilder: (_, __) => const Divider(),
            itemBuilder: (context, index) {
              final document = documents[index];

              return DocumentListItem(
                document: document,
                accent: widget.accent,
                onTap: () => _openDocument(context, document),
                onLongPress: () => _showDocumentActions(document),
              );
            },
          );
        },
      ),
    );
  }

  void _openDocument(
    BuildContext context,
    Document document,
  ) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => DocumentScreen(document: document, roomCreatedBy: widget.roomCreatedBy),
      ),
    );
  }
}
