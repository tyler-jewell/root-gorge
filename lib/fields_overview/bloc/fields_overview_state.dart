part of 'fields_overview_bloc.dart';

enum FieldsOverviewStatus { initial, loading, success, failure }

class FieldsOverviewState extends Equatable {
  const FieldsOverviewState({
    this.status = FieldsOverviewStatus.initial,
    this.fields = const [],
    this.cropTypes = const [],
    this.herbicides = const [],
  });

  final FieldsOverviewStatus status;
  final List<Field> fields;
  final List<CropType> cropTypes;
  final List<Herbicide> herbicides;

  CropType cropTypeFromId(String cropTypeId) {
    return cropTypes.firstWhere((cropType) => cropType.id == cropTypeId);
  }

  Herbicide herbicideFromId(String herbideId) {
    return herbicides.firstWhere((herbicide) => herbicide.id == herbideId);
  }

  FieldsOverviewState copyWith({
    FieldsOverviewStatus? status,
    List<Field>? fields,
    List<CropType>? cropTypes,
    List<Herbicide>? herbicides,
  }) {
    return FieldsOverviewState(
      status: status ?? this.status,
      fields: fields ?? this.fields,
      cropTypes: cropTypes ?? this.cropTypes,
      herbicides: herbicides ?? this.herbicides,
    );
  }

  @override
  List<Object?> get props => [status, fields, cropTypes, herbicides];
}

class FieldsOverviewError extends FieldsOverviewState {
  const FieldsOverviewError(this.error);

  final String error;

  @override
  List<Object> get props => [error];
}
