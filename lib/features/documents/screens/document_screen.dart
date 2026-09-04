import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:pdfx/pdfx.dart';

import '../models/document.dart';
import '../../../core/network/worker_client.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/app_scaffold.dart';
import '../../../core/widgets/tactile.dart';

class DocumentScreen extends StatefulWidget {
  const DocumentScreen({
    super.key,
    required this.document,
  });

  final Document document;

  @override
  State<DocumentScreen> createState() => _DocumentScreenState();
}

class _DocumentScreenState extends State<DocumentScreen> {
  PdfDocument? _pdfDocument;
  List<Uint8List>? _renderedPages;
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadDocument();
  }

  Future<void> _loadDocument() async {
    final screenWidth = MediaQuery.of(context).size.width;
    final dpr = MediaQuery.of(context).devicePixelRatio;
    const double horizontalPadding = AppSpacing.containerMargin;
    final double renderWidth = screenWidth - 2 * horizontalPadding;

    setState(() {
      _isLoading = true;
      _errorMessage = null;
      _renderedPages = null;
    });
    try {
      final bytes = await WorkerClient.instance.getBytes('documents/${widget.document.id}.pdf');
      _pdfDocument = await PdfDocument.openData(bytes);

      final pages = <Uint8List>[];
      for (int i = 1; i <= _pdfDocument!.pagesCount; i++) {
        final pageBytes = await _renderPage(i, renderWidth, dpr);
        if (pageBytes != null) {
          pages.add(pageBytes);
        }
      }

      if (mounted) {
        setState(() {
          _renderedPages = pages;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _errorMessage = 'Failed to load document: $e';
          _isLoading = false;
        });
      }
    }
  }

  Future<Uint8List?> _renderPage(int pageNumber, double targetWidth, double dpr) async {
    try {
      final page = await _pdfDocument!.getPage(pageNumber);
      final pageWidth = page.width.toDouble();
      final pageHeight = page.height.toDouble();
      final renderWidth = (targetWidth * dpr).round().toDouble();
      final scale = renderWidth / pageWidth;
      final renderHeight = (pageHeight * scale).round().toDouble();
      final pageImage = await page.render(
        width: renderWidth,
        height: renderHeight,
        format: PdfPageImageFormat.jpeg,
        quality: 90,
      );
      await page.close();
      return pageImage?.bytes;
    } catch (e) {
      return null;
    }
  }

  void _retry() {
    _loadDocument();
  }

  @override
  void dispose() {
    _pdfDocument?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: widget.document.title,
      showBackButton: true,
      body: _buildBody(),
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
                onTap: _retry,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.lg,
                    vertical: AppSpacing.md,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primaryButton,
                    borderRadius: BorderRadius.circular(8),
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
    if (_pdfDocument == null) {
      return Center(
        child: Text(
          'Document is empty',
          style: AppTextStyles.bodySecondary,
        ),
      );
    }

    final renderedPages = _renderedPages;
    if (renderedPages == null || renderedPages.isEmpty) {
      return Center(
        child: Text(
          'Document has no pages',
          style: AppTextStyles.bodySecondary,
        ),
      );
    }

    return InteractiveViewer(
      constrained: false,
      minScale: 1.0,
      maxScale: 4.0,
      panEnabled: true,
      scaleEnabled: true,
      child: Column(
        children: [
          for (int i = 0; i < renderedPages.length; i++) ...[
            Image.memory(
              renderedPages[i],
              width: double.infinity,
              fit: BoxFit.fitWidth,
            ),
            if (i < renderedPages.length - 1)
              const SizedBox(height: AppSpacing.md),
          ],
        ],
      ),
    );
  }
}