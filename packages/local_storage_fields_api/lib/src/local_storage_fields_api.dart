import 'dart:async';
import 'dart:convert';

import 'package:fields_api/fields_api.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/subjects.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// {@template local_storage_fields_api}
/// A Flutter implementation of the [FieldsApi] that uses local storage.
/// {@endtemplate}
class LocalStorageFieldsApi extends FieldsApi {
  /// {@macro local_storage_fields_api}
  LocalStorageFieldsApi({
    required SharedPreferences plugin,
  }) : _plugin = plugin {
    _init();
  }

  final SharedPreferences _plugin;

  final _fieldStreamController = BehaviorSubject<List<Field>>.seeded(const []);

  /// The key used for storing the fields locally.
  ///
  /// This is only exposed for testing and shouldn't be used by consumers of
  /// this library.
  @visibleForTesting
  static const kFieldsCollectionKey = '__fields_collection_key__';

  String? _getValue(String key) => _plugin.getString(key);

  Future<void> _setValue(String key, String value) =>
      _plugin.setString(key, value);

  void _init() {
    final fieldsJson = _getValue(kFieldsCollectionKey);
    if (fieldsJson != null) {
      final fields = List<Map>.from(json.decode(fieldsJson) as List)
          .map((jsonMap) => Field.fromJson(Map<String, dynamic>.from(jsonMap)))
          .toList();
      _fieldStreamController.add(fields);
    } else {
      _fieldStreamController.add(const []);
    }
  }

  @override
  Stream<List<Field>> getFields() => _fieldStreamController.asBroadcastStream();

  @override
  Future<void> saveField(Field field) {
    final fields = [..._fieldStreamController.value];
    final fieldIndex = fields.indexWhere((t) => t.id == field.id);
    if (fieldIndex >= 0) {
      fields[fieldIndex] = field;
    } else {
      fields.add(field);
    }

    _fieldStreamController.add(fields);
    return _setValue(kFieldsCollectionKey, json.encode(fields));
  }

  @override
  Future<void> deleteField(String id) async {
    final fields = [..._fieldStreamController.value];
    final fieldIndex = fields.indexWhere((t) => t.id == id);
    if (fieldIndex == -1) {
      throw FieldNotFoundException();
    } else {
      fields.removeAt(fieldIndex);
      _fieldStreamController.add(fields);
      return _setValue(kFieldsCollectionKey, json.encode(fields));
    }
  }
}
