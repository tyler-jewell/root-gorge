import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:root_gorge/api/fields_api.dart';
import 'package:root_gorge/models/crop_type.dart';
import 'package:root_gorge/models/field.dart';
import 'package:root_gorge/models/herbicide.dart';

/// {@template firestore_fields_api}
/// A Flutter implementation of the [FieldsApi] that uses local storage.
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
  Stream<List<CropType>> getCropTypes() =>
      cropTypeCollection.snapshots().map((snapshot) {
        return snapshot.docs.map((doc) {
          return CropType.fromDocument(doc);
        }).toList();
      });

  @override
  Stream<List<Herbicide>> getHerbicides() =>
      herbicideCollection.snapshots().map((snapshot) {
        return snapshot.docs.map((doc) {
          return Herbicide.fromDocument(doc);
        }).toList();
      });

  @override
  Future<void> updateField(Field field) async {
    await fieldsCollection.doc(field.id).update(field.toJson());
  }

  @override
  Future<void> deleteField(String id) async {}
}
