import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeService extends ChangeNotifier {
  static const String prefKey = 'theme_mode';

  final SharedPreferences? prefs;
  ThemeMode _themeMode = ThemeMode.system;

  ThemeService({this.prefs}) {
    _loadSavedThemeMode();
  }

  ThemeMode get themeMode => _themeMode;

  bool get isDarkMode => _themeMode == ThemeMode.dark;

  void _loadSavedThemeMode() {
    final p = prefs;
    if (p != null) {
      final savedMode = p.getString(prefKey);
      if (savedMode != null && savedMode.isNotEmpty) {
        _themeMode = _parseThemeMode(savedMode);
      }
    }
  }

  static ThemeMode _parseThemeMode(String mode) {
    switch (mode) {
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      case 'system':
      default:
        return ThemeMode.system;
    }
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    if (_themeMode == mode) return;

    _themeMode = mode;
    final p = prefs;
    if (p != null) {
      try {
        await p.setString(prefKey, mode.name);
      } catch (e) {
        debugPrint('Error saving theme mode: $e');
      }
    }
    notifyListeners();
  }

  Future<void> toggleTheme() async {
    if (_themeMode == ThemeMode.dark) {
      await setThemeMode(ThemeMode.light);
    } else {
      await setThemeMode(ThemeMode.dark);
    }
  }
}
