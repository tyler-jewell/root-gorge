part of 'edit_field_bloc.dart';

abstract class EditFieldEvent extends Equatable {
  const EditFieldEvent();

  @override
  List<Object> get props => [];

  @override
  String toString() => 'EditFieldEvent';
}

class EditFieldMapPointsChanged extends EditFieldEvent {
  const EditFieldMapPointsChanged(this.mapPoints);

  final List<Geo> mapPoints;

  @override
  List<Object> get props => [mapPoints];

  @override
  String toString() => 'EditFieldMapPointsChanged';
}

class EditFieldCropTypeChanged extends EditFieldEvent {
  const EditFieldCropTypeChanged(this.cropTypeId);

  final String cropTypeId;

  @override
  List<Object> get props => [cropTypeId];

  @override
  String toString() => 'EditFieldCropTypeChanged';
}

class EditFieldHerbicideChanged extends EditFieldEvent {
  const EditFieldHerbicideChanged(this.herbicideId);

  final String herbicideId;

  @override
  List<Object> get props => [herbicideId];

  @override
  String toString() => 'EditFieldHerbicideChanged';
}

class EditFieldSubmitted extends EditFieldEvent {
  @override
  String toString() => 'EditFieldSubmitted';
}

class EditFieldRequested extends EditFieldEvent {
  @override
  String toString() => 'EditFieldRequested';
}
