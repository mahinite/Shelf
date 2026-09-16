import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeModeNotifier extends ValueNotifier<ThemeMode> {
  static const String _key = 'theme_mode';

  /// Single shared instance, created exactly once on first access.
  /// main() loads the persisted mode before runApp; MaterialApp and the
  /// Settings dark-mode switch both listen to this same instance.
  static final ThemeModeNotifier instance = ThemeModeNotifier._();

  ThemeModeNotifier._() : super(ThemeMode.light);

  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    final index = prefs.getInt(_key) ?? 0;
    value = ThemeMode.values[index];
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    if (value == mode) return;
    value = mode;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_key, mode.index);
  }

  Future<void> toggleTheme() async {
    await setThemeMode(
      value == ThemeMode.light ? ThemeMode.dark : ThemeMode.light,
    );
  }
}