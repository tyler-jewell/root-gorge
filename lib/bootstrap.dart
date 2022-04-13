// Copyright (c) 2021, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:fields_api/fields_api.dart';
import 'package:fields_repository/fields_repository.dart';
import 'package:flutter/widgets.dart';
import 'package:root_gorge/app/app.dart';

class AppBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    print('onChange(${bloc.runtimeType}, $change)');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    log('onError(${bloc.runtimeType}, $error, $stackTrace)');
    super.onError(bloc, error, stackTrace);
  }
}

void bootstrap({required FieldsApi fieldsApi}) {
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  final fieldsRepository = FieldsRepository(fieldsApi: fieldsApi);

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
