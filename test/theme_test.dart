import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sanatan_sathiya/services/theme_service.dart';
import 'package:sanatan_sathiya/theme/app_theme.dart';

void main() {
  group('Theme Unit Tests', () {
    test('Initial theme mode is system', () {
      final themeService = ThemeService();
      expect(themeService.themeMode, equals(ThemeMode.system));
    });

    test('Toggling theme switches between light and dark', () {
      final themeService = ThemeService();
      themeService.setThemeMode(ThemeMode.dark);
      expect(themeService.themeMode, equals(ThemeMode.dark));
      expect(themeService.isDarkMode, isTrue);

      themeService.toggleTheme();
      expect(themeService.themeMode, equals(ThemeMode.light));
      expect(themeService.isDarkMode, isFalse);
    });

    test('AppTheme defines valid Material 3 ThemeData', () {
      final lightTheme = AppTheme.lightTheme;
      final darkTheme = AppTheme.darkTheme;

      expect(lightTheme.useMaterial3, isTrue);
      expect(darkTheme.useMaterial3, isTrue);
      expect(lightTheme.colorScheme.brightness, equals(Brightness.light));
      expect(darkTheme.colorScheme.brightness, equals(Brightness.dark));
    });
  });
}
