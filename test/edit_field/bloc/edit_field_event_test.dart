// import 'package:fields_api/fields_api.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:root_gorge/edit_field/edit_field.dart';

// void main() {
//   group(
//     'EditFieldEvent',
//     () {
//       const mockMapPoint = MarkerLatLng(1.23, 4.56);
//       final mockMapPoints = [mockMapPoint];

//       group('EditFieldMapPointsChanged', () {
//         test('supports value equality', () {
//           expect(
//             EditFieldMapPointsChanged(mockMapPoints),
//             equals(EditFieldMapPointsChanged(mockMapPoints)),
//           );
//         });

//         test('props are correct', () {
//           expect(
//             EditFieldMapPointsChanged(mockMapPoints).props,
//             equals(
//               <Object?>[
//                 [const MarkerLatLng(1.23, 4.56)], // title
//               ],
//             ),
//           );
//         });

//         test(
//           'string override is correct',
//           () {
//             expect(
//               EditFieldMapPointsChanged(mockMapPoints).toString(),
//               equals('EditFieldMapPointsChanged'),
//             );
//           },
//         );
//       });

//       group('EditFieldBeanTypeChanged', () {
//         test('supports value equality', () {
//           expect(
//             const EditFieldBeanTypeChanged('bean a'),
//             equals(const EditFieldBeanTypeChanged('bean a')),
//           );
//         });

//         test('props are correct', () {
//           expect(
//             const EditFieldBeanTypeChanged('bean a').props,
//             equals(
//               <Object?>[
//                 'bean a', // title
//               ],
//             ),
//           );
//         });

//         test(
//           'string override is correct',
//           () {
//             expect(
//               const EditFieldBeanTypeChanged('bean A').toString(),
//               equals('EditFieldBeanTypeChanged'),
//             );
//           },
//         );
//       });

//       group('EditFieldSubmitted', () {
//         test('supports value equality', () {
//           expect(
//             EditFieldSubmitted(),
//             equals(EditFieldSubmitted()),
//           );
//         });

//         test('props are correct', () {
//           expect(
//             EditFieldSubmitted().props,
//             equals(
//               <Object?>[],
//             ),
//           );
//         });

//         test(
//           'string override is correct',
//           () {
//             expect(
//               EditFieldSubmitted().toString(),
//               equals('EditFieldSubmitted'),
//             );
//           },
//         );
//       });
//     },
//   );
// }
