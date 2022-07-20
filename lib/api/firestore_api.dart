import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:root_gorge/api/fields_api.dart';
import 'package:root_gorge/repositories/fields/models/field.dart';

/// {@template firestore_fields_api}
/// A Flutter implementation of the [FirestoreFieldsApi].
/// {@endtemplate}
class FirestoreFieldsApi extends FieldsApi {
  /// {@macro firestore_fields_api}
  FirestoreFieldsApi();

  /// Firestore Fields collection
  final fieldsCollection = FirebaseFirestore.instance.collection('fields');

  @override
  Future<List<Field>> getFields() async {
    final snapshots = await fieldsCollection.get();

    return snapshots.docs.map(Field.fromDocument).toList();
  }

  @override
  Future<void> deleteField(String id) async {}

  @override
  Future<void> saveField(String id, Field field) async {
    final doc = await fieldsCollection.doc(id).get();

    if (doc.exists) {
      await fieldsCollection.doc(id).update(field.toJson());
    } else {
      await fieldsCollection.doc(id).set(field.toJson());
    }
  }
}
