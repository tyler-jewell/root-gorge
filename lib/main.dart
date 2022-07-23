import 'package:authentication_repository/authentication_repository.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:root_gorge/api/firestore_api.dart';
import 'package:root_gorge/app/app.dart';
import 'package:root_gorge/firebase_options.dart';
import 'package:root_gorge/repositories/fields/fields.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final authenticationRepository = AuthenticationRepository();
  final fieldsRepository = FieldsRepository(fieldsApi: FirestoreFieldsApi());

  await authenticationRepository.user.first;
  runApp(
    App(
      authenticationRepository: authenticationRepository,
      fieldsRepository: fieldsRepository,
    ),
  );
}
