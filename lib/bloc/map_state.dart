part of 'map_bloc.dart';

@immutable
abstract class MapState {}

class MapLoading extends MapState {
  @override
  String toString() => 'MapLoading';
}

class MapLoaded extends MapState {
  MapLoaded({
    required this.polygons,
  });

  final Set<Polygon> polygons;

  @override
  String toString() => 'MapLoaded';
}

class AddingMap extends MapState {
  @override
  String toString() => 'AddingMap';
}
