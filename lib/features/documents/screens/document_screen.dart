import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdfrx/pdfrx.dart';
import 'package:printing/printing.dart';

import '../models/document.dart';
import '../services/document_download_service.dart';
import '../../../core/services/document_cache_manager.dart';
import '../../../core/platform/platform_support.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/theme/shelf_colors.dart';
import '../../../core/widgets/app_scaffold.dart';
import '../../../core/widgets/tactile.dart';
import '../widgets/pdf_fast_scroll.dart';

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

  Future<void> _download() async {
    if (_cachedFile == null) return;
    final bytes = await _cachedFile!.readAsBytes();
    await DocumentDownloadService.instance.downloadDocument(
      context,
      widget.document,
      bytes: bytes,
    );
  }

  Future<void> _print() async {
    if (_cachedFile == null) return;
    final bytes = await _cachedFile!.readAsBytes();
    try {
      await Printing.layoutPdf(onLayout: (_) async => bytes);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not print: $e')),
      );
    }
  }

  List<Widget> _buildDesktopActions() {
    if (!PlatformSupport.isDesktop) return [];
    return [
      IconButton(
        icon: const Icon(Icons.download_outlined),
        tooltip: 'Download (Ctrl+S)',
        onPressed: _download,
      ),
      IconButton(
        icon: const Icon(Icons.print_outlined),
        tooltip: 'Print (Ctrl+P)',
        onPressed: _print,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = PlatformSupport.isDesktop;
    Widget child = _buildBody();

    if (isDesktop) {
      child = Focus(
        autofocus: true,
        child: CallbackShortcuts(
          bindings: {
            const SingleActivator(LogicalKeyboardKey.keyS, control: true): _download,
            const SingleActivator(LogicalKeyboardKey.keyP, control: true): _print,
          },
          child: child,
        ),
      );
    }

    return AppScaffold(
      title: widget.document.title,
      showBackButton: true,
      actions: _buildDesktopActions(),
      body: child,
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
              controller.zoomUp(loop: true, zoomCenter: docPos);
              return true; // consume
            }
            case PdfViewerGeneralTapType.tap:
              return false; // let default handling (clears selection, etc.)
          }
        },
        onKey: (params, key, isRealKeyPress) {
          final isCommandPressed =
              HardwareKeyboard.instance.isControlPressed || HardwareKeyboard.instance.isMetaPressed;
          if (key == LogicalKeyboardKey.digit0 && isCommandPressed) {
            final fitZoom = _pdfController.coverScale;
            _pdfController.setZoom(
              _pdfController.centerPosition,
              fitZoom,
              duration: const Duration(milliseconds: 200),
            );
            return true;
          }
          return false;
        },
        keyHandlerParams: const PdfViewerKeyHandlerParams(autofocus: true),
        zoomStepsDelegateProvider: const _TwoStopZoomStepsProvider(),
        scrollPhysics: const ClampingScrollPhysics(),
        viewerOverlayBuilder: (context, size, handleLinkTap) {
          final pageCount = _pdfController.pageCount;
          if (pageCount <= 1) return <Widget>[];
          return <Widget>[
            PdfFastScroll(controller: _pdfController),
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