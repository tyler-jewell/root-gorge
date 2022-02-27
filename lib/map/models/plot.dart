import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

/// {@template plot}
/// Plot model that represents a dynamic polygon on the map.
///
/// {@endtemplate}
class Plot extends Equatable {
  /// {@macro plot}
  const Plot({
    required this.id,
    this.plotMarkers = const <LatLng>[],
  });

  /// The current plot's id.
  final String id;

  /// The individual plot markers.
  final List<LatLng> plotMarkers;

  @override
  List<Object?> get props => [plotMarkers];
}
