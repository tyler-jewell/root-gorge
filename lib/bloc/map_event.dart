part of 'map_bloc.dart';

@immutable
abstract class MapEvent {}

class AddButtonClicked extends MapEvent {}

class MapSubscriptionRequested extends MapEvent {}

class AddPolygon extends MapEvent {
  AddPolygon(this.polygon);
  final Polygon polygon;
}

class AddPolygonPoint extends MapEvent {
  AddPolygonPoint(this.latLng);

  final LatLng latLng;
}
