import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:root_gorge/models/field.dart';
import 'package:root_gorge/models/herbicide.dart';

/// {@template firestore_api}
/// A Flutter implementation of the [FieldsApi].
/// {@endtemplate}
class FirestoreFieldsApi extends FieldsApi {
  /// {@macro firestore_fields_api}
  FirestoreFieldsApi();

  /// Firestore Fields collection
  final fieldsCollection = FirebaseFirestore.instance.collection('fields');

  /// Firestore CropTypes collection
  final cropTypeCollection = FirebaseFirestore.instance.collection('cropTypes');

  /// Firestore [Herbicide] collection
  final herbicideCollection =
      FirebaseFirestore.instance.collection('herbicides');

  @override
  Stream<List<Field>> getFields() {
    return fieldsCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return Field.fromDocument(doc);
      }).toList();
    });
  }

  @override
  Future<List<CropType>> getCropTypes() => cropTypeCollection.get().then(
        (snapshot) => snapshot.docs.map(CropType.fromDocument).toList(),
      );

  @override
  Future<List<Herbicide>> getHerbicides() => herbicideCollection.get().then(
        (snapshot) => snapshot.docs.map(Herbicide.fromDocument).toList(),
      );

  @override
  Future<void> updateField(Field field) async {
    await fieldsCollection.doc(field.id).update(field.toJson());
  }

  @override
  Future<void> deleteField(String id) async {}
}
