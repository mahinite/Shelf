import 'package:flutter/material.dart';

import 'app_colors.dart';

/// Semantic color tokens for Shelf (Layer 2 of
/// docs/ui-token-direction-plan.md), resolved from the active ThemeData.
///
/// Widgets read roles (background, surface, accent, textPrimary...) via
/// `context.colors` instead of referencing AppColors primitives or
/// fromSeed-derived colors directly. Both modes are defined once here and
/// registered on ThemeData in app_theme.dart. Field values stay linked to
/// the AppColors primitives so future DESIGN.md corrections propagate
/// automatically; derived tints use withValues(alpha:), the project's
/// existing idiom.
class ShelfColors extends ThemeExtension<ShelfColors> {
  const ShelfColors({
    required this.background,
    required this.surface,
    required this.surfaceSubtle,
    required this.border,
    required this.divider,
    required this.gridLine,
    required this.textPrimary,
    required this.textSecondary,
    required this.accent,
    required this.onAccent,
    required this.destructive,
  });

  /// Page/scaffold and app bar background.
  final Color background;

  /// Cards, bottom bar, sheets, dialogs — Level 1 surface.
  final Color surface;

  /// Soft fills/chips — ~10% tint of the mode's accent base.
  final Color surfaceSubtle;

  /// 1px outlines on cards, bars, pickers.
  final Color border;

  /// List separators.
  final Color divider;

  /// Notebook background grid base color; the painter applies the low alpha.
  final Color gridLine;

  /// Primary text and icons.
  final Color textPrimary;

  /// Secondary/muted text and icons.
  final Color textSecondary;

  /// Primary-action fill: FABs, scan circle, save button, active switch.
  /// Light: charcoal (DESIGN.md 'primary'). Dark: 'primary-fixed-dim'.
  final Color accent;

  /// Text/icons rendered on [accent].
  final Color onAccent;

  /// Destructive actions (delete).
  final Color destructive;

  static final ShelfColors light = ShelfColors(
    background: AppColors.background,
    surface: AppColors.surfaceCard,
    surfaceSubtle: AppColors.primaryButton.withValues(alpha: 0.10),
    border: AppColors.border,
    divider: AppColors.divider,
    gridLine: AppColors.textPrimary,
    textPrimary: AppColors.textPrimary,
    textSecondary: AppColors.textSecondary,
    accent: AppColors.primaryButton,
    onAccent: AppColors.onPrimaryButton,
    destructive: AppColors.destructive,
  );

  static final ShelfColors dark = ShelfColors(
    background: AppColors.backgroundDark,
    surface: AppColors.surfaceCardDark,
    surfaceSubtle: AppColors.primaryFixedDim.withValues(alpha: 0.10),
    border: AppColors.borderDark,
    divider: AppColors.dividerDark,
    gridLine: AppColors.textPrimaryDark,
    textPrimary: AppColors.textPrimaryDark,
    textSecondary: AppColors.textSecondaryDark,
    accent: AppColors.primaryFixedDim,
    onAccent: AppColors.backgroundDark,
    destructive: AppColors.destructive,
  );

  @override
  ShelfColors copyWith({
    Color? background,
    Color? surface,
    Color? surfaceSubtle,
    Color? border,
    Color? divider,
    Color? gridLine,
    Color? textPrimary,
    Color? textSecondary,
    Color? accent,
    Color? onAccent,
    Color? destructive,
  }) {
    return ShelfColors(
      background: background ?? this.background,
      surface: surface ?? this.surface,
      surfaceSubtle: surfaceSubtle ?? this.surfaceSubtle,
      border: border ?? this.border,
      divider: divider ?? this.divider,
      gridLine: gridLine ?? this.gridLine,
      textPrimary: textPrimary ?? this.textPrimary,
      textSecondary: textSecondary ?? this.textSecondary,
      accent: accent ?? this.accent,
      onAccent: onAccent ?? this.onAccent,
      destructive: destructive ?? this.destructive,
    );
  }

  @override
  ShelfColors lerp(ThemeExtension<ShelfColors>? other, double t) {
    if (other is! ShelfColors) {
      return this;
    }
    return ShelfColors(
      background: Color.lerp(background, other.background, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      surfaceSubtle: Color.lerp(surfaceSubtle, other.surfaceSubtle, t)!,
      border: Color.lerp(border, other.border, t)!,
      divider: Color.lerp(divider, other.divider, t)!,
      gridLine: Color.lerp(gridLine, other.gridLine, t)!,
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t)!,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
      accent: Color.lerp(accent, other.accent, t)!,
      onAccent: Color.lerp(onAccent, other.onAccent, t)!,
      destructive: Color.lerp(destructive, other.destructive, t)!,
    );
  }

  @override
  bool operator ==(Object other) =>
      other is ShelfColors &&
      other.background == background &&
      other.surface == surface &&
      other.surfaceSubtle == surfaceSubtle &&
      other.border == border &&
      other.divider == divider &&
      other.gridLine == gridLine &&
      other.textPrimary == textPrimary &&
      other.textSecondary == textSecondary &&
      other.accent == accent &&
      other.onAccent == onAccent &&
      other.destructive == destructive;

  @override
  int get hashCode => Object.hash(background, surface, surfaceSubtle, border,
      divider, gridLine, textPrimary, textSecondary, accent, onAccent,
      destructive);
}

extension ShelfColorsX on BuildContext {
  /// The active mode's semantic color tokens.
  ShelfColors get colors => Theme.of(this).extension<ShelfColors>()!;
}
