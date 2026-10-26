import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sanatan_sathiya/main.dart';
import 'package:sanatan_sathiya/services/devotional_service.dart';
import 'package:sanatan_sathiya/services/theme_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('Local Persistence & Bookmark Tests', () {
    setUp(() {
      SharedPreferences.setMockInitialValues({});
    });

    test('Fresh install initializes with an empty bookmark list', () async {
      SharedPreferences.setMockInitialValues({});
      final prefs = await SharedPreferences.getInstance();

      final service = DevotionalService(prefs: prefs);
      expect(service.bookmarkedIds, isEmpty);
      expect(service.getSavedItems(), isEmpty);
    });

    test('Saving and removing bookmarks updates local storage and notifies listeners immediately', () async {
      SharedPreferences.setMockInitialValues({});
      final prefs = await SharedPreferences.getInstance();

      final service = DevotionalService(prefs: prefs);
      bool notified = false;
      service.addListener(() => notified = true);

      // Add bookmark
      await service.toggleBookmark('b_1');
      expect(service.isBookmarked('b_1'), isTrue);
      expect(notified, isTrue);
      expect(prefs.getStringList(DevotionalService.prefKey), contains('b_1'));

      // Remove bookmark
      notified = false;
      await service.toggleBookmark('b_1');
      expect(service.isBookmarked('b_1'), isFalse);
      expect(notified, isTrue);
      expect(
        prefs.getStringList(DevotionalService.prefKey),
        isNot(contains('b_1')),
      );
    });

    test('Restores saved bookmarks across service restarts', () async {
      SharedPreferences.setMockInitialValues({
        'bookmarked_item_ids': ['f_1', 'f_2'],
      });
      final prefs = await SharedPreferences.getInstance();

      final service = DevotionalService(prefs: prefs);
      expect(service.isBookmarked('f_1'), isTrue);
      expect(service.isBookmarked('f_2'), isTrue);
      expect(service.isBookmarked('v_day_1'), isFalse);

      final savedItems = service.getSavedItems();
      expect(savedItems.length, equals(2));
      expect(savedItems.map((i) => i.id), containsAll(['f_1', 'f_2']));
    });

    test(
      'Handles corrupt or empty bookmark entries safely without crashing',
      () async {
        SharedPreferences.setMockInitialValues({
          'bookmarked_item_ids': ['', 'valid_id', ''],
        });
        final prefs = await SharedPreferences.getInstance();

        final service = DevotionalService(prefs: prefs);
        expect(service.isBookmarked('valid_id'), isTrue);
        expect(service.isBookmarked(''), isFalse);
        expect(service.bookmarkedIds.length, equals(1));
      },
    );

    test('ThemeService persists and restores user theme preferences', () async {
      SharedPreferences.setMockInitialValues({});
      final prefs = await SharedPreferences.getInstance();

      final themeService = ThemeService(prefs: prefs);
      expect(themeService.themeMode, equals(ThemeMode.system));

      await themeService.setThemeMode(ThemeMode.dark);
      expect(prefs.getString(ThemeService.prefKey), equals('dark'));

      // Restore in new ThemeService instance
      final restoredThemeService = ThemeService(prefs: prefs);
      expect(restoredThemeService.themeMode, equals(ThemeMode.dark));
    });

    test(
      'Handles corrupt or unknown stored theme mode safely with system default',
      () async {
        SharedPreferences.setMockInitialValues({
          'theme_mode': 'invalid_mode_value',
        });
        final prefs = await SharedPreferences.getInstance();

        final themeService = ThemeService(prefs: prefs);
        expect(themeService.themeMode, equals(ThemeMode.system));
      },
    );

    testWidgets('Toggling bookmark in UI immediately updates Saved screen', (
      WidgetTester tester,
    ) async {
      SharedPreferences.setMockInitialValues({
        'bookmarked_item_ids': <String>[],
      });
      final prefs = await SharedPreferences.getInstance();

      await tester.pumpWidget(SanatanSathiyaApp(prefs: prefs));
      await tester.pumpAndSettle();

      // Initially on 'Today' screen, tap bookmark icon on Verse of the Day
      final bookmarkButton = find.byIcon(Icons.bookmark_border).first;
      await tester.tap(bookmarkButton);
      await tester.pumpAndSettle();

      // Navigate to 'Saved' tab
      await tester.tap(find.text('Saved'));
      await tester.pumpAndSettle();

      // Saved Screen should now show Bhagavad Gita 2.47
      expect(find.text('Bhagavad Gita 2.47'), findsOneWidget);

      // Untap bookmark icon directly in Saved screen
      final filledBookmarkButton = find.byIcon(Icons.bookmark).first;
      await tester.tap(filledBookmarkButton);
      await tester.pumpAndSettle();

      // Saved Screen immediately shows empty state
      expect(find.text('No saved items yet'), findsOneWidget);
    });
  });
}
