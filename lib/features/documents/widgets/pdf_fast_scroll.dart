import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pdfrx/pdfrx.dart';

import '../../../core/theme/app_text_styles.dart';
import '../../../core/theme/shelf_colors.dart';

/// Handle diameter in logical pixels.
const double _kHandleDiameter = 48.0;
/// Inset from the right edge of the viewer.
const double _kHandleInset = 4.0;
/// Extra invisible touch margin around the handle.
const double _kTouchMargin = 8.0;
/// Vertical track margins (top/bottom).
const double _kTrackMargin = 8.0;
/// Pill corner radius.
const double _kPillRadius = 16.0;
/// How long the handle stays visible after the document opens.
const Duration _kInitialShowDuration = Duration(seconds: 2);
/// How long to wait after the last scroll/drag before fading out.
const Duration _kHideDelay = Duration(milliseconds: 1500);
/// Fade animation duration.
const Duration _kFadeDuration = Duration(milliseconds: 200);

/// A Drive-style fast-scroll handle with a page indicator pill.
///
/// The handle appears on the right edge of the viewer and represents the
/// vertical scroll position. Dragging it jumps the viewer to the corresponding
/// document position. A pill showing "current / total" pages sits to the left
/// of the handle and moves with it.
///
/// The handle auto-hides after a period of inactivity and reappears on scroll.
/// It is hidden entirely for single-page documents.
class PdfFastScroll extends StatefulWidget {
  const PdfFastScroll({
    super.key,
    required this.controller,
  });

  final PdfViewerController controller;

  @override
  State<PdfFastScroll> createState() => _PdfFastScrollState();
}

class _PdfFastScrollState extends State<PdfFastScroll> with SingleTickerProviderStateMixin {
  late final AnimationController _opacityController;
  Timer? _hideTimer;
  bool _isDragging = false;
  double? _dragFraction; // 0.0 .. 1.0 during drag
  bool _isReady = false;

  @override
  void initState() {
    super.initState();
    _opacityController = AnimationController(
      vsync: this,
      duration: _kFadeDuration,
    );
    _opacityController.value = 0.0;
    _startInitialShow();
  }

  @override
  void dispose() {
    _hideTimer?.cancel();
    _opacityController.dispose();
    super.dispose();
  }

  void _startInitialShow() {
    _setVisible(true);
    _hideTimer?.cancel();
    _hideTimer = Timer(_kInitialShowDuration, () {
      if (!_isDragging && mounted) {
        _setVisible(false);
      }
    });
  }

  void _onScrollOrDrag() {
    if (!_isReady) {
      _isReady = true;
      _startInitialShow();
      return;
    }
    _setVisible(true);
    _hideTimer?.cancel();
    _hideTimer = Timer(_kHideDelay, () {
      if (!_isDragging && mounted) {
        _setVisible(false);
      }
    });
  }

  void _setVisible(bool visible) {
    if (!mounted) return;
    if (visible) {
      _opacityController.forward();
    } else {
      _opacityController.reverse();
    }
  }

  void _onDragStart(DragStartDetails details, BoxConstraints constraints) {
    _isDragging = true;
    _hideTimer?.cancel();
    _setVisible(true);
    _updateDragFraction(details.localPosition, constraints);
  }

  void _onDragUpdate(DragUpdateDetails details, BoxConstraints constraints) {
    _updateDragFraction(details.localPosition, constraints);
    _jumpToFraction(_dragFraction!);
  }

  void _onDragEnd(DragEndDetails details, BoxConstraints constraints) {
    _isDragging = false;
    _dragFraction = null;
    _onScrollOrDrag(); // restart hide timer
  }

  void _updateDragFraction(Offset localPos, BoxConstraints constraints) {
    final trackHeight = constraints.maxHeight - 2 * _kTrackMargin;
    final dy = localPos.dy - _kTrackMargin;
    final fraction = (dy / trackHeight).clamp(0.0, 1.0);
    setState(() => _dragFraction = fraction);
  }

  void _jumpToFraction(double fraction) {
    final controller = widget.controller;
    if (!controller.isReady) return;

    final view = controller.visibleRect;
    final all = controller.documentSize;
    final boundaryMargin = controller.params.boundaryMargin;

    final effectiveDocHeight = boundaryMargin == null || boundaryMargin.vertical.isInfinite
        ? all.height
        : all.height + boundaryMargin.vertical;

    if (effectiveDocHeight <= view.height) return;

    final scrollRange = effectiveDocHeight - view.height;
    final minScrollY = boundaryMargin == null || boundaryMargin.vertical.isInfinite ? 0.0 : -boundaryMargin.top;

    final targetY = -(fraction * scrollRange + minScrollY);
    final m = controller.value.clone();
    m.y = targetY;
    controller.value = controller.makeMatrixInSafeRange(m, forceClamp: true);
  }

