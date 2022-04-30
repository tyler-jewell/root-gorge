part of 'edit_field_bloc.dart';

enum EditFieldStatus { initial, loading, success, failure }

class EditFieldState extends Equatable {
  const EditFieldState({
    this.status = EditFieldStatus.initial,
    this.initialField,
    this.mapPoints = const <Geo>[],
    this.cropType = const CropType(),
    this.herbicide = const Herbicide(),
  });

  final EditFieldStatus status;
  final List<Geo> mapPoints;
  final CropType cropType;
  final Herbicide herbicide;
  final Field? initialField;

  bool get isNewField => false;

  EditFieldState copyWith({
    EditFieldStatus? status,
    Field? initialField,
    List<Geo>? mapPoints,
    CropType? cropType,
    Herbicide? herbicide,
  }) {
    return EditFieldState(
      status: status ?? this.status,
      initialField: initialField ?? this.initialField,
      mapPoints: mapPoints ?? this.mapPoints,
      cropType: cropType ?? this.cropType,
      herbicide: herbicide ?? this.herbicide,
    );
  }

  @override
  List<Object?> get props => [
        status,
        initialField,
        mapPoints,
        cropType,
        herbicide,
      ];
}
