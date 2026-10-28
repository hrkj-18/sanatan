import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sanatan_sathiya/l10n/app_localizations.dart';
import 'package:sanatan_sathiya/main.dart';
import 'package:sanatan_sathiya/models/devotional_item.dart';
import 'package:sanatan_sathiya/screens/bhakti/bhakti_screen.dart';
import 'package:sanatan_sathiya/screens/festivals/festivals_screen.dart';
import 'package:sanatan_sathiya/screens/more/more_screen.dart';
import 'package:sanatan_sathiya/screens/saved/saved_screen.dart';
import 'package:sanatan_sathiya/screens/today/today_screen.dart';
import 'package:sanatan_sathiya/services/devotional_service.dart';
import 'package:sanatan_sathiya/services/locale_service.dart';
import 'package:sanatan_sathiya/services/panchang_service.dart';
import 'package:sanatan_sathiya/services/theme_service.dart';
import 'package:sanatan_sathiya/theme/app_theme.dart';
import 'package:sanatan_sathiya/widgets/devotional_card.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('App-Wide Responsive Layout & Overflow Regression Tests', () {
    setUp(() {
      SharedPreferences.setMockInitialValues({});
    });

    final screenSizes = [
      const Size(320, 568), // Extremely narrow phone
      const Size(360, 640), // Standard Android phone
      const Size(414, 896), // Wide phone
    ];

    final locales = [
      const Locale('en'),
      const Locale('hi'),
      const Locale('mr'),
    ];

    final textScalers = [
      TextScaler.noScaling,
      const TextScaler.linear(1.5),
      const TextScaler.linear(2.0),
    ];

    for (final size in screenSizes) {
      for (final locale in locales) {
        for (final textScaler in textScalers) {
          testWidgets(
            'TodayScreen renders cleanly without overflow on size: $size, locale: ${locale.languageCode}, textScale: ${textScaler.scale(1.0)}',
            (WidgetTester tester) async {
              tester.view.physicalSize = size * tester.view.devicePixelRatio;
              addTearDown(tester.view.resetPhysicalSize);

              final devotionalService = DevotionalService();
              final panchangService = MockPanchangService();

              await tester.pumpWidget(
                MediaQuery(
                  data: MediaQueryData(size: size, textScaler: textScaler),
                  child: MaterialApp(
                    localizationsDelegates:
                        AppLocalizations.localizationsDelegates,
                    supportedLocales: AppLocalizations.supportedLocales,
                    locale: locale,
                    theme: AppTheme.lightTheme,
                    darkTheme: AppTheme.darkTheme,
                    home: Scaffold(
                      body: TodayScreen(
                        devotionalService: devotionalService,
                        panchangService: panchangService,
                      ),
                    ),
                  ),
                ),
              );
              await tester.pumpAndSettle();

              // Zero RenderFlex layout overflow exceptions caught
              expect(tester.takeException(), isNull);
            },
          );
        }
      }
    }

    testWidgets('FestivalsScreen renders long dates without right overflow', (
      WidgetTester tester,
    ) async {
      const size = Size(320, 568);
      tester.view.physicalSize = size * tester.view.devicePixelRatio;
      addTearDown(tester.view.resetPhysicalSize);

      final devotionalService = DevotionalService();

      await tester.pumpWidget(
        MediaQuery(
          data: const MediaQueryData(
            size: size,
            textScaler: TextScaler.linear(1.5),
          ),
          child: MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            locale: const Locale('hi'),
            theme: AppTheme.lightTheme,
            home: Scaffold(
              body: FestivalsScreen(devotionalService: devotionalService),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(tester.takeException(), isNull);
    });

    testWidgets(
      'MoreScreen language & theme selectors render without overflow',
      (WidgetTester tester) async {
        const size = Size(320, 568);
        tester.view.physicalSize = size * tester.view.devicePixelRatio;
        addTearDown(tester.view.resetPhysicalSize);

        final themeService = ThemeService();
        final localeService = LocaleService();

        await tester.pumpWidget(
          MediaQuery(
            data: const MediaQueryData(
              size: size,
              textScaler: TextScaler.linear(1.5),
            ),
            child: MaterialApp(
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,
              locale: const Locale('mr'),
              theme: AppTheme.darkTheme,
              home: Scaffold(
                body: MoreScreen(
                  themeService: themeService,
                  localeService: localeService,
                ),
              ),
            ),
          ),
        );
        await tester.pumpAndSettle();

        expect(tester.takeException(), isNull);
      },
    );

    testWidgets('BhaktiScreen and category filters render without overflow', (
      WidgetTester tester,
    ) async {
      const size = Size(320, 568);
      tester.view.physicalSize = size * tester.view.devicePixelRatio;
      addTearDown(tester.view.resetPhysicalSize);

      final devotionalService = DevotionalService();

      await tester.pumpWidget(
        MediaQuery(
          data: const MediaQueryData(
            size: size,
            textScaler: TextScaler.linear(1.5),
          ),
          child: MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            locale: const Locale('hi'),
            theme: AppTheme.lightTheme,
            home: Scaffold(
              body: BhaktiScreen(devotionalService: devotionalService),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(tester.takeException(), isNull);
    });

    testWidgets(
      'SavedScreen renders empty and populated states without overflow',
      (WidgetTester tester) async {
        const size = Size(320, 568);
        tester.view.physicalSize = size * tester.view.devicePixelRatio;
        addTearDown(tester.view.resetPhysicalSize);

        final devotionalService = DevotionalService();

        await tester.pumpWidget(
          MediaQuery(
            data: const MediaQueryData(
              size: size,
              textScaler: TextScaler.linear(1.5),
            ),
            child: MaterialApp(
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,
              locale: const Locale('mr'),
              theme: AppTheme.darkTheme,
              home: Scaffold(
                body: SavedScreen(devotionalService: devotionalService),
              ),
            ),
          ),
        );
        await tester.pumpAndSettle();

        expect(tester.takeException(), isNull);
      },
    );

    testWidgets(
      'DevotionalCard handles extremely long category and date text gracefully',
      (WidgetTester tester) async {
        const size = Size(320, 568);
        tester.view.physicalSize = size * tester.view.devicePixelRatio;
        addTearDown(tester.view.resetPhysicalSize);

        const longItem = DevotionalItem(
          id: 'long_1',
          title: 'Extremely Long Devotional Title That Spans Multiple Lines On Narrow Screen',
          subtitle: 'Very Long Subtitle Category Text',
          content: 'Long scripture content that wraps smoothly.',
          category: 'Extremely Long Category Name',
          date: 'Upcoming • Phalguna Krishna Chaturdashi Special Festival Date',
        );

        await tester.pumpWidget(
          MediaQuery(
            data: const MediaQueryData(size: size),
            child: MaterialApp(
              theme: AppTheme.lightTheme,
              home: const Scaffold(body: DevotionalCard(item: longItem)),
            ),
          ),
        );
        await tester.pumpAndSettle();

        expect(tester.takeException(), isNull);
      },
    );

    testWidgets('Full SanatanSathiyaApp shell runs without layout overflow', (
      WidgetTester tester,
    ) async {
      const size = Size(320, 568);
      tester.view.physicalSize = size * tester.view.devicePixelRatio;
      addTearDown(tester.view.resetPhysicalSize);

      final prefs = await SharedPreferences.getInstance();

      await tester.pumpWidget(
        MediaQuery(
          data: const MediaQueryData(
            size: size,
            textScaler: TextScaler.linear(1.5),
          ),
          child: SanatanSathiyaApp(prefs: prefs),
        ),
      );
      await tester.pumpAndSettle();

      expect(tester.takeException(), isNull);
    });
  });
}
