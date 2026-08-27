import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/chapter.dart';
import '../../documents/models/document.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/app_scaffold.dart';
import '../../documents/widgets/document_list_item.dart';
import '../../documents/screens/document_screen.dart';

class ChapterScreen extends StatefulWidget {
  const ChapterScreen({
    super.key,
    required this.chapter,
    required this.accent,
  });

  final Chapter chapter;
  final Color accent;

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

    return (data as List)
    .map((json) => Document.fromJson(json))
    .toList();
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
        builder: (_) => DocumentScreen(document: document),
      ),
    );
  }
}