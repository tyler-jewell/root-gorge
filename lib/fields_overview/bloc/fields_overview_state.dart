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
    return cropTypes.where((cropType) => cropType.id == cropTypeId).first;
  }

  FieldsOverviewState copyWith({
    FieldsOverviewStatus Function()? status,
    List<Field> Function()? fields,
    List<CropType> Function()? cropTypes,
    List<Herbicide> Function()? herbicides,
  }) {
    return FieldsOverviewState(
      status: status != null ? status() : this.status,
      fields: fields != null ? fields() : this.fields,
      cropTypes: cropTypes != null ? cropTypes() : this.cropTypes,
      herbicides: herbicides != null ? herbicides() : this.herbicides,
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
