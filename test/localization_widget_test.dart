import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sanatan_sathiya/l10n/app_localizations.dart';
import 'package:sanatan_sathiya/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('Localization Widget Tests', () {
    setUp(() {
      SharedPreferences.setMockInitialValues({});
    });

    testWidgets('Renders app in Hindi when Hindi locale is set', (
      WidgetTester tester,
    ) async {
      SharedPreferences.setMockInitialValues({'selected_language_code': 'hi'});
      final prefs = await SharedPreferences.getInstance();

      await tester.pumpWidget(SanatanSathiyaApp(prefs: prefs));
      await tester.pumpAndSettle();

      // Check Hindi navigation labels
      expect(find.text('आज'), findsOneWidget);
      expect(find.text('भक्ति'), findsOneWidget);
      expect(find.text('त्योहार'), findsOneWidget);
      expect(find.text('सहेजे गए'), findsOneWidget);
      expect(find.text('अधिक'), findsOneWidget);

      // Check Hindi greeting on Today screen
      expect(find.text('शुभ प्रभात'), findsOneWidget);
      expect(find.text('आज का पंचांग'), findsOneWidget);
    });

    testWidgets('Renders app in Marathi when Marathi locale is set', (
      WidgetTester tester,
    ) async {
      SharedPreferences.setMockInitialValues({'selected_language_code': 'mr'});
      final prefs = await SharedPreferences.getInstance();

      await tester.pumpWidget(SanatanSathiyaApp(prefs: prefs));
      await tester.pumpAndSettle();

      // Check Marathi navigation labels
      expect(find.text('आज'), findsOneWidget);
      expect(find.text('भक्ती'), findsOneWidget);
      expect(find.text('सण'), findsOneWidget);
      expect(find.text('जतन केलेले'), findsOneWidget);
      expect(find.text('अधिक'), findsOneWidget);

      // Check Marathi greeting on Today screen
      expect(find.text('शुभ प्रभात'), findsOneWidget);
      expect(find.text('आजचे पंचांग'), findsOneWidget);
    });

    testWidgets('Dynamic language switching in MoreScreen updates app UI', (
      WidgetTester tester,
    ) async {
      SharedPreferences.setMockInitialValues({});
      final prefs = await SharedPreferences.getInstance();

      await tester.pumpWidget(SanatanSathiyaApp(prefs: prefs));
      await tester.pumpAndSettle();

      // Navigate to 'More' screen
      await tester.tap(find.text('More'));
      await tester.pumpAndSettle();

      // Tap on 'हिन्दी' in language selector
      await tester.tap(find.text('हिन्दी'));
      await tester.pumpAndSettle();

      // Verify UI updated to Hindi
      expect(find.text('दृश्य थीम'), findsOneWidget);
      expect(find.text('भक्ति भाषा'), findsOneWidget);

      // Tap on 'मराठी'
      await tester.tap(find.text('मराठी'));
      await tester.pumpAndSettle();

      // Verify UI updated to Marathi
      expect(find.text('दिसणारी थीम'), findsOneWidget);
      expect(find.text('भक्ती भाषा'), findsOneWidget);
    });

    testWidgets(
      'Localizations delegates generate valid AppLocalizations instance',
      (WidgetTester tester) async {
        late AppLocalizations l10n;

        await tester.pumpWidget(
          MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            locale: const Locale('en'),
            home: Builder(
              builder: (context) {
                l10n = AppLocalizations.of(context)!;
                return Text(l10n.appName);
              },
            ),
          ),
        );

        expect(l10n.appName, equals('Sanatan Sathiya'));
        expect(l10n.navToday, equals('Today'));
        expect(l10n.navBhakti, equals('Bhakti'));
      },
    );
  });
}
