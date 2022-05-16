part of 'edit_field_bloc.dart';

enum EditFieldStatus { initial, loading, success, failure }

class EditFieldState extends Equatable {
  const EditFieldState({
    this.status = EditFieldStatus.initial,
    this.initialField,
    this.mapPoints = const <Geo>[],
    this.cropTypeId = '',
    this.herbicideId = '',
    this.cropTypes = const [],
    this.herbicides = const [],
  });

  final EditFieldStatus status;
  final List<Geo> mapPoints;
  final String cropTypeId;
  final String herbicideId;
  final Field? initialField;
  final List<CropType> cropTypes;
  final List<Herbicide> herbicides;

  bool get isNewField => false;

  EditFieldState copyWith({
    EditFieldStatus? status,
    Field? initialField,
    List<Geo>? mapPoints,
    String? cropTypeId,
    String? herbicideId,
    List<CropType>? cropTypes,
    List<Herbicide>? herbicides,
  }) {
    return EditFieldState(
      status: status ?? this.status,
      initialField: initialField ?? this.initialField,
      mapPoints: mapPoints ?? this.mapPoints,
      cropTypeId: cropTypeId ?? this.cropTypeId,
      herbicideId: herbicideId ?? this.herbicideId,
      cropTypes: cropTypes ?? this.cropTypes,
      herbicides: herbicides ?? this.herbicides,
    );
  }

  @override
  List<Object?> get props => [
        status,
        initialField,
        mapPoints,
        cropTypeId,
        herbicideId,
        cropTypes,
        herbicides,
      ];
}
