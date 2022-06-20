import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:root_gorge/api/fields_firestore_api.dart';
import 'package:root_gorge/api/location_api.dart';
import 'package:root_gorge/app/app.dart';
import 'package:root_gorge/firebase_options.dart';
import 'package:root_gorge/repository/fields_repository.dart';
import 'package:root_gorge/repository/location_repository.dart';

Future<void> main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  const locationApi = LocationApi();
  final fieldsApi = FirestoreFieldsApi();

  runApp(
    App(
      locationRepository: const LocationRepository(locationApi: locationApi),
      fieldsRepository: FieldsRepository(fieldsApi: fieldsApi),
    ),
  );
}
