// ignore_for_file: avoid_redundant_argument_values

import 'package:fields_api/fields_api.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:root_gorge/edit_field/edit_field.dart';

void main() {
  const mockMapPoint = MarkerLatLng(1.23, 4.56);
  final mockMapPoints = [mockMapPoint];
  group('EditFieldState', () {
    EditFieldState createSubject({
      EditFieldStatus status = EditFieldStatus.initial,
      List<MarkerLatLng>? mapPoints,
      String? beanType,
    }) {
      return EditFieldState(
        status: status,
        mapPoints: mapPoints ?? mockMapPoints,
        beanType: beanType ?? '',
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
          mapPoints: mockMapPoints,
        ).props,
        equals(<Object?>[
          EditFieldStatus.initial, // status
          mockMapPoints, // Fields
          '', // beanType
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
            mapPoints: null,
            beanType: null,
          ),
          equals(createSubject()),
        );
      });

      test('replaces every non-null parameter', () {
        expect(
          createSubject().copyWith(
            status: EditFieldStatus.success,
            mapPoints: <MarkerLatLng>[],
            beanType: 'bean type new',
          ),
          equals(
            createSubject(
              status: EditFieldStatus.success,
              mapPoints: <MarkerLatLng>[],
              beanType: 'bean type new',
            ),
          ),
        );
      });
    });
  });
}
