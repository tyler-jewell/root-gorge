// import 'package:bloc_test/bloc_test.dart';
// import 'package:fields_api/fields_api.dart';
// import 'package:fields_repository/fields_repository.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mocktail/mocktail.dart';
// import 'package:root_gorge/edit_field/edit_field.dart';

// class MockFieldsRepository extends Mock implements FieldsRepository {}

// class FakeField extends Fake implements Field {}

// void main() {
//   group(
//     'EditFieldBloc',
//     () {
//       late FieldsRepository fieldsRepository;

//       setUpAll(() {
//         registerFallbackValue(FakeField());
//       });

//       setUp(() {
//         fieldsRepository = MockFieldsRepository();
//       });

//       EditFieldBloc buildBloc() {
//         return EditFieldBloc(fieldsRepository: fieldsRepository);
//       }

//       group(
//         'constructor',
//         () {
//           test('works properly', () => expect(buildBloc, returnsNormally));

//           test('has correct initial state', () {
//             expect(
//               buildBloc().state,
//               equals(const EditFieldState()),
//             );
//           });
//         },
//       );

//       group(
//         'EditFieldMapPointsChanged',
//         () {
//           blocTest<EditFieldBloc, EditFieldState>(
//             'emits [state] when map points changed',
//             build: buildBloc,
//             act: (bloc) => bloc.add(
//               const EditFieldMapPointsChanged(
//                 [MarkerLatLng(1.23, 2.34)],
//               ),
//             ),
//             expect: () => const [
//               EditFieldState(
//                 mapPoints: [MarkerLatLng(1.23, 2.34)],
//               ),
//             ],
//           );
//         },
//       );

//       group(
//         'EditFieldBeanTypeChanged',
//         () {
//           blocTest<EditFieldBloc, EditFieldState>(
//             'emits [state] when bean type changed',
//             build: buildBloc,
//             act: (bloc) => bloc.add(
//               const EditFieldBeanTypeChanged('new bean type'),
//             ),
//             expect: () => const [
//               EditFieldState(beanType: 'new bean type'),
//             ],
//           );
//         },
//       );

//       group(
//         'EditFieldSubmitted',
//         () {
//           blocTest<EditFieldBloc, EditFieldState>(
//             'emits [state] when new field added',
//             build: buildBloc,
//             setUp: () {
//               when(() => fieldsRepository.saveField(any()))
//                   .thenAnswer((_) async {});
//             },
//             seed: () => const EditFieldState(
//               mapPoints: [MarkerLatLng(1.23, 2.34)],
//               beanType: 'bean type',
//             ),
//             act: (bloc) => bloc.add(EditFieldSubmitted()),
//             expect: () => const [
//               EditFieldState(
//                 status: EditFieldStatus.loading,
//                 beanType: 'bean type',
//                 mapPoints: [MarkerLatLng(1.23, 2.34)],
//               ),
//               EditFieldState(
//                 status: EditFieldStatus.success,
//                 beanType: 'bean type',
//                 mapPoints: [MarkerLatLng(1.23, 2.34)],
//               ),
//             ],
//           );

//           blocTest<EditFieldBloc, EditFieldState>(
//             'emits new state with error if save to repository fails',
//             build: () {
//               when(() => fieldsRepository.saveField(any()))
//                   .thenThrow(Exception('oops'));
//               return buildBloc();
//             },
//             seed: () => const EditFieldState(
//               mapPoints: [MarkerLatLng(1.23, 2.34)],
//               beanType: 'bean type',
//             ),
//             act: (bloc) => bloc.add(EditFieldSubmitted()),
//             expect: () => const [
//               EditFieldState(
//                 status: EditFieldStatus.loading,
//                 beanType: 'bean type',
//                 mapPoints: [MarkerLatLng(1.23, 2.34)],
//               ),
//               EditFieldState(
//                 status: EditFieldStatus.failure,
//                 beanType: 'bean type',
//                 mapPoints: [MarkerLatLng(1.23, 2.34)],
//               ),
//             ],
//           );
//         },
//       );
//     },
//   );
// }
