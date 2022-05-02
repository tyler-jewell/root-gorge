import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:root_gorge/api/fields_api.dart';
import 'package:root_gorge/models/field.dart';

/// {@template firestore_fields_api}
/// A Flutter implementation of the [FieldsApi] that uses local storage.
/// {@endtemplate}
class FirestoreFieldsApi extends FieldsApi {
  /// {@macro firestore_fields_api}
  FirestoreFieldsApi();

  /// Firestore Fields collection
  final fieldsCollection = FirebaseFirestore.instance.collection('fields');

  @override
  Stream<List<Field>> getFields() =>
      fieldsCollection.snapshots().map((snapshot) {
        return snapshot.docs.map((doc) {
          return Field.fromDocument(doc);
        }).toList();
      });

  @override
  Future<void> updateField(Field field) async {
    await fieldsCollection.doc(field.id).update(field.toJson());
  }

  @override
  Future<void> deleteField(String id) async {}
}
