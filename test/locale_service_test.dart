import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sanatan_sathiya/services/locale_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('LocaleService Unit Tests', () {
    test('Initial locale is null (system default)', () {
      final service = LocaleService();
      expect(service.locale, isNull);
      expect(service.languageCode, isNull);
    });

    test('Supported locales include en, hi, and mr', () {
      final service = LocaleService();
      expect(service.isSupportedLanguage('en'), isTrue);
      expect(service.isSupportedLanguage('hi'), isTrue);
      expect(service.isSupportedLanguage('mr'), isTrue);
      expect(service.isSupportedLanguage('fr'), isFalse);
    });

    test('Setting locale updates locale and notifies listeners', () async {
      final service = LocaleService();
      bool notified = false;
      service.addListener(() {
        notified = true;
      });

      await service.setLocale(const Locale('hi'));
      expect(service.languageCode, equals('hi'));
      expect(notified, isTrue);
    });

    test(
      'Persists selected locale to SharedPreferences and restores it',
      () async {
        SharedPreferences.setMockInitialValues({});
        final prefs = await SharedPreferences.getInstance();

        final service = LocaleService(prefs: prefs);
        await service.setLocale(const Locale('mr'));

        expect(prefs.getString(LocaleService.prefKey), equals('mr'));

        // Restore in a new service instance with saved prefs
        final restoredService = LocaleService(prefs: prefs);
        expect(restoredService.languageCode, equals('mr'));
      },
    );

    test('Clearing locale removes saved preference', () async {
      SharedPreferences.setMockInitialValues({'selected_language_code': 'hi'});
      final prefs = await SharedPreferences.getInstance();

      final service = LocaleService(prefs: prefs);
      expect(service.languageCode, equals('hi'));

      await service.setLocale(null);
      expect(service.languageCode, isNull);
      expect(prefs.containsKey(LocaleService.prefKey), isFalse);
    });

    group('Locale resolution (Fallback & Device locale tests)', () {
      test('Defaults to English when device locale is unsupported and no saved choice', () {
        final resolved = LocaleService.resolveLocale(
          const Locale('fr', 'FR'),
          null,
        );
        expect(resolved, equals(const Locale('en')));
      });

      test('Uses device locale when supported and no saved choice', () {
        final resolvedHindi = LocaleService.resolveLocale(
          const Locale('hi', 'IN'),
          null,
        );
        expect(resolvedHindi, equals(const Locale('hi')));

        final resolvedMarathi = LocaleService.resolveLocale(
          const Locale('mr', 'IN'),
          null,
        );
        expect(resolvedMarathi, equals(const Locale('mr')));
      });

      test('Saved user choice takes precedence over device locale', () {
        final resolved = LocaleService.resolveLocale(
          const Locale('hi', 'IN'),
          const Locale('mr'),
        );
        expect(resolved, equals(const Locale('mr')));
      });
    });
  });
}
