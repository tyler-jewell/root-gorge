import 'package:geolocator/geolocator.dart';

/// {@template fields_api}
/// The interface for an API that provides access to a list of fields.
/// {@endtemplate}
class LocationApi {
  /// {@macro fields_api}
  const LocationApi();

  /// Provides a [Stream] of the current users [Position].
  Stream<Position> getUserLocation() {
    return Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        timeLimit: Duration(seconds: 3),
      ),
    );
  }
}
