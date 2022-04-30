import 'package:flutter_services_binding/flutter_services_binding.dart';
import 'package:root_gorge/api/fields_firestore_api.dart';
import 'package:root_gorge/bootstrap.dart';

Future<void> main() async {
  FlutterServicesBinding.ensureInitialized();

  final fieldsApi = FirestoreFieldsApi();

  bootstrap(fieldsApi: fieldsApi);
}
