import 'package:flutter/material.dart';

class PdfBadgeIcon extends StatelessWidget {
  const PdfBadgeIcon({super.key, this.size = 20});

  final double size;

  @override
  Widget build(BuildContext context) {
    final badgeWidth = size * 1.3;
    final badgeHeight = size * 0.75;

    return Container(
      width: badgeWidth,
      height: badgeHeight,
      padding: const EdgeInsets.symmetric(horizontal: 2),
      decoration: BoxDecoration(
        color: const Color(0xFFD32F2F),
        borderRadius: BorderRadius.circular(3),
      ),
      alignment: Alignment.center,
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Text(
          'PDF',
          style: TextStyle(
            color: Colors.white,
            fontSize: size * 0.5,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.2,
          ),
        ),
      ),
    );
  }
}