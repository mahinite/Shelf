import 'package:flutter/material.dart';
import 'app_colors.dart';

/// A very subtle, static grid — meant to read as paper texture, not
/// as a visible design element. If you can consciously notice the grid
/// while reading content on top of it, the opacity is too high.
///
/// Wrap a screen's content with this instead of setting a flat
/// background color.
class NotebookBackground extends StatelessWidget {
  const NotebookBackground({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.background,
      child: CustomPaint(
        painter: _GridPainter(),
        child: child,
      ),
    );
  }
}

class _GridPainter extends CustomPainter {
  static const double _spacing = 24;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      // Extremely low opacity charcoal — texture, not a visible line.
      ..color = AppColors.textPrimary.withValues(alpha: 0.035)
      ..strokeWidth = 1;

    for (double y = 0; y < size.height; y += _spacing) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant _GridPainter oldDelegate) => false;
}
