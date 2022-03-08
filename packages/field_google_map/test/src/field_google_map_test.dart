// ignore_for_file: prefer_const_constructors
import 'package:field_google_map/field_google_map.dart';
import 'package:fields_api/fields_api.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('FieldGoogleMap', () {
    final mockFields = [
      Field(
        id: '1',
        mapPoints: const [MarkerLatLng(1.23, 2.34)],
        beanType: 'bean type 1',
      )
    ];
    test('can be instantiated', () {
      expect(
        FieldGoogleMap(
          fields: mockFields,
          onTap: (_) {},
        ),
        isNotNull,
      );
    });
  });
}
