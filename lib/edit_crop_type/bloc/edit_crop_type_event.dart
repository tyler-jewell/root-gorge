part of 'edit_crop_type_bloc.dart';

abstract class EditCropTypeEvent extends Equatable {
  const EditCropTypeEvent();

  @override
  List<Object> get props => [];

  @override
  String toString() => 'EditCropTypeEvent';
}

class EditCropTypeNameChanged extends EditCropTypeEvent {
  const EditCropTypeNameChanged(this.name);

  final String name;

  @override
  List<Object> get props => [name];

  @override
  String toString() => 'EditCropTypeNameChanged';
}

class EditCropTypeColorChanged extends EditCropTypeEvent {
  const EditCropTypeColorChanged(this.color);

  final Color color;

  @override
  List<Object> get props => [color];

  @override
  String toString() => 'EditCropTypeColorChanged';
}

class EditCropPickingColorCompleted extends EditCropTypeEvent {
  const EditCropPickingColorCompleted();

  @override
  List<Object> get props => [];

  @override
  String toString() => 'EditCropPickingColorCompleted';
}

class EditCropTypeSubmitted extends EditCropTypeEvent {
  @override
  List<Object> get props => [];

  @override
  String toString() => 'EditCropTypeSubmitted';
}
