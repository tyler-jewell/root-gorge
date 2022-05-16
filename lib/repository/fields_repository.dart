import 'package:root_gorge/api/fields_api.dart';
import 'package:root_gorge/models/crop_type.dart';
import 'package:root_gorge/models/field.dart';
import 'package:root_gorge/models/herbicide.dart';

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
  Future<List<Field>> getFields() => _fieldsApi.getFields();

  /// Provides a [Stream] of all [CropType]s.
  Future<List<CropType>> getCropTypes() => _fieldsApi.getCropTypes();

  /// Provides a [Stream] of all [Herbicide]s.
  Future<List<Herbicide>> getHerbicides() => _fieldsApi.getHerbicides();

  /// Updates the [field].
  Future<void> updateField(Field field) => _fieldsApi.updateField(field);

  /// Deletes the field with the given id.
  ///
  /// If no field with the given id exists, a [FieldNotFoundException] error is
  /// thrown.
  Future<void> deleteField(String id) => _fieldsApi.deleteField(id);
}
