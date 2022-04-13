import 'package:fields_api/fields_api.dart';

/// {@template fields_api}
/// The interface for an API that provides access to a list of fields.
/// {@endtemplate}
abstract class FieldsApi {
  /// {@macro fields_api}
  const FieldsApi();

  /// Provides a [Stream] of all fields.
  Stream<List<Field>> getFields();

  /// Saves a [field].
  ///
  /// If a [field] with the same id already exists, it will be replaced.
  Future<void> saveField(Field field);

  /// Deletes the field with the given id.
  ///
  /// If no field with the given id exists, a [FieldNotFoundException] error is
  /// thrown.
  Future<void> deleteField(String id);
}

/// Error thrown when a [Field] with a given id is not found.
class FieldNotFoundException implements Exception {}
