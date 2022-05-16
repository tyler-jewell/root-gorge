import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:root_gorge/api/fields_firestore_api.dart';
import 'package:root_gorge/app/app.dart';
import 'package:root_gorge/firebase_options.dart';
import 'package:root_gorge/repository/fields_repository.dart';

Future<void> main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final fieldsApi = FirestoreFieldsApi();

  final fieldsRepository = FieldsRepository(fieldsApi: fieldsApi);

  runApp(App(fieldsRepository: fieldsRepository));
}