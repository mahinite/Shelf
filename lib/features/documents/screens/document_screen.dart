import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pdfrx/pdfrx.dart';

import '../models/document.dart';
import '../../../core/services/document_cache_manager.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/theme/shelf_colors.dart';
import '../../../core/widgets/app_scaffold.dart';
import '../../../core/widgets/tactile.dart';

class DocumentScreen extends StatefulWidget {
  const DocumentScreen({
    super.key,
    required this.document,
    required this.roomCreatedBy,
  });

  final Document document;
  final String roomCreatedBy;

  @override
  State<DocumentScreen> createState() => _DocumentScreenState();
}

class _DocumentScreenState extends State<DocumentScreen> {
  File? _cachedFile;
  bool _isLoading = true;
  String? _errorMessage;

  String get _objectPath =>
      widget.document.filePath ?? 'documents/${widget.document.id}.pdf';

  @override
  void initState() {
    super.initState();
    _loadDocument();
  }

  Future<void> _loadDocument() async {
    if (_cachedFile == null) {
      setState(() {
        _isLoading = true;
        _errorMessage = null;
      });
    }

    final cacheKey = DocumentCacheManager.cacheKeyFor(widget.document);

    final cached = await DocumentCacheManager.instance
        .getFileFromCache(cacheKey);
    if (!mounted) return;
    if (cached != null) {
      setState(() {
        _cachedFile = cached.file;
        _isLoading = false;
        _errorMessage = null;
      });
    }

    try {
      final file = await DocumentCacheManager.instance
          .getSingleFile(_objectPath, key: cacheKey);
      if (!mounted) return;
      setState(() {
        _cachedFile = file;
        _isLoading = false;
        _errorMessage = null;
      });
    } catch (e) {
      if (!mounted) return;
      if (_cachedFile != null) {
        return;
      }
      setState(() {
        _errorMessage = 'Failed to load document: $e';
        _isLoading = false;
      });
    }
  }

  void _retry() {
    _loadDocument();
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
                style: context.textStyles.body(context.colors).copyWith(color: context.colors.destructive),
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
                    style: context.textStyles.buttonLabel(context.colors).copyWith(
                      color: context.colors.onAccent,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }
    if (_cachedFile == null) {
      return Center(
        child: Text(
          'Document is empty',
          style: context.textStyles.bodySecondary(context.colors),
        ),
      );
    }

    return PdfViewer.file(
      _cachedFile!.path,
    );
  }
}