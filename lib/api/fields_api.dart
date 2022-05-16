import 'package:root_gorge/models/crop_type.dart';
import 'package:root_gorge/models/field.dart';
import 'package:root_gorge/models/herbicide.dart';

/// {@template fields_api}
/// The interface for an API that provides access to a list of fields.
/// {@endtemplate}
abstract class FieldsApi {
  /// {@macro fields_api}
  const FieldsApi();

  /// Provides a [Stream] of all [Field]s.
  Future<List<Field>> getFields();

  /// Provides a [Stream] of all [CropType]s.
  Future<List<CropType>> getCropTypes();

  /// Provides a [Stream] of all [Herbicide]s.
  Future<List<Herbicide>> getHerbicides();

  /// Updates the [field].
  Future<void> updateField(Field field);

  /// Deletes the field with the given id.
  ///
  /// If no field with the given id exists, a [FieldNotFoundException] error is
  /// thrown.
  Future<void> deleteField(String id);
}

/// Error thrown when a [Field] with a given id is not found.
class FieldNotFoundException implements Exception {}
