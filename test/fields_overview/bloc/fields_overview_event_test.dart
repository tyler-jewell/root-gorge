// ignore_for_file: prefer_const_constructors

import 'package:fields_api/fields_api.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:root_gorge/fields_overview/fields_overview.dart';

void main() {
  group('FieldsOverviewEvent', () {
    final mockField = Field(
      id: '1',
      mapPoints: const [MarkerLatLng(1.23, 4.56)],
      beanType: 'bean type 1',
    );

    group('FieldsOverviewSubscriptionRequested', () {
      test('supports value equality', () {
        expect(
          FieldsOverviewSubscriptionRequested(),
          equals(FieldsOverviewSubscriptionRequested()),
        );
      });

      test('props are correct', () {
        expect(
          FieldsOverviewSubscriptionRequested().props,
          equals(<Object?>[]),
        );
      });
    });
  });
}
