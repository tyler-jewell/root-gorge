// ignore_for_file: avoid_redundant_argument_values

import 'package:fields_api/fields_api.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:root_gorge/fields_overview/fields_overview.dart';

void main() {
  final mockField = Field(
    id: '1',
    mapPoints: const [MarkerLatLng(1.23, 4.56)],
    beanType: 'bean type 1',
  );
  final mockFields = [mockField];
  group('FieldsOverviewState', () {
    FieldsOverviewState createSubject({
      FieldsOverviewStatus status = FieldsOverviewStatus.initial,
      List<Field>? fields,
    }) {
      return FieldsOverviewState(
        status: status,
        fields: fields ?? mockFields,
      );
    }

    test('supports value equality', () {
      expect(
        createSubject(),
        equals(createSubject()),
      );
    });

    test('props are correct', () {
      expect(
        createSubject(
          fields: mockFields,
        ).props,
        equals(<Object?>[
          FieldsOverviewStatus.initial, // status
          mockFields, // Fields
        ]),
      );
    });

    group('copyWith', () {
      test('returns the same object if not arguments are provided', () {
        expect(
          createSubject().copyWith(),
          equals(createSubject()),
        );
      });

      test('retains the old value for every parameter if null is provided', () {
        expect(
          createSubject().copyWith(
            status: null,
            fields: null,
          ),
          equals(createSubject()),
        );
      });

      test('replaces every non-null parameter', () {
        expect(
          createSubject().copyWith(
            status: () => FieldsOverviewStatus.success,
            fields: () => [],
          ),
          equals(
            createSubject(
              status: FieldsOverviewStatus.success,
              fields: [],
            ),
          ),
        );
      });
    });
  });
}
