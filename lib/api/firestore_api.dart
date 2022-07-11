import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:root_gorge/api/fields_api.dart';
import 'package:root_gorge/models/field.dart';

/// {@template firestore_api}
/// A Flutter implementation of the [FieldsApi].
/// {@endtemplate}
class FirestoreFieldsApi extends FieldsApi {
  /// {@macro firestore_fields_api}
  FirestoreFieldsApi();

  /// Firestore Fields collection
  final fieldsCollection = FirebaseFirestore.instance.collection('fields');

  @override
  Future<List<Field>> getFields() async {
    final snapshots = await fieldsCollection.get();

    return snapshots.docs.map((e) => Field.fromDocument(e)).toList();
  }

  @override
  Future<void> deleteField(String id) async {}
}