  int _pageFromFraction(double fraction) {
    final controller = widget.controller;
    if (!controller.isReady || controller.layout.pageLayouts.isEmpty) return 1;

    final view = controller.visibleRect;
    final all = controller.documentSize;
    final boundaryMargin = controller.params.boundaryMargin;

    final effectiveDocHeight = boundaryMargin == null || boundaryMargin.vertical.isInfinite
        ? all.height
        : all.height + boundaryMargin.vertical;

    if (effectiveDocHeight <= view.height) return 1;

    final scrollRange = effectiveDocHeight - view.height;
    final minScrollY = boundaryMargin == null || boundaryMargin.vertical.isInfinite ? 0.0 : -boundaryMargin.top;

    // Simulate the visibleRect that would result from this fraction
    final targetY = -(fraction * scrollRange + minScrollY);
    final simulatedVisibleTop = -targetY;
    final simulatedVisibleBottom = simulatedVisibleTop + view.height;

    // Find the page whose layout rect is most centered in the simulated viewport
    final layouts = controller.layout.pageLayouts;
    int bestPage = 1;
    double bestDist = double.infinity;

    for (int i = 0; i < layouts.length; i++) {
      final pageRect = layouts[i];
      final pageCenter = (pageRect.top + pageRect.bottom) / 2;
      final viewportCenter = (simulatedVisibleTop + simulatedVisibleBottom) / 2;
      final dist = (pageCenter - viewportCenter).abs();
      if (dist < bestDist) {
        bestDist = dist;
        bestPage = i + 1;
      }
    }
    return bestPage;
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Matrix4>(
      valueListenable: widget.controller,
      builder: (context, matrix, child) {
        if (!widget.controller.isReady) return const SizedBox.shrink();

        final pageCount = widget.controller.pageCount;
        if (pageCount <= 1) return const SizedBox.shrink();

        final view = widget.controller.visibleRect;
        final all = widget.controller.documentSize;
        final boundaryMargin = widget.controller.params.boundaryMargin;

        final effectiveDocHeight = boundaryMargin == null || boundaryMargin.vertical.isInfinite
            ? all.height
            : all.height + boundaryMargin.vertical;

        if (effectiveDocHeight <= view.height) return const SizedBox.shrink();

        // Notify about scroll changes (but not during our own drag)
        if (!_isDragging) {
          _onScrollOrDrag();
        }

        // Compute current scroll fraction from matrix
        final scrollRange = effectiveDocHeight - view.height;
        final minScrollY = boundaryMargin == null || boundaryMargin.vertical.isInfinite ? 0.0 : -boundaryMargin.top;
        final currentFraction = ((-matrix.y - minScrollY) / scrollRange).clamp(0.0, 1.0);

        // Determine current page for the pill
        final currentPage = _isDragging && _dragFraction != null
            ? _pageFromFraction(_dragFraction!)
            : (widget.controller.pageNumber ?? 1);

        return LayoutBuilder(
          builder: (context, constraints) {
            final trackHeight = constraints.maxHeight - 2 * _kTrackMargin;
            final handleTop = _kTrackMargin + currentFraction * trackHeight - _kHandleDiameter / 2;

            return Stack(
              clipBehavior: Clip.none,
              children: [
                // Invisible touch area for the handle
                Positioned(
                  right: _kHandleInset - _kTouchMargin,
                  top: handleTop - _kTouchMargin,
                  width: _kHandleDiameter + 2 * _kTouchMargin,
                  height: _kHandleDiameter + 2 * _kTouchMargin,
                  child: IgnorePointer(
                    ignoring: !_isDragging,
                    child: AnimatedBuilder(
                      animation: _opacityController,
                      builder: (context, child) => Opacity(
                        opacity: _opacityController.value,
                        child: child,
                      ),
                      child: GestureDetector(
                        onPanStart: (details) => _onDragStart(details, constraints),
                        onPanUpdate: (details) => _onDragUpdate(details, constraints),
                        onPanEnd: (details) => _onDragEnd(details, constraints),
                        behavior: HitTestBehavior.translucent,
                        child: const SizedBox.expand(),
                      ),
                    ),
                  ),
                ),
                // The handle + pill, wrapped in AnimatedOpacity for fade
                AnimatedBuilder(
                  animation: _opacityController,
                  builder: (context, child) => Opacity(
                    opacity: _opacityController.value,
                    child: child,
                  ),
                  child: Positioned(
                    right: _kHandleInset,
                    top: handleTop,
                    width: _kHandleDiameter,
                    height: _kHandleDiameter,
                    child: _HandleWithPill(
                      pageText: '$currentPage / $pageCount',
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}

/// Internal widget that draws the circular handle with chevrons and the page pill.
class _HandleWithPill extends StatelessWidget {
  const _HandleWithPill({required this.pageText});

  final String pageText;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<ShelfColors>()!;

    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Page pill
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          margin: const EdgeInsets.only(right: 6),
          decoration: BoxDecoration(
            color: colors.surfaceSubtle,
            borderRadius: BorderRadius.circular(_kPillRadius),
            border: Border.all(color: colors.border, width: 1),
          ),
          child: Text(
            pageText,
            style: context.textStyles.metadata(colors).copyWith(
              color: colors.textPrimary,
              fontSize: 11,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        // Circular handle with chevrons
        Container(
          width: _kHandleDiameter,
          height: _kHandleDiameter,
          decoration: BoxDecoration(
            color: colors.accent,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.keyboard_arrow_up,
                  color: colors.onAccent,
                  size: 18,
                ),
                Icon(
                  Icons.keyboard_arrow_down,
                  color: colors.onAccent,
                  size: 18,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}