part of 'add_field_bloc.dart';

abstract class AddFieldEvent extends Equatable {
  const AddFieldEvent();

  @override
  List<Object> get props => [];
}

class AddFieldMapPointsChanged extends AddFieldEvent {
  const AddFieldMapPointsChanged(this.mapPoints);

  final List<MarkerLatLng> mapPoints;

  @override
  List<Object> get props => [mapPoints];

  @override
  String toString() => 'AddFieldMapPointsChanged';
}

class AddFieldBeanTypeChanged extends AddFieldEvent {
  const AddFieldBeanTypeChanged(this.beanType);

  final String beanType;

  @override
  List<Object> get props => [beanType];

  @override
  String toString() => 'AddFieldBeanTypeChanged';
}

class AddFieldSubmitted extends AddFieldEvent {
  @override
  String toString() => 'AddFieldSubmitted';
}
