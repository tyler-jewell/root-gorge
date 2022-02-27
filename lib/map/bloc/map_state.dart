part of 'map_bloc.dart';

abstract class MapState extends Equatable {
  const MapState();

  @override
  List<Object> get props => [];
}

class MapLoadInProgress extends MapState {}

class MapLoadSuccess extends MapState {
  const MapLoadSuccess(this.plots);

  final List<Plot> plots;
}

class MapLoadFailure extends MapState {}
