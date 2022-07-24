import 'package:root_gorge/repositories/fields/models/field.dart';

/// {@template fields_api}
/// The interface for an API that provides access to a list of fields.
/// {@endtemplate}
abstract class FieldsApi {
  /// {@macro fields_api}
  const FieldsApi();

  /// Provides a [List] of all [Field]s.
  Future<List<Field>> getFields();

  /// Deletes the field with the given id.
  ///
  /// If no field with the given id exists, a [FieldNotFoundException] error is
  /// thrown.
  Future<void> deleteField(String id);

  /// Saves the updated data for a field.
  ///
  Future<void> saveField(String id, Field field);
}

/// Error thrown when a [Field] with a given id is not found.
class FieldNotFoundException implements Exception {}
