import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_spacing.dart';
import 'app_text_styles.dart';
import 'shelf_colors.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get theme {
    final c = ShelfColors.light;
    final ts = AppTextStyles.instance;
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: AppColors.background,
      // Semantic token layer (Phase 1) — resolved from context via
      // context.colors (ShelfColorsX in shelf_colors.dart).
      extensions: [c],
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.textPrimary,
        surface: AppColors.background,
        brightness: Brightness.light,
      ),
      textTheme: TextTheme(
        headlineLarge: ts.largeTitle(c),
        titleLarge: ts.sectionTitle(c),
        bodyLarge: ts.body(c),
        bodyMedium: ts.bodySecondary(c),
        labelMedium: ts.metadata(c),
      ),
      // Minimal shadow, small radius, charcoal-on-cream — no giant
      // rounded cards or elevation drama.
      cardTheme: CardThemeData(
        color: AppColors.surfaceCard,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
          side: const BorderSide(color: AppColors.border, width: 1),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryButton,
          foregroundColor: AppColors.onPrimaryButton,
          elevation: 0,
          padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.md),
          ),
          textStyle: ts.buttonLabel(c),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.textPrimary,
          side: const BorderSide(color: AppColors.textPrimary, width: 1),
          padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.md),
          ),
          textStyle: ts.buttonLabel(c),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        // Minimalist underline field per DESIGN.md — no filled boxes.
        border: const UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.border),
        ),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.border),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.textPrimary, width: 2),
        ),
        labelStyle: ts.bodySecondary(c),
        floatingLabelStyle: ts.metadata(c),
      ),
      dividerTheme: const DividerThemeData(
        color: AppColors.divider,
        thickness: 1,
        space: AppSpacing.md,
      ),
      splashFactory: NoSplash.splashFactory,
      highlightColor: Colors.transparent,
      // Phase 1: pinned component slots — these previously fell through to
      // ColorScheme.fromSeed-derived defaults (source of the FAB color bug
      // and the ListTile contrast bug).
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: c.accent,
        foregroundColor: c.onAccent,
      ),
      listTileTheme: ListTileThemeData(
        iconColor: c.textPrimary,
        textColor: c.textPrimary,
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: c.surface,
        titleTextStyle: ts.sectionTitle(c),
        contentTextStyle: ts.body(c),
      ),
      // Intentional exception: ShelfColors has no "inverse" role, so the
      // snackbar pins the OPPOSITE mode's tokens — dark snackbar on light
      // theme, light snackbar on dark theme (matches M3 inverse behavior).
      snackBarTheme: SnackBarThemeData(
        backgroundColor: ShelfColors.dark.background,
        contentTextStyle: ts.body(ShelfColors.dark),
      ),
      // Only the active state is pinned to the accent; unselected states
      // keep Material's defaults.
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith(
          (states) => states.contains(WidgetState.selected) ? c.onAccent : null,
        ),
        trackColor: WidgetStateProperty.resolveWith(
          (states) => states.contains(WidgetState.selected) ? c.accent : null,
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: c.accent,
          foregroundColor: c.onAccent,
        ),
      ),
      progressIndicatorTheme: ProgressIndicatorThemeData(color: c.accent),
      // Matches AppScaffold's current explicit values; AppScaffold itself is
      // not changed in this task.
      appBarTheme: AppBarThemeData(
        backgroundColor: c.background,
        foregroundColor: c.textPrimary,
      ),
      bottomSheetTheme: BottomSheetThemeData(backgroundColor: c.surface),
    );
  }

  static ThemeData get darkTheme {
    final c = ShelfColors.dark;
    final ts = AppTextStyles.instance;
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: AppColors.backgroundDark,
      extensions: [c],
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.textPrimaryDark,
        surface: AppColors.backgroundDark,
        brightness: Brightness.dark,
      ),
      textTheme: TextTheme(
        headlineLarge: ts.largeTitle(c),
        titleLarge: ts.sectionTitle(c),
        bodyLarge: ts.body(c),
        bodyMedium: ts.bodySecondary(c),
        labelMedium: ts.metadata(c),
      ),
      cardTheme: CardThemeData(
        color: AppColors.surfaceCardDark,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
          side: const BorderSide(color: AppColors.borderDark, width: 1),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryButton,
          foregroundColor: AppColors.onPrimaryButton,
          elevation: 0,
          padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.md),
          ),
          textStyle: ts.buttonLabel(c),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.textPrimaryDark,
          side: const BorderSide(color: AppColors.textPrimaryDark, width: 1),
          padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.md),
          ),
          textStyle: ts.buttonLabel(c),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: const UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.borderDark),
        ),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.borderDark),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.textPrimaryDark, width: 2),
        ),
        labelStyle: ts.bodySecondary(c),
        floatingLabelStyle: ts.metadata(c),
      ),
      dividerTheme: const DividerThemeData(
        color: AppColors.dividerDark,
        thickness: 1,
        space: AppSpacing.md,
      ),
      splashFactory: NoSplash.splashFactory,
      highlightColor: Colors.transparent,
      // Phase 1: pinned component slots (see light theme for rationale).
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: c.accent,
        foregroundColor: c.onAccent,
      ),
      listTileTheme: ListTileThemeData(
        iconColor: c.textPrimary,
        textColor: c.textPrimary,
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: c.surface,
        titleTextStyle: ts.sectionTitle(c),
        contentTextStyle: ts.body(c),
      ),
      // Snackbar uses the OPPOSITE mode's tokens (see light theme).
      snackBarTheme: SnackBarThemeData(
        backgroundColor: ShelfColors.light.background,
        contentTextStyle: ts.body(ShelfColors.light),
      ),
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith(
          (states) => states.contains(WidgetState.selected) ? c.onAccent : null,
        ),
        trackColor: WidgetStateProperty.resolveWith(
          (states) => states.contains(WidgetState.selected) ? c.accent : null,
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: c.accent,
          foregroundColor: c.onAccent,
        ),
      ),
      progressIndicatorTheme: ProgressIndicatorThemeData(color: c.accent),
      appBarTheme: AppBarThemeData(
        backgroundColor: c.background,
        foregroundColor: c.textPrimary,
      ),
      bottomSheetTheme: BottomSheetThemeData(backgroundColor: c.surface),
    );
  }
}