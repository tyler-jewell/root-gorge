part of 'map_bloc.dart';

abstract class MapEvent extends Equatable {
  const MapEvent();

  @override
  List<Object> get props => [];
}

class MarkerAddedToPlot extends MapEvent {
  const MarkerAddedToPlot(this.id, this.latLng);

  final String id;
  final LatLng latLng;

  @override
  List<Object> get props => [latLng];
}
