import 'package:flutter_services_binding/flutter_services_binding.dart';
import 'package:local_storage_fields_api/local_storage_fields_api.dart';
import 'package:root_gorge/bootstrap.dart';

Future<void> main() async {
  FlutterServicesBinding.ensureInitialized();

  final fieldsApi = LocalStorageFieldsApi(
    plugin: await SharedPreferences.getInstance(),
  );

  bootstrap(fieldsApi: fieldsApi);
}
