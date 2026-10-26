import 'package:flutter_test/flutter_test.dart';
import 'package:sanatan_sathiya/services/devotional_service.dart';

void main() {
  group('DevotionalService Unit Tests', () {
    late DevotionalService service;

    setUp(() {
      service = DevotionalService();
    });

    test('getVerseOfTheDay returns valid verse item', () {
      final verse = service.getVerseOfTheDay();
      expect(verse.title, contains('Bhagavad Gita'));
      expect(verse.content, isNotEmpty);
      expect(verse.category, equals('Verse'));
    });

    test('getTodayPanchang returns tithi and nakshatra details', () {
      final panchang = service.getTodayPanchang();
      expect(panchang.containsKey('tithi'), isTrue);
      expect(panchang.containsKey('nakshatra'), isTrue);
      expect(panchang['tithi'], isNotEmpty);
    });

    test('getBhaktiItems returns list of devotional items', () {
      final items = service.getBhaktiItems();
      expect(items, isNotEmpty);
      expect(items.any((i) => i.category == 'Aarti'), isTrue);
      expect(items.any((i) => i.category == 'Mantra'), isTrue);
      expect(items.any((i) => i.category == 'Chalisa'), isTrue);
    });

    test('getFestivals returns list of upcoming festivals', () {
      final festivals = service.getFestivals();
      expect(festivals.length, greaterThanOrEqualTo(3));
      expect(festivals.first.category, equals('Festival'));
    });

    test('getSavedItems returns bookmarked devotional items', () {
      final saved = service.getSavedItems();
      expect(saved.every((item) => item.isSaved), isTrue);
    });
  });
}
