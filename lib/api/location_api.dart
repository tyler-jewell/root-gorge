import 'package:geolocator/geolocator.dart';

/// {@template fields_api}
/// The interface for an API that provides access to a list of fields.
/// {@endtemplate}
class LocationApi {
  /// {@macro fields_api}
  const LocationApi();

  /// Provides a [Future] of the current users [Position].
  Future<Position> getUserLocation() {
    return Geolocator.getCurrentPosition();
  }
}
