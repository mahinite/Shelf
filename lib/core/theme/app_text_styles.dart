import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'shelf_colors.dart';

/// Text styles, built on Inter. Only the styles the MVP screens actually
/// use are defined here (large title, section title, body, small metadata) —
/// DESIGN.md's full type scale has more steps we don't need yet.
class AppTextStyles {
  static const AppTextStyles instance = AppTextStyles._internal();

  const AppTextStyles._internal();

  TextStyle largeTitle(ShelfColors c) => GoogleFonts.inter(
        fontSize: 30,
        fontWeight: FontWeight.w700,
        color: c.textPrimary,
        height: 1.2,
      );

  TextStyle sectionTitle(ShelfColors c) => GoogleFonts.inter(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: c.textPrimary,
        height: 1.3,
      );

  TextStyle body(ShelfColors c) => GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: c.textPrimary,
        height: 1.4,
      );

  TextStyle bodySecondary(ShelfColors c) => GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: c.textSecondary,
        height: 1.4,
      );

  TextStyle metadata(ShelfColors c) => GoogleFonts.inter(
        fontSize: 13,
        fontWeight: FontWeight.w500,
        color: c.textSecondary,
        letterSpacing: 0.2,
      );

  TextStyle buttonLabel(ShelfColors c) => GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w500, // medium, not bold — "quiet" emphasis
      );
}

/// Context accessor for theme-aware text styles.
/// Usage: `context.textStyles.body(context.colors)`
extension AppTextStylesX on BuildContext {
  AppTextStyles get textStyles => AppTextStyles.instance;
}