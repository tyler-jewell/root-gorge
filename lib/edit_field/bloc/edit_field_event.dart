part of 'edit_field_bloc.dart';

abstract class EditFieldEvent extends Equatable {
  const EditFieldEvent();

  @override
  List<Object> get props => [];
}

class EditFieldMapPointsChanged extends EditFieldEvent {
  const EditFieldMapPointsChanged(this.mapPoints);

  final List<MarkerLatLng> mapPoints;

  @override
  List<Object> get props => [mapPoints];

  @override
  String toString() => 'EditFieldMapPointsChanged';
}

class EditFieldBeanTypeChanged extends EditFieldEvent {
  const EditFieldBeanTypeChanged(this.beanType);

  final String beanType;

  @override
  List<Object> get props => [beanType];

  @override
  String toString() => 'EditFieldBeanTypeChanged';
}

class EditFieldSubmitted extends EditFieldEvent {
  @override
  String toString() => 'EditFieldSubmitted';
}
