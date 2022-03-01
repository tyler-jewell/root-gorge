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

class AddingPolygon extends MapState {
  AddingPolygon({
    required this.polygon,
  });

  final Polygon polygon;

  @override
  String toString() => 'AddingMap';
}
