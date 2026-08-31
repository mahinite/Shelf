import 'dart:io';

import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/app_scaffold.dart';
import '../../../core/widgets/tactile.dart';
import '../../documents/models/document.dart';
import '../../documents/services/scan_service.dart';

class ScanBatchScreen extends StatefulWidget {
  const ScanBatchScreen({
    super.key,
    required this.capturedImages,
  });

  final List<File> capturedImages;

  @override
  State<ScanBatchScreen> createState() => _ScanBatchScreenState();
}

class _ScanBatchScreenState extends State<ScanBatchScreen> {
  final List<File> _pageImages;
  bool _isUploading = false;
  String? _errorMessage;
  Document? _existingDocument;

  _ScanBatchScreenState() : _pageImages = [];

  @override
  void initState() {
    super.initState();
    _pageImages.addAll(widget.capturedImages);
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: _existingDocument != null ? 'Add to "${_existingDocument!.title}"' : 'Save as New Document',
      showBackButton: true,
      body: Column(
        children: [
          if (_existingDocument != null) _buildExistingDocumentBanner(),
          Expanded(
            child: _pageImages.isEmpty
                ? _buildEmptyState()
                : _buildPreviewList(),
          ),
          _buildBottomBar(),
        ],
      ),
    );
  }

  Widget _buildExistingDocumentBanner() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.md),
      margin: const EdgeInsets.all(AppSpacing.containerMargin),
      decoration: BoxDecoration(
        color: AppColors.surfaceCard,
        border: Border.all(color: AppColors.border, width: 1),
        borderRadius: BorderRadius.circular(AppRadius.md),
      ),
      child: Row(
        children: [
          const Icon(Icons.picture_as_pdf, color: AppColors.primaryButton),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Adding to existing document',
                  style: AppTextStyles.metadata.copyWith(color: AppColors.primaryButton),
                ),
                Text(
                  _existingDocument!.title,
                  style: AppTextStyles.body.copyWith(fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
          Tactile(
            onTap: _isUploading ? null : _clearDocumentSelection,
            child: const Icon(Icons.close, color: AppColors.textSecondary),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.picture_as_pdf_outlined,
            size: 64,
            color: AppColors.textSecondary,
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(
            'No pages to save',
            style: AppTextStyles.sectionTitle,
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            'Go back to capture pages',
            style: AppTextStyles.bodySecondary,
          ),
        ],
      ),
    );
  }

  Widget _buildPreviewList() {
    return ListView.separated(
      padding: const EdgeInsets.all(AppSpacing.containerMargin),
      itemCount: _pageImages.length,
      separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.sm),
      itemBuilder: (context, index) {
        return _buildPageItem(index);
      },
    );
  }

  Widget _buildPageItem(int index) {
    final image = _pageImages[index];
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surfaceCard,
        border: Border.all(color: AppColors.border, width: 1),
        borderRadius: BorderRadius.circular(AppRadius.md),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(AppRadius.md),
              bottomLeft: Radius.circular(AppRadius.md),
            ),
            child: Image.file(
              image,
              width: 80,
              height: 100,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Page ${index + 1}',
                    style: AppTextStyles.body.copyWith(fontWeight: FontWeight.w500),
                  ),
                  Text(
                    '${_pageImages.length} page${_pageImages.length > 1 ? 's' : ''} total',
                    style: AppTextStyles.metadata,
                  ),
                ],
              ),
            ),
          ),
          Tactile(
            onTap: _isUploading ? null : () => _removePage(index),
            child: const Padding(
              padding: EdgeInsets.all(AppSpacing.md),
              child: Icon(Icons.delete_outline, color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomBar() {
    final canSave = _pageImages.isNotEmpty && !_isUploading;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.containerMargin),
      decoration: const BoxDecoration(
        color: AppColors.surfaceCard,
        border: Border(top: BorderSide(color: AppColors.border, width: 1)),
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            if (_existingDocument == null)
              Expanded(
                child: Tactile(
                  onTap: _isUploading ? null : _selectExistingDocument,
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      border: Border.all(color: AppColors.border, width: 1),
                      borderRadius: BorderRadius.circular(AppRadius.md),
                    ),
                    child: Text(
                      'Add to Existing',
                      style: AppTextStyles.buttonLabel.copyWith(
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ),
                ),
              ),
            if (_existingDocument == null) const SizedBox(width: AppSpacing.md),
            Expanded(
              flex: 2,
              child: Tactile(
                onTap: canSave ? _saveDocument : null,
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: canSave ? AppColors.primaryButton : AppColors.border,
                    borderRadius: BorderRadius.circular(AppRadius.md),
                  ),
                  child: _isUploading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: AppColors.onPrimaryButton,
                          ),
                        )
                      : Text(
                          _existingDocument != null
                              ? 'Add ${_pageImages.length} Page${_pageImages.length > 1 ? 's' : ''}'
                              : 'Save as New Document',
                          style: AppTextStyles.buttonLabel.copyWith(
                            color: canSave ? AppColors.onPrimaryButton : AppColors.textSecondary,
                          ),
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _removePage(int index) {
    setState(() {
      _pageImages.removeAt(index);
    });
  }

  Future<void> _selectExistingDocument() async {
    final client = Supabase.instance.client;
    final userId = client.auth.currentUser?.id;
    if (userId == null) return;

    final data = await client
        .from('documents')
        .select('id, title, chapter_id, file_path, page_count')
        .order('updated_at', ascending: false);

    if (!mounted) return;

    final documents = (data as List).map((json) => Document.fromJson(json)).toList();

    final selected = await showModalBottomSheet<Document>(
      context: context,
      builder: (context) => _DocumentPickerSheet(documents: documents),
    );

    if (selected != null && mounted) {
      setState(() {
        _existingDocument = selected;
      });
    }
  }

  void _clearDocumentSelection() {
    setState(() {
      _existingDocument = null;
    });
  }

  Future<void> _saveDocument() async {
    if (_pageImages.isEmpty || _isUploading) return;

    setState(() {
      _isUploading = true;
      _errorMessage = null;
    });

    try {
      final client = Supabase.instance.client;
      final userId = client.auth.currentUser?.id;
      if (userId == null) throw Exception('Not authenticated');

      String documentId;
      int existingPageCount = 0;

      if (_existingDocument != null) {
        documentId = _existingDocument!.id;
        existingPageCount = _existingDocument!.pageCount ?? 0;

        final existingPageImages = await ScanService.downloadPageImages(documentId, existingPageCount);
        _pageImages.insertAll(0, existingPageImages);
      } else {
        final insertResult = await client.from('documents').insert({
          'chapter_id': '00000000-0000-0000-0000-000000000000',
          'title': 'Scanned Document',
          'position': 0,
        }).select('id').single();
        documentId = insertResult['id'] as String;
      }

      await ScanService.createScanBatch(documentId: documentId, pageCount: _pageImages.length);

      for (int i = 0; i < _pageImages.length; i++) {
        await ScanService.uploadPageImage(
          documentId: documentId,
          pageOrder: i + 1,
          imageFile: _pageImages[i],
        );
      }

      final pdfBytes = await ScanService.assemblePdf(_pageImages);
      await ScanService.uploadDocumentPdf(documentId: documentId, pdfBytes: pdfBytes);

      await ScanService.updateDocumentPdf(
        documentId: documentId,
        pageCount: _pageImages.length,
        fileSize: pdfBytes.length,
      );

      await ScanService.createScanPages(
        batchId: '', // We don't have batch ID from the insert
        documentId: documentId,
        pageCount: _pageImages.length,
      );

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(_existingDocument != null
              ? 'Added ${_pageImages.length - existingPageCount} page(s) to document'
              : 'Document saved with ${_pageImages.length} page(s)'),
        ),
      );

      Navigator.of(context).popUntil((route) => route.isFirst);
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _isUploading = false;
        _errorMessage = 'Failed to save document: $e';
      });
      _showErrorSnackBar(_errorMessage!);
    }
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
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
            child: Text(
              'Select Document',
              style: AppTextStyles.sectionTitle,
            ),
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