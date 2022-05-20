part of 'add_field_bloc.dart';

abstract class AddFieldEvent extends Equatable {
  const AddFieldEvent();

  @override
  List<Object> get props => [];

  @override
  String toString() => 'AddFieldEvent';
}

class AddFieldRequested extends AddFieldEvent {
  const AddFieldRequested(this.lat, this.lng);

  final double lat;
  final double lng;

  @override
  String toString() => 'AddFieldRequested';
}

class AddPolygonPoint extends AddFieldEvent {
  const AddPolygonPoint(this.point);

  final LatLng point;

  @override
  List<Object> get props => [point];

  @override
  String toString() => 'AddPolygonPoint { point: $point }';
}

class UserLocationRequested extends AddFieldEvent {
  const UserLocationRequested();

  @override
  String toString() => 'UserLocationRequested';
}
