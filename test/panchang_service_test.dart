import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sanatan_sathiya/l10n/app_localizations.dart';
import 'package:sanatan_sathiya/main.dart';
import 'package:sanatan_sathiya/models/panchang_data.dart';
import 'package:sanatan_sathiya/screens/today/today_screen.dart';
import 'package:sanatan_sathiya/services/devotional_service.dart';
import 'package:sanatan_sathiya/services/panchang_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('Panchang Data & Service Hardening Tests', () {
    setUp(() {
      SharedPreferences.setMockInitialValues({});
    });

    test('PanchangLocation throws ArgumentError for invalid coordinates', () {
      final nanVal = double.nan;
      final posInf = double.infinity;
      final negInf = double.negativeInfinity;

      // Latitude out of range
      expect(
        () => PanchangLocation(
          latitude: 95.0,
          longitude: 77.0,
          timeZoneId: 'Asia/Kolkata',
          timeZoneOffset: const Duration(hours: 5, minutes: 30),
          locationName: 'Invalid Lat',
        ),
        throwsArgumentError,
      );

      expect(
        () => PanchangLocation(
          latitude: -91.0,
          longitude: 77.0,
          timeZoneId: 'Asia/Kolkata',
          timeZoneOffset: const Duration(hours: 5, minutes: 30),
          locationName: 'Invalid Negative Lat',
        ),
        throwsArgumentError,
      );

      // Latitude NaN and Infinity
      expect(
        () => PanchangLocation(
          latitude: nanVal,
          longitude: 77.0,
          timeZoneId: 'Asia/Kolkata',
          timeZoneOffset: const Duration(hours: 5, minutes: 30),
          locationName: 'NaN Lat',
        ),
        throwsArgumentError,
      );

      expect(
        () => PanchangLocation(
          latitude: posInf,
          longitude: 77.0,
          timeZoneId: 'Asia/Kolkata',
          timeZoneOffset: const Duration(hours: 5, minutes: 30),
          locationName: 'Pos Inf Lat',
        ),
        throwsArgumentError,
      );

      expect(
        () => PanchangLocation(
          latitude: negInf,
          longitude: 77.0,
          timeZoneId: 'Asia/Kolkata',
          timeZoneOffset: const Duration(hours: 5, minutes: 30),
          locationName: 'Neg Inf Lat',
        ),
        throwsArgumentError,
      );

      // Longitude out of range
      expect(
        () => PanchangLocation(
          latitude: 20.0,
          longitude: 185.0,
          timeZoneId: 'Asia/Kolkata',
          timeZoneOffset: const Duration(hours: 5, minutes: 30),
          locationName: 'Invalid Long',
        ),
        throwsArgumentError,
      );

      expect(
        () => PanchangLocation(
          latitude: 20.0,
          longitude: -185.0,
          timeZoneId: 'Asia/Kolkata',
          timeZoneOffset: const Duration(hours: 5, minutes: 30),
          locationName: 'Invalid Negative Long',
        ),
        throwsArgumentError,
      );

      // Longitude NaN and Infinity
      expect(
        () => PanchangLocation(
          latitude: 20.0,
          longitude: nanVal,
          timeZoneId: 'Asia/Kolkata',
          timeZoneOffset: const Duration(hours: 5, minutes: 30),
          locationName: 'NaN Long',
        ),
        throwsArgumentError,
      );

      expect(
        () => PanchangLocation(
          latitude: 20.0,
          longitude: posInf,
          timeZoneId: 'Asia/Kolkata',
          timeZoneOffset: const Duration(hours: 5, minutes: 30),
          locationName: 'Pos Inf Long',
        ),
        throwsArgumentError,
      );

      expect(
        () => PanchangLocation(
          latitude: 20.0,
          longitude: negInf,
          timeZoneId: 'Asia/Kolkata',
          timeZoneOffset: const Duration(hours: 5, minutes: 30),
          locationName: 'Neg Inf Long',
        ),
        throwsArgumentError,
      );

      final valid = PanchangLocation(
        latitude: 28.6139,
        longitude: 77.2090,
        timeZoneId: 'Asia/Kolkata',
        timeZoneOffset: const Duration(hours: 5, minutes: 30),
        locationName: 'Delhi',
      );
      expect(valid.timeZoneId, equals('Asia/Kolkata'));
      expect(valid.latitude, equals(28.6139));
    });

    test('PanchangData model equality and hash-code consistency', () {
      final date = DateTime(2026, 10, 27);
      final location = PanchangLocation.defaultLocation;

      final panchang1 = PanchangData(
        tithi: 'Shukla Paksha Ekadashi',
        nakshatra: 'Rohini',
        samvat: 'Vikram Samvat 2081',
        sunrise: '06:28 AM',
        sunset: '06:12 PM',
        date: date,
        location: location,
        status: PanchangCalculationStatus.mock,
      );

      final panchang2 = PanchangData(
        tithi: 'Shukla Paksha Ekadashi',
        nakshatra: 'Rohini',
        samvat: 'Vikram Samvat 2081',
        sunrise: '06:28 AM',
        sunset: '06:12 PM',
        date: date,
        location: location,
        status: PanchangCalculationStatus.mock,
      );

      // Equality and hash-code consistency check
      expect(panchang1, equals(panchang2));
      expect(panchang1.hashCode, equals(panchang2.hashCode));

      final modified = panchang1.copyWith(tithi: 'Dwadashi');
      expect(modified, isNot(equals(panchang1)));
      expect(modified.hashCode, isNot(equals(panchang1.hashCode)));
    });

    test('MockPanchangService uses configured currentLocation when location is omitted', () {
      final customLocation = PanchangLocation(
        latitude: 28.6139,
        longitude: 77.2090,
        timeZoneId: 'Asia/Kolkata',
        timeZoneOffset: const Duration(hours: 5, minutes: 30),
        locationName: 'New Delhi, India (IST)',
      );

      final service = MockPanchangService(currentLocation: customLocation);
      final targetDate = DateTime(2026, 11, 1);

      // Call without specifying location
      final panchang = service.getPanchangForDate(targetDate);

      expect(panchang.location, equals(customLocation));
      expect(panchang.location.timeZoneId, equals('Asia/Kolkata'));
      expect(panchang.isMock, isTrue);
    });

    test('MockPanchangService updates location and notifies listeners', () {
      final service = MockPanchangService();
      bool notified = false;
      service.addListener(() => notified = true);

      final newLocation = PanchangLocation(
        latitude: 13.0827,
        longitude: 80.2707,
        timeZoneId: 'Asia/Kolkata',
        timeZoneOffset: const Duration(hours: 5, minutes: 30),
        locationName: 'Chennai, India (IST)',
      );

      service.setLocation(newLocation);
      expect(service.currentLocation, equals(newLocation));
      expect(notified, isTrue);

      final updatedPanchang = service.getPanchangForDate(DateTime.now());
      expect(updatedPanchang.location, equals(newLocation));
    });

    testWidgets(
      'Externally injected PanchangService is not disposed when app is unmounted',
      (WidgetTester tester) async {
        final injectedService = MockPanchangService();
        final prefs = await SharedPreferences.getInstance();

        await tester.pumpWidget(
          SanatanSathiyaApp(prefs: prefs, panchangService: injectedService),
        );
        await tester.pumpAndSettle();

        // Unmount app widget tree
        await tester.pumpWidget(const SizedBox());
        await tester.pumpAndSettle();

        // Injected service remains active and NOT disposed
        expect(() => injectedService.notifyListeners(), returnsNormally);
      },
    );

    testWidgets(
      'TodayScreen displays Panchang details and localized sample indicator in English',
      (WidgetTester tester) async {
        final devotionalService = DevotionalService();
        final panchangService = MockPanchangService();

        await tester.pumpWidget(
          MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            locale: const Locale('en'),
            home: Scaffold(
              body: TodayScreen(
                devotionalService: devotionalService,
                panchangService: panchangService,
              ),
            ),
          ),
        );
        await tester.pumpAndSettle();

        // Check Panchang content from MockPanchangService
        expect(find.text('Shukla Paksha Ekadashi (Sample)'), findsOneWidget);
        expect(find.text('Rohini (Sample)'), findsOneWidget);
        expect(find.text('Vikram Samvat 2081'), findsOneWidget);

        // Verify localized mock indicator 'Sample Data' in English
        expect(find.text('Sample Data'), findsOneWidget);
      },
    );

    testWidgets('TodayScreen displays Hindi localized sample indicator', (
      WidgetTester tester,
    ) async {
      final devotionalService = DevotionalService();
      final panchangService = MockPanchangService();

      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          locale: const Locale('hi'),
          home: Scaffold(
            body: TodayScreen(
              devotionalService: devotionalService,
              panchangService: panchangService,
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Verify localized mock indicator 'नमूना डेटा' in Hindi
      expect(find.text('नमूना डेटा'), findsOneWidget);
    });

    testWidgets('TodayScreen displays Marathi localized sample indicator', (
      WidgetTester tester,
    ) async {
      final devotionalService = DevotionalService();
      final panchangService = MockPanchangService();

      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          locale: const Locale('mr'),
          home: Scaffold(
            body: TodayScreen(
              devotionalService: devotionalService,
              panchangService: panchangService,
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Verify localized mock indicator 'नमूना डेटा' in Marathi
      expect(find.text('नमूना डेटा'), findsOneWidget);
    });
  });
}
