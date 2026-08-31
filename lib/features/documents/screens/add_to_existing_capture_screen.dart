import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/app_scaffold.dart';
import '../../../core/widgets/tactile.dart';
import '../../documents/models/document.dart';
import '../../documents/services/scan_service.dart';

class AddToExistingCaptureScreen extends StatefulWidget {
  const AddToExistingCaptureScreen({
    super.key,
    required this.existingDocument,
  });

  final Document existingDocument;

  @override
  State<AddToExistingCaptureScreen> createState() => AddToExistingCaptureScreenState();
}

class AddToExistingCaptureScreenState extends State<AddToExistingCaptureScreen> {
  final ImagePicker _picker = ImagePicker();
  final List<File> _newPageImages = [];
  bool _isProcessing = false;
  bool _isUploading = false;
  String? _errorMessage;
  int _existingPageCount = 0;

  @override
  void initState() {
    super.initState();
    _existingPageCount = widget.existingDocument.pageCount ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Add to "${widget.existingDocument.title}"',
      showBackButton: true,
      body: Column(
        children: [
          _buildExistingDocumentBanner(),
          Expanded(
            child: _newPageImages.isEmpty
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
                  '${widget.existingDocument.title} ($_existingPageCount existing page${_existingPageCount != 1 ? 's' : ''})',
                  style: AppTextStyles.body.copyWith(fontWeight: FontWeight.w500),
                ),
              ],
            ),
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
            Icons.camera_alt_outlined,
            size: 64,
            color: AppColors.textSecondary,
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(
            'No new pages captured yet',
            style: AppTextStyles.sectionTitle,
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            'Tap the camera button to scan pages to add',
            style: AppTextStyles.bodySecondary,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildPreviewList() {
    return ListView.separated(
      padding: const EdgeInsets.all(AppSpacing.containerMargin),
      itemCount: _newPageImages.length,
      separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.sm),
      itemBuilder: (context, index) {
        return _buildPageItem(index);
      },
    );
  }

  Widget _buildPageItem(int index) {
    final image = _newPageImages[index];
    final pageNumber = _existingPageCount + index + 1;
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
                    'Page $pageNumber (new)',
                    style: AppTextStyles.body.copyWith(fontWeight: FontWeight.w500),
                  ),
                  Text(
                    '${_newPageImages.length} new page${_newPageImages.length > 1 ? 's' : ''} to add',
                    style: AppTextStyles.metadata,
                  ),
                ],
              ),
            ),
          ),
          Tactile(
            onTap: _isProcessing || _isUploading ? null : () => _removePage(index),
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
    final canSave = _newPageImages.isNotEmpty && !_isProcessing && !_isUploading;

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
            if (_newPageImages.isNotEmpty)
              Expanded(
                child: Tactile(
                  onTap: _isProcessing || _isUploading ? null : _clearAll,
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      border: Border.all(color: AppColors.border, width: 1),
                      borderRadius: BorderRadius.circular(AppRadius.md),
                    ),
                    child: Text(
                      'Clear All',
                      style: AppTextStyles.buttonLabel.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ),
                ),
              ),
            if (_newPageImages.isNotEmpty) const SizedBox(width: AppSpacing.md),
            // Camera button to capture new pages
            Expanded(
              child: Tactile(
                onTap: _isProcessing || _isUploading ? null : _capturePhoto,
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: (_isProcessing || _isUploading) ? AppColors.border : AppColors.primaryButton,
                    borderRadius: BorderRadius.circular(AppRadius.md),
                  ),
                  child: _isProcessing
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: AppColors.onPrimaryButton,
                          ),
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.camera_alt, color: AppColors.onPrimaryButton, size: 20),
                            const SizedBox(width: AppSpacing.xs),
                            Text(
                              _newPageImages.isEmpty ? 'Capture Page' : 'Add Another',
                              style: AppTextStyles.buttonLabel.copyWith(
                                color: AppColors.onPrimaryButton,
                              ),
                            ),
                          ],
                        ),
                ),
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            // Save button
            Expanded(
              flex: 2,
              child: Tactile(
                onTap: canSave ? _addToExistingDocument : null,
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
                          _newPageImages.isEmpty
                              ? 'Add Pages'
                              : 'Add ${_newPageImages.length} Page${_newPageImages.length > 1 ? 's' : ''}',
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

  Future<void> _capturePhoto() async {
    if (_isProcessing || _isUploading) return;

    setState(() {
      _isProcessing = true;
      _errorMessage = null;
    });

    try {
      final XFile? photo = await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 85,
        maxWidth: ScanService.maxDimension.toDouble(),
        maxHeight: ScanService.maxDimension.toDouble(),
      );

      if (photo != null) {
        final originalFile = File(photo.path);
        final processedFile = await ScanService.processImage(originalFile);

        if (!mounted) return;

        setState(() {
          _newPageImages.add(processedFile);
          _isProcessing = false;
        });
      } else {
        if (!mounted) return;
        setState(() => _isProcessing = false);
      }
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _isProcessing = false;
        _errorMessage = 'Failed to capture photo: $e';
      });
      _showErrorSnackBar(_errorMessage!);
    }
  }

  void _removePage(int index) {
    setState(() {
      _newPageImages.removeAt(index);
    });
  }

  void _clearAll() {
    setState(() {
      _newPageImages.clear();
    });
  }

  Future<void> _addToExistingDocument() async {
    if (_newPageImages.isEmpty || _isUploading) return;

    setState(() {
      _isUploading = true;
      _errorMessage = null;
    });

    String? batchId;
    List<File>? downloadedExistingPages;

    try {
      final client = Supabase.instance.client;
      final userId = client.auth.currentUser?.id;
      if (userId == null) throw Exception('Not authenticated');

      final documentId = widget.existingDocument.id;

      // 1. Download existing page images for PDF regeneration
      if (_existingPageCount > 0) {
        downloadedExistingPages = await ScanService.downloadPageImages(documentId, _existingPageCount);
      }

      // 2. Create new scan_batch for this upload session
      batchId = await ScanService.createScanBatch(
        documentId: documentId,
        pageCount: _newPageImages.length,
      );

      // 3. Upload new page images to B2 and create scan_pages rows
      // Page order continues from existing pages
      int nextPageOrder = _existingPageCount + 1;
      for (int i = 0; i < _newPageImages.length; i++) {
        final pageOrder = nextPageOrder + i;
        await ScanService.uploadPageImage(
          documentId: documentId,
          pageOrder: pageOrder,
          imageFile: _newPageImages[i],
        );
      }

      // 4. Create scan_pages rows for new pages
      await ScanService.createScanPagesForAddition(
        batchId: batchId,
        documentId: documentId,
        startPageOrder: nextPageOrder,
        newPageCount: _newPageImages.length,
      );

      // 5. Assemble full PDF: existing pages + new pages
      final allPages = <File>[];
      if (downloadedExistingPages != null) {
        allPages.addAll(downloadedExistingPages);
      }
      allPages.addAll(_newPageImages);

      final pdfBytes = await ScanService.assemblePdf(allPages);

      // 6. Upload new PDF to B2 (overwrites existing)
      await ScanService.uploadDocumentPdf(documentId: documentId, pdfBytes: pdfBytes);

      // 7. Update document row with new page count and file size
      await ScanService.updateDocumentPdf(
        documentId: documentId,
        pageCount: allPages.length,
        fileSize: pdfBytes.length,
      );

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Added ${_newPageImages.length} page(s) to document')),
      );

      Navigator.of(context).popUntil((route) => route.isFirst);
    } catch (e) {
      if (!mounted) return;

      // Cleanup on failure
      await _cleanupOnFailure(batchId, _newPageImages.length, widget.existingDocument.id);

      setState(() {
        _isUploading = false;
        _errorMessage = 'Failed to add pages: $e';
      });
      _showErrorSnackBar(_errorMessage!);
    }
  }

  Future<void> _cleanupOnFailure(String? batchId, int newPageCount, String documentId) async {
    if (batchId == null) return;

    try {
      final client = Supabase.instance.client;

      // Delete scan_pages for this batch
      await client.from('scan_pages').delete().eq('batch_id', batchId);

      // Delete scan_batch
      await client.from('scan_batches').delete().eq('id', batchId);

      // Delete uploaded page images from storage
      // Note: We don't know the exact page orders that were used if it failed partway,
      // so we delete any pages that might have been uploaded for this batch
      // The actual page orders would be existingPageCount+1 through existingPageCount+newPageCount
      final paths = List.generate(newPageCount, (i) => 'pages/$documentId/${_existingPageCount + 1 + i}.jpg');
      await client.storage.from('documents').remove(paths);
    } catch (e) {
      debugPrint('Cleanup failed: $e');
    }
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}