import 'package:root_gorge/api/fields_api.dart';
import 'package:root_gorge/models/field.dart';

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

  /// Updates the [field].
  Future<void> updateField(Field field) => _fieldsApi.updateField(field);

  /// Deletes the field with the given id.
  ///
  /// If no field with the given id exists, a [FieldNotFoundException] error is
  /// thrown.
  Future<void> deleteField(String id) => _fieldsApi.deleteField(id);
}
