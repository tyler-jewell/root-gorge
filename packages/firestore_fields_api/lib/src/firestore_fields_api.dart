import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fields_api/fields_api.dart';

/// {@template firestore_fields_api}
/// A Flutter implementation of the [FieldsApi] that uses local storage.
/// {@endtemplate}
class FirestoreFieldsApi extends FieldsApi {
  /// {@macro firestore_fields_api}
  FirestoreFieldsApi();

  /// Firestore Fields collection
  final fieldsCollection = FirebaseFirestore.instance.collection('fields');

  /// Firestore Crop Type collection
  final cropTypesCollection =
      FirebaseFirestore.instance.collection('crop-types');

  @override
  Stream<List<Field>> getFields() =>
      fieldsCollection.snapshots().map((snapshot) {
        return snapshot.docs.map((doc) {
          return Field.fromJson(doc.data());
        }).toList();
      });

  @override
  Future<void> saveField(Field field) async {
    await fieldsCollection.add(field.toJson());
  }

  @override
  Future<void> deleteField(String id) async {}
}
