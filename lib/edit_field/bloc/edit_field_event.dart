part of 'edit_field_bloc.dart';

abstract class EditFieldEvent extends Equatable {
  const EditFieldEvent();

  @override
  List<Object> get props => [];

  @override
  String toString() => 'EditFieldEvent';
}

class EditFieldPointsChanged extends EditFieldEvent {
  const EditFieldPointsChanged(this.mapPoints);

  final List<MarkerLatLng> mapPoints;

  @override
  List<Object> get props => [mapPoints];

  @override
  String toString() => 'EditFieldPointsChanged';
}

class EditFieldCropTypeChanged extends EditFieldEvent {
  const EditFieldCropTypeChanged(this.cropType);

  final CropType cropType;

  @override
  List<Object> get props => [cropType];

  @override
  String toString() => 'EditFieldCropTypeChanged';
}

class EditFieldPointsCompleted extends EditFieldEvent {
  const EditFieldPointsCompleted();

  @override
  List<Object> get props => [];

  @override
  String toString() => 'EditFieldPointsCompleted';
}

class EditFieldSubmitted extends EditFieldEvent {
  @override
  String toString() => 'EditFieldSubmitted';
}
