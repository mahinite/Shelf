import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/chapter.dart';
import '../../documents/models/document.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/app_scaffold.dart';
import '../../documents/widgets/document_list_item.dart';
import '../../documents/screens/notes_screen.dart';

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
  List<Document> _documents = [];
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadDocuments();
  }

  Future<void> _loadDocuments() async {
    try {
      final data = await Supabase.instance.client
          .from('documents')
          .select('*')
          .eq('chapter_id', widget.chapter.id)
          .order('created_at', ascending: true);

      final documents = (data as List)
          .map((json) => Document.fromJson(json))
          .toList();

      if (!mounted) return;

      setState(() {
        _documents = documents;
        _isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: widget.chapter.name,
      showBackButton: true,
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (_error != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.containerMargin),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Couldn\'t load documents',
                style: AppTextStyles.sectionTitle,
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                _error!,
                style: AppTextStyles.bodySecondary,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.md),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _isLoading = true;
                    _error = null;
                  });
                  _loadDocuments();
                },
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      );
    }

    if (_documents.isEmpty) {
      return Center(
        child: Text(
          'No documents yet.',
          style: AppTextStyles.bodySecondary,
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.all(AppSpacing.containerMargin),
      itemCount: _documents.length,
      separatorBuilder: (_, __) => const Divider(),
      itemBuilder: (context, index) {
        final document = _documents[index];

        return DocumentListItem(
          document: document,
          onTap: () => _openDocument(context, document),
        );
      },
    );
  }

  void _openDocument(BuildContext context, Document document) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => NotesScreen(document: document),
      ),
    );
  }
}