import 'package:flutter/foundation.dart';

enum PanchangCalculationStatus { calculated, mock, failed }

@immutable
class PanchangLocation {
  final double latitude;
  final double longitude;

  /// IANA time zone identifier (e.g., 'Asia/Kolkata').
  /// NOTE: Pairing [timeZoneId] with a fixed [timeZoneOffset] does not yet
  /// implement dynamic IANA time-zone or Daylight Saving Time (DST) lookup.
  final String timeZoneId;

  final Duration timeZoneOffset;
  final String locationName;

  PanchangLocation({
    required this.latitude,
    required this.longitude,
    required this.timeZoneId,
    required this.timeZoneOffset,
    required this.locationName,
  }) {
    if (!isValidLatitude(latitude)) {
      throw ArgumentError.value(
        latitude,
        'latitude',
        'Latitude must be a finite number between -90.0 and 90.0.',
      );
    }
    if (!isValidLongitude(longitude)) {
      throw ArgumentError.value(
        longitude,
        'longitude',
        'Longitude must be a finite number between -180.0 and 180.0.',
      );
    }
  }

  static bool isValidLatitude(double lat) =>
      !lat.isNaN && !lat.isInfinite && lat >= -90.0 && lat <= 90.0;

  static bool isValidLongitude(double lng) =>
      !lng.isNaN && !lng.isInfinite && lng >= -180.0 && lng <= 180.0;

  static final PanchangLocation defaultLocation = PanchangLocation(
    latitude: 19.0760,
    longitude: 72.8777,
    timeZoneId: 'Asia/Kolkata',
    timeZoneOffset: const Duration(hours: 5, minutes: 30),
    locationName: 'Mumbai, India (IST)',
  );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PanchangLocation &&
          runtimeType == other.runtimeType &&
          latitude == other.latitude &&
          longitude == other.longitude &&
          timeZoneId == other.timeZoneId &&
          timeZoneOffset == other.timeZoneOffset &&
          locationName == other.locationName;

  @override
  int get hashCode =>
      latitude.hashCode ^
      longitude.hashCode ^
      timeZoneId.hashCode ^
      timeZoneOffset.hashCode ^
      locationName.hashCode;
}

@immutable
class PanchangData {
  final String tithi;
  final String nakshatra;
  final String samvat;
  final String sunrise;
  final String sunset;
  final DateTime date;
  final PanchangLocation location;
  final PanchangCalculationStatus status;

  const PanchangData({
    required this.tithi,
    required this.nakshatra,
    required this.samvat,
    required this.sunrise,
    required this.sunset,
    required this.date,
    required this.location,
    required this.status,
  });

  bool get isMock => status == PanchangCalculationStatus.mock;

  PanchangData copyWith({
    String? tithi,
    String? nakshatra,
    String? samvat,
    String? sunrise,
    String? sunset,
    DateTime? date,
    PanchangLocation? location,
    PanchangCalculationStatus? status,
  }) {
    return PanchangData(
      tithi: tithi ?? this.tithi,
      nakshatra: nakshatra ?? this.nakshatra,
      samvat: samvat ?? this.samvat,
      sunrise: sunrise ?? this.sunrise,
      sunset: sunset ?? this.sunset,
      date: date ?? this.date,
      location: location ?? this.location,
      status: status ?? this.status,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PanchangData &&
          runtimeType == other.runtimeType &&
          tithi == other.tithi &&
          nakshatra == other.nakshatra &&
          samvat == other.samvat &&
          sunrise == other.sunrise &&
          sunset == other.sunset &&
          date == other.date &&
          location == other.location &&
          status == other.status;

  @override
  int get hashCode =>
      tithi.hashCode ^
      nakshatra.hashCode ^
      samvat.hashCode ^
      sunrise.hashCode ^
      sunset.hashCode ^
      date.hashCode ^
      location.hashCode ^
      status.hashCode;
}
