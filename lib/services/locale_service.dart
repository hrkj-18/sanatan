import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocaleService extends ChangeNotifier {
  static const String prefKey = 'selected_language_code';

  static const List<Locale> supportedLocales = [
    Locale('en'),
    Locale('hi'),
    Locale('mr'),
  ];

  final SharedPreferences? prefs;
  Locale? _locale;

  LocaleService({this.prefs}) {
    _loadSavedLocale();
  }

  Locale? get locale => _locale;

  String? get languageCode => _locale?.languageCode;

  void _loadSavedLocale() {
    final p = prefs;
    if (p != null) {
      final savedCode = p.getString(prefKey);
      if (savedCode != null && savedCode.isNotEmpty) {
        if (isSupportedLanguage(savedCode)) {
          _locale = Locale(savedCode);
        }
      }
    }
  }

  Future<void> setLocale(Locale? newLocale) async {
    if (_locale == newLocale) return;

    if (newLocale == null) {
      _locale = null;
      final p = prefs;
      if (p != null) {
        try {
          await p.remove(prefKey);
        } catch (e) {
          debugPrint('Error removing saved locale: $e');
        }
      }
    } else if (isSupportedLanguage(newLocale.languageCode)) {
      _locale = newLocale;
      final p = prefs;
      if (p != null) {
        try {
          await p.setString(prefKey, newLocale.languageCode);
        } catch (e) {
          debugPrint('Error saving locale: $e');
        }
      }
    }
    notifyListeners();
  }

  bool isSupportedLanguage(String code) {
    return supportedLocales.any((loc) => loc.languageCode == code);
  }

  static Locale resolveLocale(Locale? deviceLocale, Locale? userSavedLocale) {
    if (userSavedLocale != null) {
      return userSavedLocale;
    }
    if (deviceLocale != null) {
      for (final supportedLocale in supportedLocales) {
        if (supportedLocale.languageCode == deviceLocale.languageCode) {
          return supportedLocale;
        }
      }
    }
    return const Locale('en');
  }
}
