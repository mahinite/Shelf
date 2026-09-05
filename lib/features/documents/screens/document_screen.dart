import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:pdfrx/pdfrx.dart';

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
    required this.roomCreatedBy,
  });

  final Document document;
  final String roomCreatedBy;

  @override
  State<DocumentScreen> createState() => _DocumentScreenState();
}

class _DocumentScreenState extends State<DocumentScreen> {
  Uint8List? _pdfBytes;
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadDocument();
  }

  Future<void> _loadDocument() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
      _pdfBytes = null;
    });
    try {
      final bytes = await WorkerClient.instance.getBytes('documents/${widget.document.id}.pdf');
      if (mounted) {
        setState(() {
          _pdfBytes = bytes;
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
    if (_pdfBytes == null) {
      return Center(
        child: Text(
          'Document is empty',
          style: AppTextStyles.bodySecondary,
        ),
      );
    }

    return PdfViewer.data(
      _pdfBytes!,
      sourceName: widget.document.id,
    );
  }
}