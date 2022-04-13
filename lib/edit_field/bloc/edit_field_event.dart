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

  final List<MarkerLatLng> mapPoints;

  @override
  List<Object> get props => [mapPoints];

  @override
  String toString() => 'EditFieldMapPointsChanged';
}

class EditFieldCropTypeChanged extends EditFieldEvent {
  const EditFieldCropTypeChanged(this.cropType);

  final CropType cropType;

  @override
  List<Object> get props => [cropType];

  @override
  String toString() => 'EditFieldCropTypeChanged';
}

class EditFieldHerbicideChanged extends EditFieldEvent {
  const EditFieldHerbicideChanged(this.herbicide);

  final Herbicide herbicide;

  @override
  List<Object> get props => [herbicide];

  @override
  String toString() => 'EditFieldHerbicideChanged';
}

class EditFieldSubmitted extends EditFieldEvent {
  @override
  String toString() => 'EditFieldSubmitted';
}
