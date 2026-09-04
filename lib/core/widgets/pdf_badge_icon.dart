import 'package:flutter/material.dart';

class PdfBadgeIcon extends StatelessWidget {
  const PdfBadgeIcon({super.key, this.size = 20});

  final double size;

  @override
  Widget build(BuildContext context) {
    final badgeWidth = size;
    final badgeHeight = size * 0.7;
    final fontSize = size * 0.45;

    return Container(
      width: badgeWidth,
      height: badgeHeight,
      decoration: BoxDecoration(
        color: const Color(0xFFD32F2F),
        borderRadius: BorderRadius.circular(3),
      ),
      alignment: Alignment.center,
      child: Text(
        'PDF',
        style: TextStyle(
          color: Colors.white,
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.2,
        ),
      ),
    );
  }
}