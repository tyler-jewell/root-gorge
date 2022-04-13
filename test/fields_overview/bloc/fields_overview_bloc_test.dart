// import 'package:bloc_test/bloc_test.dart';
// import 'package:fields_api/fields_api.dart';
// import 'package:fields_repository/fields_repository.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mocktail/mocktail.dart';
// import 'package:root_gorge/fields_overview/fields_overview.dart';

// class MockFieldsRepository extends Mock implements FieldsRepository {}

// class FakeField extends Fake implements Field {}

// void main() {
//   final mockfields = [
//     Field(
//       id: '1',
//       mapPoints: const [MarkerLatLng(1.23, 4.56)],
//       beanType: 'bean type 1',
//     ),
//     Field(
//       id: '2',
//       mapPoints: const [MarkerLatLng(7.89, 1.91)],
//       beanType: 'bean type 2',
//     ),
//     Field(
//       id: '3',
//       mapPoints: const [MarkerLatLng(1.45, 4.24)],
//       beanType: 'bean type 3',
//     )
//   ];

//   group(
//     'FieldsOverviewBloc',
//     () {
//       late FieldsRepository fieldsRepository;

//       setUpAll(() {
//         registerFallbackValue(FakeField());
//       });

//       setUp(() {
//         fieldsRepository = MockFieldsRepository();
//         when(
//           () => fieldsRepository.getFields(),
//         ).thenAnswer((_) => Stream.value(mockfields));
//         when(() => 
//fieldsRepository.saveField(any())).thenAnswer((_) async {});
//       });

//       FieldsOverviewBloc buildBloc() {
//         return FieldsOverviewBloc(fieldsRepository: fieldsRepository);
//       }

//       group('constructor', () {
//         test('works properly', () => expect(buildBloc, returnsNormally));

//         test('has correct initial state', () {
//           expect(
//             buildBloc().state,
//             equals(const FieldsOverviewState()),
//           );
//         });
//       });

//       group('FieldsOverviewSubscriptionRequested', () {
//         blocTest<FieldsOverviewBloc, FieldsOverviewState>(
//           'starts listening to repository getFields stream',
//           build: buildBloc,
//           act: (bloc) => bloc.add(const FieldsOverviewSubscriptionRequested()),
//           verify: (_) {
//             verify(() => fieldsRepository.getFields()).called(1);
//           },
//         );

//         blocTest<FieldsOverviewBloc, FieldsOverviewState>(
//           'emits state with updated status and fields '
//           'when repository getfields stream emits new fields',
//           build: buildBloc,
//           act: (bloc) => bloc.add(const FieldsOverviewSubscriptionRequested()),
//           expect: () => [
//             const FieldsOverviewState(
//               status: FieldsOverviewStatus.loading,
//             ),
//             FieldsOverviewState(
//               status: FieldsOverviewStatus.success,
//               fields: mockfields,
//             ),
//           ],
//         );

//         blocTest<FieldsOverviewBloc, FieldsOverviewState>(
//           'emits state with failure status '
//           'when repository getfields stream emits error',
//           setUp: () {
//             when(
//               () => fieldsRepository.getFields(),
//             ).thenAnswer((_) => Stream.error(Exception('oops')));
//           },
//           build: buildBloc,
//           act: (bloc) => bloc.add(const FieldsOverviewSubscriptionRequested()),
//           expect: () => [
//             const FieldsOverviewState(status: FieldsOverviewStatus.loading),
//             const FieldsOverviewState(status: FieldsOverviewStatus.failure),
//           ],
//         );
//       });
//     },
//   );
// }
