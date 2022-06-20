import 'package:geolocator/geolocator.dart';
import 'package:root_gorge/api/fields_api.dart';
import 'package:root_gorge/api/location_api.dart';
import 'package:root_gorge/models/crop_type.dart';
import 'package:root_gorge/models/field.dart';
import 'package:root_gorge/models/herbicide.dart';

final cropTypes = [
  const CropType(
    id: 'wheat',
    name: 'Wheat',
    description: 'This is a wheat field.',
    color: 0xFFEED715,
  ),
  const CropType(
    id: 'corn',
    name: 'Corn',
    description: 'This is a corn field.',
    color: 0xFFECEA1B,
  ),
  const CropType(
    id: 'soybean',
    name: 'Soybean',
    description: 'This is a soybean field.',
    color: 0xFF28DF82,
  ),
  const CropType(
    id: 'non-gmo',
    name: 'Non-GMO',
    description: 'This is a Non-GMO field.',
    color: 0xFF2E5EEF,
  ),
  const CropType(
    id: 'organic',
    name: 'Organic',
    description: 'This is an Organic field.',
    color: 0xFFB145DB,
  ),
];

final herbicides = [
  const Herbicide(
    id: 'dicamba',
    name: 'Dicamba',
    description: 'This is Dicamba herbicide.',
  ),
  const Herbicide(
    id: 'enlist',
    name: 'Enlist',
    description: 'This is Enlist herbicide.',
  ),
];

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

  /// Provides a [Stream] of all [CropType]s.
  List<CropType> getCropTypes() => cropTypes;

  /// Provides a [Stream] of all [Herbicide]s.
  List<Herbicide> getHerbicides() => herbicides;

  /// Updates the [field].
  Future<void> updateField(Field field) => _fieldsApi.updateField(field);

  /// Deletes the field with the given id.
  ///
  /// If no field with the given id exists, a [FieldNotFoundException] error is
  /// thrown.
  Future<void> deleteField(String id) => _fieldsApi.deleteField(id);
}
