import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pdfrx/pdfrx.dart';

import '../../../core/theme/app_text_styles.dart';
import '../../../core/theme/shelf_colors.dart';

/// Handle diameter in logical pixels.
const double _kHandleDiameter = 48.0;
/// Inset from the right edge of the viewer.
const double _kHandleInset = 4.0;
/// Vertical track margins (top/bottom).
const double _kTrackMargin = 8.0;
/// Pill corner radius.
const double _kPillRadius = 16.0;
/// Pill height.
const double _kPillHeight = 28.0;
/// How long the handle stays visible after the document opens.
const Duration _kInitialShowDuration = Duration(seconds: 2);
/// How long to wait after the last scroll/drag before fading out.
const Duration _kHideDelay = Duration(milliseconds: 1500);
/// Fade animation duration.
const Duration _kFadeDuration = Duration(milliseconds: 200);
/// Logging toggle for this iteration.
const bool _kLogFastScroll = true;

/// A Drive-style fast-scroll handle with a page indicator pill.
///
/// The handle appears on the right edge of the viewer and represents the
/// vertical scroll position. Dragging it jumps the viewer to the corresponding
/// document position. A pill showing "current / total" pages sits to the left
/// of the handle and moves with it.
///
/// The handle auto-hides after a period of inactivity and reappears on scroll.
/// It is hidden entirely for single-page documents or when the document fits.
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
  Timer? _logThrottleTimer;
  bool _isDragging = false;
  double _startFraction = 0.0;
  double? _currentFraction;
  bool _isReady = false;
  int _lastNotifiedPage = 1;

  @override
  void initState() {
    super.initState();
    _opacityController = AnimationController(
      vsync: this,
      duration: _kFadeDuration,
    );
    _opacityController.value = 0.0;
    _startInitialShow();
    // Listen to controller matrix changes for scroll tracking (outside build)
    widget.controller.addListener(_onControllerChange);
  }

  @override
  void dispose() {
    _hideTimer?.cancel();
    _logThrottleTimer?.cancel();
    widget.controller.removeListener(_onControllerChange);
    _opacityController.dispose();
    super.dispose();
  }

  void _onControllerChange() {
    if (_isDragging) return;
    _restartHideTimer();
    _throttledLogNotify();
  }

  void _throttledLogNotify() {
    if (!_kLogFastScroll) return;
    if (_logThrottleTimer?.isActive ?? false) return;
    _logThrottleTimer = Timer(const Duration(milliseconds: 250), () {
      if (!mounted) return;
      final c = widget.controller;
      if (!c.isReady) return;
      debugPrint('SHELF_FS notify page=${c.pageNumber} visibleTop=${c.visibleRect.top.toStringAsFixed(1)} zoom=${c.currentZoom.toStringAsFixed(3)}');
    });
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

  void _restartHideTimer() {
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

  void _onDragStart(DragStartDetails details) {
    _isDragging = true;
    _hideTimer?.cancel();
    _setVisible(true);
    // Capture the fraction at drag start; use current visible fraction
    final frac = _computeCurrentFraction();
    if (frac != null) {
      _startFraction = frac;
      _currentFraction = frac;
      if (_kLogFastScroll) {
        debugPrint('SHELF_FS dragStart startFraction=${_startFraction.toStringAsFixed(3)}');
      }
    }
  }

  void _onDragUpdate(DragUpdateDetails details) {
    if (_currentFraction == null) return;
    final trackLength = _trackLength;
    if (trackLength <= 0) return;
    // Accumulate delta: drag down (positive dy) moves handle down -> scroll down -> fraction increases
    final deltaFraction = details.delta.dy / trackLength;
    _currentFraction = (_startFraction + deltaFraction).clamp(0.0, 1.0);
    setState(() {});
    _jumpToFraction(_currentFraction!);
    if (_kLogFastScroll) {
      debugPrint('SHELF_FS dragUpdate fraction=${_currentFraction!.toStringAsFixed(3)} deltaFraction=${deltaFraction.toStringAsFixed(4)}');
    }
  }

  void _onDragEnd(DragEndDetails details) {
    _isDragging = false;
    _startFraction = 0.0;
    _currentFraction = null;
    _restartHideTimer();
    if (_kLogFastScroll) {
      debugPrint('SHELF_FS dragEnd');
    }
  }

  void _onDragCancel() {
    _isDragging = false;
    _startFraction = 0.0;
    _currentFraction = null;
    _restartHideTimer();
    if (_kLogFastScroll) {
      debugPrint('SHELF_FS dragCancel');
    }
  }

  double? _computeCurrentFraction() {
    final c = widget.controller;
    if (!c.isReady) return null;
    final viewHeightDoc = c.visibleRect.height;
    final docHeight = c.documentSize.height;
    final denom = docHeight - viewHeightDoc;
    if (denom <= 0) return 0.0;
    return (c.visibleRect.top / denom).clamp(0.0, 1.0);
  }

  double get _trackLength {
    final constraints = _lastConstraints;
    if (constraints == null) return 0.0;
    return constraints.maxHeight - _kHandleDiameter - 2 * _kTrackMargin;
  }

  BoxConstraints? _lastConstraints;

  void _jumpToFraction(double fraction) {
    final c = widget.controller;
    if (!c.isReady) {
      if (_kLogFastScroll) debugPrint('SHELF_FS jump ABORT controller not ready');
      return;
    }
    final viewHeightDoc = c.visibleRect.height;
    final docHeight = c.documentSize.height;
    final denom = docHeight - viewHeightDoc;
    if (denom <= 0) {
      if (_kLogFastScroll) debugPrint('SHELF_FS jump ABORT no scroll needed docHeight=$docHeight viewHeightDoc=$viewHeightDoc');
      return;
    }
    final targetTop = fraction * denom;
    final targetY = -targetTop / c.currentZoom;
    final m = c.value.clone();
    m.y = targetY;
    c.value = c.makeMatrixInSafeRange(m, forceClamp: true);
    if (_kLogFastScroll) {
      debugPrint('SHELF_FS jump fraction=${fraction.toStringAsFixed(3)} targetTop=${targetTop.toStringAsFixed(1)} targetY=${targetY.toStringAsFixed(1)} zoom=${c.currentZoom.toStringAsFixed(3)}');
    }
  }

  int _pageFromFraction(double fraction) {
    final c = widget.controller;
    if (!c.isReady || c.layout.pageLayouts.isEmpty) return 1;
    final viewHeightDoc = c.visibleRect.height;
    final docHeight = c.documentSize.height;
    final denom = docHeight - viewHeightDoc;
    if (denom <= 0) return 1;
    final targetTop = fraction * denom;
    final targetBottom = targetTop + viewHeightDoc;
    final viewportCenter = (targetTop + targetBottom) / 2;
    int bestPage = 1;
    double bestDist = double.infinity;
    for (int i = 0; i < c.layout.pageLayouts.length; i++) {
      final pageRect = c.layout.pageLayouts[i];
      final pageCenter = (pageRect.top + pageRect.bottom) / 2;
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

        final viewHeightDoc = widget.controller.visibleRect.height;
        final docHeight = widget.controller.documentSize.height;
        final denom = docHeight - viewHeightDoc;
        if (denom <= 0) return const SizedBox.shrink();

        // Compute current fraction from matrix
        final currentFraction = _computeCurrentFraction() ?? 0.0;

        // Determine current page for the pill
        final currentPage = _isDragging && _currentFraction != null
            ? _pageFromFraction(_currentFraction!)
            : (widget.controller.pageNumber ?? 1);

        return Positioned.fill(
          child: LayoutBuilder(
            builder: (context, constraints) {
              _lastConstraints = constraints;
              final trackLength = constraints.maxHeight - _kHandleDiameter - 2 * _kTrackMargin;
              if (trackLength <= 0) return const SizedBox.shrink();

              final handleTop = _kTrackMargin + currentFraction * trackLength;

              // Log first layout
              if (_kLogFastScroll && _lastLoggedConstraints != constraints) {
                _lastLoggedConstraints = constraints;
                debugPrint('SHELF_FS layout constraints=${constraints.biggest} trackLength=${trackLength.toStringAsFixed(1)} handleTop=${handleTop.toStringAsFixed(1)}');
              }

              return Stack(
                clipBehavior: Clip.none,
                children: [
                  // Handle + pill as a single draggable widget at the right edge
                  Positioned(
                    right: _kHandleInset,
                    top: handleTop,
                    child: AnimatedBuilder(
                      animation: _opacityController,
                      builder: (context, child) => Opacity(
                        opacity: _opacityController.value,
                        child: IgnorePointer(
                          ignoring: _opacityController.value == 0.0,
                          child: child,
                        ),
                      ),
                      child: GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onVerticalDragStart: _onDragStart,
                        onVerticalDragUpdate: _onDragUpdate,
                        onVerticalDragEnd: _onDragEnd,
                        onVerticalDragCancel: _onDragCancel,
                        child: _HandleWithPill(
                          pageText: '$currentPage / $pageCount',
                          handleDiameter: _kHandleDiameter,
                          pillHeight: _kPillHeight,
                          pillRadius: _kPillRadius,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }

  BoxConstraints? _lastLoggedConstraints;
}

/// Internal widget that draws the circular handle with chevrons and the page pill.
class _HandleWithPill extends StatelessWidget {
  const _HandleWithPill({
    required this.pageText,
    required this.handleDiameter,
    required this.pillHeight,
    required this.pillRadius,
  });

  final String pageText;
  final double handleDiameter;
  final double pillHeight;
  final double pillRadius;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<ShelfColors>()!;

    // Pill uses the SAME fill and on-fill as the handle: accent / onAccent
    final Color pillFill = colors.accent;
    final Color pillTextColor = colors.onAccent;
    final Color handleFill = colors.accent;
    final Color handleIconColor = colors.onAccent;

    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Page pill
        Container(
          height: pillHeight,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          margin: const EdgeInsets.only(right: 6),
          decoration: BoxDecoration(
            color: pillFill,
            borderRadius: BorderRadius.circular(pillRadius),
          ),
          alignment: Alignment.center,
          child: Text(
            pageText,
            style: context.textStyles.metadata(colors).copyWith(
              color: pillTextColor,
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        // Circular handle with chevrons
        Container(
          width: handleDiameter,
          height: handleDiameter,
          decoration: BoxDecoration(
            color: handleFill,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.keyboard_arrow_up,
                  color: handleIconColor,
                  size: 18,
                ),
                Icon(
                  Icons.keyboard_arrow_down,
                  color: handleIconColor,
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