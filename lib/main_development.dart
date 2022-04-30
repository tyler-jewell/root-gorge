import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_services_binding/flutter_services_binding.dart';
import 'package:root_gorge/api/fields_firestore_api.dart';
import 'package:root_gorge/bootstrap.dart';
import 'package:root_gorge/firebase_options.dart';

Future<void> main() async {
  FlutterServicesBinding.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final fieldsApi = FirestoreFieldsApi();

  bootstrap(fieldsApi: fieldsApi);
}
