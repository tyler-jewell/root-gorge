import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';

import 'package:flutter/widgets.dart';
import 'package:root_gorge/api/fields_api.dart';
import 'package:root_gorge/api/location_api.dart';
import 'package:root_gorge/app/app.dart';
import 'package:root_gorge/repository/fields_repository.dart';

class AppBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    log('onChange(${bloc.runtimeType}, $change)');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    log('onError(${bloc.runtimeType}, $error, $stackTrace)');
    super.onError(bloc, error, stackTrace);
  }
}

void bootstrap({
  required FieldsApi fieldsApi,
  required LocationApi locationApi,
}) {
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  final fieldsRepository =
      FieldsRepository(fieldsApi: fieldsApi, locationApi: locationApi);

  runZonedGuarded(
    () async {
      await BlocOverrides.runZoned(
        () async => runApp(
          App(fieldsRepository: fieldsRepository),
        ),
        blocObserver: AppBlocObserver(),
      );
    },
    (error, stackTrace) => log(error.toString(), stackTrace: stackTrace),
  );
}
