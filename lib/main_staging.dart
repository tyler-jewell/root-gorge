import 'package:firestore_fields_api/firestore_fields_api.dart';
import 'package:flutter_services_binding/flutter_services_binding.dart';
import 'package:root_gorge/bootstrap.dart';

Future<void> main() async {
  FlutterServicesBinding.ensureInitialized();

  final fieldsApi = FirestoreFieldsApi();

  bootstrap(fieldsApi: fieldsApi);
}
