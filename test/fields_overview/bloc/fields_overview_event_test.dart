// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:root_gorge/fields_overview/fields_overview.dart';

void main() {
  group('FieldsOverviewEvent', () {
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
