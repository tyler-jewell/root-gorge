part of 'map_bloc.dart';

@immutable
abstract class MapState {}

class MapInitial extends MapState {
  @override
  String toString() => 'MapInitial';
}

class MapLoaded extends MapState {
  MapLoaded({
    required this.polygons,
  });

  final Set<Polygon> polygons;

  @override
  String toString() => 'MapLoaded';
}

class AddingField extends MapState {
  AddingField({
    required this.polygons,
  });

  final Set<Polygon> polygons;

  @override
  String toString() => 'AddingField';
}
