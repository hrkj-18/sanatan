import 'package:flutter/foundation.dart';

import '../models/panchang_data.dart';

abstract class PanchangService extends ChangeNotifier {
  PanchangData getPanchangForDate(DateTime date, {PanchangLocation? location});

  PanchangLocation get currentLocation;

  void setLocation(PanchangLocation newLocation);
}

class MockPanchangService extends PanchangService {
  PanchangLocation _location;

  MockPanchangService({PanchangLocation? currentLocation})
    : _location = currentLocation ?? PanchangLocation.defaultLocation;

  @override
  PanchangLocation get currentLocation => _location;

  @override
  void setLocation(PanchangLocation newLocation) {
    if (_location != newLocation) {
      _location = newLocation;
      notifyListeners();
    }
  }

  @override
  PanchangData getPanchangForDate(DateTime date, {PanchangLocation? location}) {
    final effectiveLocation = location ?? currentLocation;
    return PanchangData(
      tithi: 'Shukla Paksha Ekadashi (Sample)',
      nakshatra: 'Rohini (Sample)',
      samvat: 'Vikram Samvat 2081',
      sunrise: '06:28 AM',
      sunset: '06:12 PM',
      date: date,
      location: effectiveLocation,
      status: PanchangCalculationStatus.mock,
    );
  }
}
