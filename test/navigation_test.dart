import 'package:flutter_test/flutter_test.dart';
import 'package:sanatan_sathiya/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('Navigation & Widget Tests', () {
    setUp(() {
      SharedPreferences.setMockInitialValues({});
    });

    testWidgets('Renders app title and five bottom navigation destinations', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const SanatanSathiyaApp());

      // Verify App Bar Title
      expect(find.text('Sanatan Sathiya'), findsWidgets);

      // Verify Bottom Navigation Items
      expect(find.text('Today'), findsOneWidget);
      expect(find.text('Bhakti'), findsOneWidget);
      expect(find.text('Festivals'), findsOneWidget);
      expect(find.text('Saved'), findsOneWidget);
      expect(find.text('More'), findsOneWidget);
    });

    testWidgets('Navigating to Bhakti destination displays Bhakti content', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const SanatanSathiyaApp());

      // Tap on 'Bhakti' tab
      await tester.tap(find.text('Bhakti'));
      await tester.pumpAndSettle();

      // Verify Bhakti Screen Content
      expect(find.text('Bhakti Sangrah'), findsOneWidget);
      expect(find.text('Hanuman Chalisa'), findsOneWidget);
    });

    testWidgets(
      'Navigating to Festivals destination displays Festivals content',
      (WidgetTester tester) async {
        await tester.pumpWidget(const SanatanSathiyaApp());

        // Tap on 'Festivals' tab
        await tester.tap(find.text('Festivals'));
        await tester.pumpAndSettle();

        // Verify Festivals Screen Content
        expect(find.text('Festivals & Vrats'), findsOneWidget);
        expect(find.text('Maha Shivratri'), findsOneWidget);
      },
    );

    testWidgets('Navigating to Saved destination displays Saved content', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const SanatanSathiyaApp());

      // Tap on 'Saved' tab
      await tester.tap(find.text('Saved'));
      await tester.pumpAndSettle();

      // Verify Saved Screen Content
      expect(find.text('Saved Prayers'), findsOneWidget);
    });

    testWidgets(
      'Navigating to More destination displays Settings & Theme options',
      (WidgetTester tester) async {
        await tester.pumpWidget(const SanatanSathiyaApp());

        // Tap on 'More' tab
        await tester.tap(find.text('More'));
        await tester.pumpAndSettle();

        // Verify More Screen Content
        expect(find.text('More & Settings'), findsOneWidget);
        expect(find.text('Appearance Theme'), findsOneWidget);
      },
    );
  });
}
