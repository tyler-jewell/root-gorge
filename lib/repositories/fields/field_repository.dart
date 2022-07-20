import 'package:root_gorge/api/fields_api.dart';
import 'package:root_gorge/repositories/fields/models/field.dart';

/// {@template fields_repository}
/// A repository that handles field related requests.
/// {@endtemplate}
class FieldsRepository {
  /// {@macro fields_repository}
  const FieldsRepository({
    required FieldsApi fieldsApi,
  }) : _fieldsApi = fieldsApi;

  final FieldsApi _fieldsApi;

  /// Provides a [Future] of all [Fields]s.
  Future<List<Field>> getFields() => _fieldsApi.getFields();

  /// Saves a [field].
  ///
  /// If a [field] with the same id already exists, it will be replaced.
  Future<void> saveField(
    String fieldId,
    Field field,
  ) =>
      _fieldsApi.saveField(
        fieldId,
        field,
      );

  /// Deletes the with the given id.
  ///
  /// If no field with the given id exists, a [FieldNotFoundException] error is
  /// thrown.
  Future<void> deleteField(String id) => _fieldsApi.deleteField(id);
}
