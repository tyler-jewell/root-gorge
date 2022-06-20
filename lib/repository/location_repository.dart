import 'package:geolocator/geolocator.dart';
import 'package:root_gorge/api/location_api.dart';

/// {@template location_repository}
/// A repository that handles app related requests.
/// {@endtemplate}
class LocationRepository {
  /// {@macro location_repository}
  const LocationRepository({
    required LocationApi locationApi,
  }) : _locationApi = locationApi;

  final LocationApi _locationApi;

  /// Provides a [Future] of users current [Position].
  Future<Position> getUserLocation() => _locationApi.getUserLocation();
}
