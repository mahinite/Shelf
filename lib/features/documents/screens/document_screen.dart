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

/// Factor applied to the initial/fit zoom on double-tap.
/// Tunable: adjust on device for preferred double-tap zoom level.
const double kDoubleTapZoomFactor = 2.5;

/// Alternative [interactionEndFrictionCoefficient] for a longer, Drive-like coast.
/// Default in pdfrx is 0.0000135 (very short coast). Uncomment to use.
/// const double kAlternativeInteractionEndFrictionCoefficient = 0.1;

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
  late final PdfViewerController _pdfController;

  String get _objectPath =>
      widget.document.filePath ?? 'documents/${widget.document.id}.pdf';

  @override
  void initState() {
    super.initState();
    _pdfController = PdfViewerController();
    _loadDocument();
  }

  @override
  void dispose() {
    super.dispose();
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
      controller: _pdfController,
      params: PdfViewerParams(
        textSelectionParams: const PdfTextSelectionParams(enabled: false),
        buildContextMenu: (context, params) => null,
        onGeneralTap: (context, controller, details) {
          switch (details.type) {
            case PdfViewerGeneralTapType.longPress:
            case PdfViewerGeneralTapType.secondaryTap:
              return true; // consume, no context menu
            case PdfViewerGeneralTapType.doubleTap: {
              final docPos = controller.localToDocument(details.localPosition);
              if (docPos != null) {
                controller.zoomUp(loop: true, zoomCenter: docPos);
              }
              return true; // consume
            }
            case PdfViewerGeneralTapType.tap:
              return false; // let default handling (clears selection, etc.)
          }
        },
        zoomStepsDelegateProvider: _TwoStopZoomStepsProvider(),
        scrollPhysics: const ClampingScrollPhysics(),
        viewerOverlayBuilder: (context, size, handleLinkTap) {
          final pageCount = _pdfController.pageCount;
          if (pageCount <= 1) return <Widget>[];
          return <Widget>[
            PdfViewerScrollThumb(
              controller: _pdfController,
              orientation: ScrollbarOrientation.right,
              thumbBuilder: (context, thumbSize, pageNumber, controller) {
                final colors = Theme.of(context).extension<ShelfColors>()!;
                final currentPage = pageNumber ?? controller.pageNumber ?? 1;
                return Container(
                  decoration: BoxDecoration(
                    color: colors.surfaceSubtle,
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: colors.border, width: 1),
                  ),
                  child: Center(
                    child: Text(
                      '$currentPage / $pageCount',
                      style: TextStyle(
                        color: colors.textPrimary,
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                );
              },
            ),
          ];
        },
      ),
    );
  }
}

/// Zoom steps provider that returns exactly two stops:
/// 1. The initial/fit zoom (coverScale from metrics)
/// 2. min(coverScale * kDoubleTapZoomFactor, metrics.maxScale)
/// Sorted ascending, no duplicates.
class _TwoStopZoomStepsProvider extends PdfViewerZoomStepsDelegateProvider {
  const _TwoStopZoomStepsProvider();

  @override
  PdfViewerZoomStepsDelegate create() => _TwoStopZoomStepsDelegate();

  @override
  bool operator ==(Object other) => other is _TwoStopZoomStepsProvider;

  @override
  int get hashCode => runtimeType.hashCode;
}

class _TwoStopZoomStepsDelegate implements PdfViewerZoomStepsDelegate {
  @override
  void dispose() {}

  @override
  List<double> generateZoomStops(PdfViewerLayoutMetrics metrics) {
    final fitZoom = metrics.coverScale;
    final double targetZoom = (fitZoom * kDoubleTapZoomFactor).clamp(fitZoom, metrics.maxScale);
    final stops = <double>[fitZoom];
    if (targetZoom > fitZoom + 0.01) {
      stops.add(targetZoom);
    }
    return stops;
  }
}