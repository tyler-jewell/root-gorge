import 'package:fields_repository/fields_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockFieldsRepository extends Mock implements FieldsRepository {}

extension PumpApp on WidgetTester {
  Future<void> pumpApp(
    Widget widget, {
    FieldsRepository? fieldsRepository,
  }) {
    return pumpWidget(
      RepositoryProvider.value(
        value: fieldsRepository ?? MockFieldsRepository(),
        child: MaterialApp(
          home: Scaffold(body: widget),
        ),
      ),
    );
  }

  Future<void> pumpRoute(
    Route<dynamic> route, {
    FieldsRepository? fieldsRepository,
  }) {
    return pumpApp(
      Navigator(onGenerateRoute: (_) => route),
      fieldsRepository: fieldsRepository,
    );
  }
}
