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
}

class EditFieldBeanTypeChanged extends EditFieldEvent {
  const EditFieldBeanTypeChanged(this.beanType);

  final String beanType;

  @override
  List<Object> get props => [beanType];
}

class EditFieldSubmitted extends EditFieldEvent {
  // const EditFieldSubmitted(this.field);

  // final Field field;

  // @override
  // List<Object> get props => [field];
}
