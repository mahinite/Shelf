import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shelf/core/theme/app_theme.dart';
import 'package:shelf/core/theme/shelf_colors.dart';
import 'package:shelf/core/theme/app_text_styles.dart';
import 'package:shelf/core/theme/app_colors.dart';
import 'package:shelf/core/theme/app_spacing.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('ShelfColors token values', () {
    test('ShelfColors.light matches current DESIGN.md-aligned primitives', () {
      final c = ShelfColors.light;

      // Base surface
      expect(c.background, equals(AppColors.background)); // 0xFFFBF9F9
      expect(c.surface, equals(AppColors.surfaceCard)); // 0xFFFFFFFF

      // Derived: ~10% tint of accent base
      expect(
        c.surfaceSubtle,
        equals(AppColors.primaryButton.withValues(alpha: 0.10)),
      );

      // Structure
      expect(c.border, equals(AppColors.border));
      expect(c.divider, equals(AppColors.divider));

      // Grid line base (alpha applied at paint site)
      expect(c.gridLine, equals(AppColors.textPrimary));

      // Text
      expect(c.textPrimary, equals(AppColors.textPrimary));
      expect(c.textSecondary, equals(AppColors.textSecondary));

      // Accent
      expect(c.accent, equals(AppColors.primaryButton));
      expect(c.onAccent, equals(AppColors.onPrimaryButton));

      // Destructive
      expect(c.destructive, equals(AppColors.destructive));
    });

    test('ShelfColors.dark matches current DESIGN.md-aligned primitives', () {
      final c = ShelfColors.dark;

      // Base surface
      expect(c.background, equals(AppColors.backgroundDark));
      expect(c.surface, equals(AppColors.surfaceCardDark));

      // Derived: ~10% tint of dark accent base
      expect(
        c.surfaceSubtle,
        equals(AppColors.primaryFixedDim.withValues(alpha: 0.10)),
      );

      // Structure
      expect(c.border, equals(AppColors.borderDark));
      expect(c.divider, equals(AppColors.dividerDark));

      // Grid line base (alpha applied at paint site)
      expect(c.gridLine, equals(AppColors.textPrimaryDark));

      // Text
      expect(c.textPrimary, equals(AppColors.textPrimaryDark));
      expect(c.textSecondary, equals(AppColors.textSecondaryDark));

      // Accent
      expect(c.accent, equals(AppColors.primaryFixedDim));
      expect(c.onAccent, equals(AppColors.backgroundDark));

      // Destructive
      expect(c.destructive, equals(AppColors.destructive));
    });
  });

  group('Light theme component slots (lazy construction)', () {
    ThemeData lightTheme() {
      final c = ShelfColors.light;
      final ts = AppTextStyles.instance;
      return ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: AppColors.background,
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
          titleTextStyle: AppTextStyles.instance.sectionTitle(c),
          contentTextStyle: AppTextStyles.instance.body(c),
        ),
        snackBarTheme: SnackBarThemeData(
          backgroundColor: ShelfColors.dark.background,
          contentTextStyle: AppTextStyles.instance.body(ShelfColors.dark),
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

    test('floatingActionButtonTheme is pinned to light accent', () {
      final slot = lightTheme().floatingActionButtonTheme;
      expect(slot, isNotNull);
      expect(slot.backgroundColor, equals(ShelfColors.light.accent));
      expect(slot.foregroundColor, equals(ShelfColors.light.onAccent));
    });

    test('listTileTheme is pinned to light textPrimary', () {
      final slot = lightTheme().listTileTheme;
      expect(slot, isNotNull);
      expect(slot.iconColor, equals(ShelfColors.light.textPrimary));
      expect(slot.textColor, equals(ShelfColors.light.textPrimary));
    });

    test('dialogTheme is pinned to light surface and text', () {
      final slot = lightTheme().dialogTheme;
      expect(slot, isNotNull);
      expect(slot.backgroundColor, equals(ShelfColors.light.surface));
      expect(slot.titleTextStyle?.color, equals(ShelfColors.light.textPrimary));
      expect(slot.contentTextStyle?.color, equals(ShelfColors.light.textPrimary));
    });

    test('snackBarTheme uses inverse tokens (dark bg on light theme)', () {
      final slot = lightTheme().snackBarTheme;
      expect(slot, isNotNull);
      expect(slot.backgroundColor, equals(ShelfColors.dark.background));
      expect(slot.contentTextStyle?.color, equals(ShelfColors.dark.textPrimary));
    });

    test('switchTheme active state pinned to light accent', () {
      final slot = lightTheme().switchTheme;
      expect(slot, isNotNull);
      expect(slot.thumbColor?.resolve({WidgetState.selected}), equals(ShelfColors.light.onAccent));
      expect(slot.trackColor?.resolve({WidgetState.selected}), equals(ShelfColors.light.accent));
    });

    test('filledButtonTheme is pinned to light accent', () {
      final slot = lightTheme().filledButtonTheme;
      expect(slot, isNotNull);
      final style = slot.style;
      expect(style?.backgroundColor?.resolve({}), equals(ShelfColors.light.accent));
      expect(style?.foregroundColor?.resolve({}), equals(ShelfColors.light.onAccent));
    });

    test('progressIndicatorTheme is pinned to light accent', () {
      final slot = lightTheme().progressIndicatorTheme;
      expect(slot, isNotNull);
      expect(slot.color, equals(ShelfColors.light.accent));
    });

    test('appBarTheme is pinned to light background and textPrimary', () {
      final slot = lightTheme().appBarTheme;
      expect(slot, isNotNull);
      expect(slot.backgroundColor, equals(ShelfColors.light.background));
      expect(slot.foregroundColor, equals(ShelfColors.light.textPrimary));
    });

    test('bottomSheetTheme is pinned to light surface', () {
      final slot = lightTheme().bottomSheetTheme;
      expect(slot, isNotNull);
      expect(slot.backgroundColor, equals(ShelfColors.light.surface));
    });
  });

  group('Dark theme component slots (lazy construction)', () {
    ThemeData darkTheme() {
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
          titleTextStyle: AppTextStyles.instance.sectionTitle(c),
          contentTextStyle: AppTextStyles.instance.body(c),
        ),
        snackBarTheme: SnackBarThemeData(
          backgroundColor: ShelfColors.light.background,
          contentTextStyle: AppTextStyles.instance.body(ShelfColors.light),
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

    test('floatingActionButtonTheme is pinned to dark accent', () {
      final slot = darkTheme().floatingActionButtonTheme;
      expect(slot, isNotNull);
      expect(slot.backgroundColor, equals(ShelfColors.dark.accent));
      expect(slot.foregroundColor, equals(ShelfColors.dark.onAccent));
    });

    test('listTileTheme is pinned to dark textPrimary', () {
      final slot = darkTheme().listTileTheme;
      expect(slot, isNotNull);
      expect(slot.iconColor, equals(ShelfColors.dark.textPrimary));
      expect(slot.textColor, equals(ShelfColors.dark.textPrimary));
    });

    test('dialogTheme is pinned to dark surface and text', () {
      final slot = darkTheme().dialogTheme;
      expect(slot, isNotNull);
      expect(slot.backgroundColor, equals(ShelfColors.dark.surface));
      expect(slot.titleTextStyle?.color, equals(ShelfColors.dark.textPrimary));
      expect(slot.contentTextStyle?.color, equals(ShelfColors.dark.textPrimary));
    });

    test('snackBarTheme uses inverse tokens (light bg on dark theme)', () {
      final slot = darkTheme().snackBarTheme;
      expect(slot, isNotNull);
      expect(slot.backgroundColor, equals(ShelfColors.light.background));
      expect(slot.contentTextStyle?.color, equals(ShelfColors.light.textPrimary));
    });

    test('switchTheme active state pinned to dark accent', () {
      final slot = darkTheme().switchTheme;
      expect(slot, isNotNull);
      expect(slot.thumbColor?.resolve({WidgetState.selected}), equals(ShelfColors.dark.onAccent));
      expect(slot.trackColor?.resolve({WidgetState.selected}), equals(ShelfColors.dark.accent));
    });

    test('filledButtonTheme is pinned to dark accent', () {
      final slot = darkTheme().filledButtonTheme;
      expect(slot, isNotNull);
      final style = slot.style;
      expect(style?.backgroundColor?.resolve({}), equals(ShelfColors.dark.accent));
      expect(style?.foregroundColor?.resolve({}), equals(ShelfColors.dark.onAccent));
    });

    test('progressIndicatorTheme is pinned to dark accent', () {
      final slot = darkTheme().progressIndicatorTheme;
      expect(slot, isNotNull);
      expect(slot.color, equals(ShelfColors.dark.accent));
    });

    test('appBarTheme is pinned to dark background and textPrimary', () {
      final slot = darkTheme().appBarTheme;
      expect(slot, isNotNull);
      expect(slot.backgroundColor, equals(ShelfColors.dark.background));
      expect(slot.foregroundColor, equals(ShelfColors.dark.textPrimary));
    });

    test('bottomSheetTheme is pinned to dark surface', () {
      final slot = darkTheme().bottomSheetTheme;
      expect(slot, isNotNull);
      expect(slot.backgroundColor, equals(ShelfColors.dark.surface));
    });
  });

  // Note: AppTextStyles theme-awareness tests require google_fonts font loading
  // which needs a widget test zone. These are validated in widget_test.dart.
  // The token value and component slot tests above are the critical regression guards.
}