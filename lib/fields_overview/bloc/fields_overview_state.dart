part of 'fields_overview_bloc.dart';

enum FieldsOverviewStatus { initial, loading, success, failure }

class FieldsOverviewState extends Equatable {
  const FieldsOverviewState({
    this.status = FieldsOverviewStatus.initial,
    this.fields = const [],
    this.cropTypes = const [],
    this.herbicides = const [],
    this.userLatitude = 40.015922725177575,
    this.userLongitude = -89.02627513286437,
    this.editingField = false,
  });

  final FieldsOverviewStatus status;
  final List<Field> fields;
  final List<CropType> cropTypes;
  final List<Herbicide> herbicides;
  final double userLatitude;
  final double userLongitude;
  final bool editingField;

  CropType cropTypeFromId(String cropTypeId) {
    return cropTypes.firstWhere((cropType) => cropType.id == cropTypeId);
  }

  Herbicide herbicideFromId(String herbicideId) {
    return herbicides.firstWhere((herbicide) => herbicide.id == herbicideId);
  }

  FieldsOverviewState copyWith({
    FieldsOverviewStatus? status,
    List<Field>? fields,
    List<CropType>? cropTypes,
    List<Herbicide>? herbicides,
    double? userLatitude,
    double? userLongitude,
    bool? editingField,
  }) {
    return FieldsOverviewState(
      status: status ?? this.status,
      fields: fields ?? this.fields,
      cropTypes: cropTypes ?? this.cropTypes,
      herbicides: herbicides ?? this.herbicides,
      userLatitude: userLatitude ?? this.userLatitude,
      userLongitude: userLongitude ?? this.userLongitude,
      editingField: editingField ?? this.editingField,
    );
  }

  @override
  List<Object?> get props => [
        status,
        fields,
        cropTypes,
        herbicides,
        userLatitude,
        userLongitude,
        editingField,
      ];
}

class FieldsOverviewError extends FieldsOverviewState {
  const FieldsOverviewError(this.error);

  final String error;

  @override
  List<Object> get props => [error];
}
