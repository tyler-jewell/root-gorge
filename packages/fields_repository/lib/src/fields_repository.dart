import 'package:fields_api/fields_api.dart';

/// {@template fields_repository}
/// A repository that handles field related requests.
/// {@endtemplate}
class FieldsRepository {
  /// {@macro fields_repository}
  const FieldsRepository({
    required FieldsApi fieldsApi,
  }) : _fieldsApi = fieldsApi;

  final FieldsApi _fieldsApi;

  /// Provides a [Stream] of all fields.
  Stream<List<Field>> getFields() => _fieldsApi.getFields();

  /// Provides a [Stream] of all crop types.
  Stream<List<CropType>> getCropTypes() => _fieldsApi.getCropTypes();

  /// Saves a [field].
  ///
  /// If a [field] with the same id already exists, it will be replaced.
  Future<void> saveField(Field field) => _fieldsApi.saveField(field);

  /// Saves a [cropType].
  ///
  /// If a [cropType] with the same id already exists, it will be replaced.
  Future<void> saveCropType(CropType cropType) =>
      _fieldsApi.saveCropType(cropType);

  /// Deletes the field with the given id.
  ///
  /// If no field with the given id exists, a [FieldNotFoundException] error is
  /// thrown.
  Future<void> deleteField(String id) => _fieldsApi.deleteField(id);
}
