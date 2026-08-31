import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/app_scaffold.dart';
import '../../../core/widgets/tactile.dart';
import '../../documents/services/scan_service.dart';

class NewDocumentCaptureScreen extends StatefulWidget {
  const NewDocumentCaptureScreen({
    super.key,
    required this.chapterId,
    required this.documentTitle,
  });

  final String chapterId;
  final String documentTitle;

  @override
  State<NewDocumentCaptureScreen> createState() => NewDocumentCaptureScreenState();
}

class NewDocumentCaptureScreenState extends State<NewDocumentCaptureScreen> {
  final ImagePicker _picker = ImagePicker();
  final List<File> _capturedImages = [];
  bool _isProcessing = false;
  bool _isUploading = false;
  String? _errorMessage;

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Scan: ${widget.documentTitle}',
      showBackButton: true,
      body: Column(
        children: [
          Expanded(
            child: _capturedImages.isEmpty
                ? _buildEmptyState()
                : _buildPreviewGrid(),
          ),
          _buildBottomBar(),
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
            'No pages captured yet',
            style: AppTextStyles.sectionTitle,
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            'Tap the camera button to scan your first page',
            style: AppTextStyles.bodySecondary,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildPreviewGrid() {
    return GridView.builder(
      padding: const EdgeInsets.all(AppSpacing.containerMargin),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: AppSpacing.md,
        mainAxisSpacing: AppSpacing.md,
        childAspectRatio: 0.75,
      ),
      itemCount: _capturedImages.length + 1,
      itemBuilder: (context, index) {
        if (index == _capturedImages.length) {
          return _buildAddPageButton();
        }
        return _buildPagePreview(index);
      },
    );
  }

  Widget _buildPagePreview(int index) {
    final image = _capturedImages[index];
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(AppRadius.md),
          child: Image.file(
            image,
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          top: AppSpacing.xs,
          right: AppSpacing.xs,
          child: Tactile(
            onTap: _isUploading ? null : () => _removePage(index),
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: const BoxDecoration(
                color: Colors.black54,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.close,
                size: 16,
                color: Colors.white,
              ),
            ),
          ),
        ),
        Positioned(
          bottom: AppSpacing.xs,
          left: AppSpacing.xs,
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.sm,
              vertical: 2,
            ),
            decoration: BoxDecoration(
              color: Colors.black54,
              borderRadius: BorderRadius.circular(AppRadius.sm),
            ),
            child: Text(
              'Page ${index + 1}',
              style: AppTextStyles.metadata.copyWith(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAddPageButton() {
    return Tactile(
      onTap: _isProcessing || _isUploading ? null : _capturePhoto,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surfaceCard,
          border: Border.all(color: AppColors.border, width: 1),
          borderRadius: BorderRadius.circular(AppRadius.md),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.add_a_photo_outlined,
              size: 32,
              color: (_isProcessing || _isUploading) ? AppColors.textSecondary : AppColors.textPrimary,
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              'Add Page',
              style: AppTextStyles.body.copyWith(
                color: (_isProcessing || _isUploading) ? AppColors.textSecondary : AppColors.textPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomBar() {
    final canSave = _capturedImages.isNotEmpty && !_isProcessing && !_isUploading;

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
            if (_capturedImages.isNotEmpty)
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
            if (_capturedImages.isNotEmpty) const SizedBox(width: AppSpacing.md),
            Expanded(
              flex: 2,
              child: Tactile(
                onTap: canSave ? _saveNewDocument : null,
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
                          _capturedImages.isEmpty ? 'Capture First Page' : 'Save Document (${_capturedImages.length})',
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
          _capturedImages.add(processedFile);
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
      _capturedImages.removeAt(index);
    });
  }

  void _clearAll() {
    setState(() {
      _capturedImages.clear();
    });
  }

  Future<void> _saveNewDocument() async {
    if (_capturedImages.isEmpty || _isUploading) return;

    setState(() {
      _isUploading = true;
      _errorMessage = null;
    });

    String? documentId;
    String? batchId;

    try {
      final client = Supabase.instance.client;
      final userId = client.auth.currentUser?.id;
      if (userId == null) throw Exception('Not authenticated');

      // 1. Create document row
      final insertResult = await client.from('documents').insert({
        'chapter_id': widget.chapterId,
        'title': widget.documentTitle,
        'position': 0,
      }).select('id').single();
      documentId = insertResult['id'] as String;

      // 2. Create scan_batch
      batchId = await ScanService.createScanBatch(
        documentId: documentId,
        pageCount: _capturedImages.length,
      );

      // 3. Upload each page image to B2 and create scan_pages rows
      for (int i = 0; i < _capturedImages.length; i++) {
        final pageOrder = i + 1;
        await ScanService.uploadPageImage(
          documentId: documentId,
          pageOrder: pageOrder,
          imageFile: _capturedImages[i],
        );
      }

      // 4. Create scan_pages rows with batch_id
      await ScanService.createScanPages(
        batchId: batchId,
        documentId: documentId,
        pageCount: _capturedImages.length,
      );

      // 5. Assemble PDF from all captured pages
      final pdfBytes = await ScanService.assemblePdf(_capturedImages);

      // 6. Upload PDF to B2
      await ScanService.uploadDocumentPdf(documentId: documentId, pdfBytes: pdfBytes);

      // 7. Update document row with file info
      await ScanService.updateDocumentPdf(
        documentId: documentId,
        pageCount: _capturedImages.length,
        fileSize: pdfBytes.length,
      );

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Document saved with ${_capturedImages.length} page(s)')),
      );

      Navigator.of(context).popUntil((route) => route.isFirst);
    } catch (e) {
      if (!mounted) return;

      // Rollback/cleanup on failure
      await _cleanupOnFailure(documentId, batchId, _capturedImages.length);

      setState(() {
        _isUploading = false;
        _errorMessage = 'Failed to save document: $e';
      });
      _showErrorSnackBar(_errorMessage!);
    }
  }

  Future<void> _cleanupOnFailure(String? documentId, String? batchId, int pageCount) async {
    if (documentId == null) return;

    try {
      final client = Supabase.instance.client;

      // Delete scan_pages if batch was created
      if (batchId != null) {
        await client.from('scan_pages').delete().eq('batch_id', batchId);
      }

      // Delete scan_batch if created
      if (batchId != null) {
        await client.from('scan_batches').delete().eq('id', batchId);
      }

      // Delete uploaded page images from storage
      final paths = List.generate(pageCount, (i) => 'pages/$documentId/${i + 1}.jpg');
      await client.storage.from('documents').remove(paths);

      // Delete document row
      await client.from('documents').delete().eq('id', documentId);
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