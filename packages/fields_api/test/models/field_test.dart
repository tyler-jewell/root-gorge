// import 'package:fields_api/fields_api.dart';

// import 'package:test/test.dart';

// void main() {
//   group('Field', () {
    // Field createSubject({
    //   String? id = '1',
    //   List<MarkerLatLng> mapPoints = const [MarkerLatLng(1.23, 3.45)],
    //   String beanType = 'normal',
    // }) {
    //   return Field(id: id, mapPoints: mapPoints, cropType: const CropType());
    // }

    // group('constructor', () {
      // test('works correctly', () {
      //   expect(
      //     createSubject,
      //     returnsNormally,
      //   );
      // });

      // test('throws AssertionError when id is empty', () {
      //   expect(
      //     () => createSubject(id: ''),
      //     throwsA(isA<AssertionError>()),
      //   );
      // });

      // test('sets id if not provided', () {
      //   expect(
      //     createSubject(id: null).id,
      //     isNotEmpty,
      //   );
      // });
    // });

    // test('supports value equality', () {
      // expect(
      //   createSubject(),
      //   equals(createSubject()),
      // );
    // });

    // test('props are correct', () {
      // expect(
      //   createSubject().props,
      //   equals([
      //     '1', // id
      //     [const MarkerLatLng(1.23, 3.45)], // mapPoints
      //     'normal', // beanType
      //   ]),
      // );
    // });

    // group('copyWith', () {
    //   test('returns the same object if not arguments are provided', () {
    //     expect(
    //       createSubject().copyWith(),
    //       equals(createSubject()),
    //     );
    //   });

    //   test('retains the old value for every parameter if null is provided', () {
    //     expect(
    //       createSubject().copyWith(),
    //       equals(createSubject()),
    //     );
    //   });

    //   test('replaces every non-null parameter', () {
    //     expect(
    //       createSubject().copyWith(
    //         id: '2',
    //         mapPoints: [const MarkerLatLng(1.23, 2.34)],
    //         cropType: const CropType(),
    //       ),
    //       equals(
    //         createSubject(
    //           id: '2',
    //           mapPoints: [const MarkerLatLng(1.23, 2.34)],
    //           beanType: 'newBean',
    //         ),
    //       ),
    //     );
    //   });
    // });

    // group('fromJson', () {
    //   test('works correctly', () {
    //     expect(
    //       Field.fromJson(const <String, dynamic>{
    //         'id': '1',
    //         'mapPoints': [
    //           {'latitude': 1.23, 'longitude': 3.45}
    //         ],
    //         'beanType': 'normal',
    //       }),
    //       equals(createSubject()),
    //     );
    //   });
    // });

    // group('toJson', () {
    //   test('works correctly', () {
    //     expect(
    //       createSubject().toJson(),
    //       equals(<String, dynamic>{
    //         'id': '1',
    //         'mapPoints': const [
    //           {'latitude': 1.23, 'longitude': 3.45}
    //         ],
    //         'beanType': 'normal',
    //       }),
    //     );
    //   });
    // });
//   });
// }
