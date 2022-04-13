// import 'package:bloc_test/bloc_test.dart';
// import 'package:field_google_map/field_google_map.dart';
// import 'package:fields_api/fields_api.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockingjay/mockingjay.dart';
// import 'package:root_gorge/edit_field/edit_field.dart';
// import 'package:google_maps/google_maps.dart' as gmaps;

// import '../../helpers/helpers.dart';

// class MockEditFieldBloc extends MockBloc<EditFieldEvent, EditFieldState>
//     implements EditFieldBloc {}

// void main() {
//   final mockField = Field(
//     id: '1',
//     mapPoints: const [MarkerLatLng(1.23, 4.56)],
//     beanType: 'bean type 1',
//   );

//   late MockNavigator navigator;
//   late EditFieldBloc editFieldBloc;

//   setUp(() {
//     navigator = MockNavigator();
//     when(() => navigator.push(any())).thenAnswer((_) async => null);

//     editFieldBloc = MockEditFieldBloc();
//     when(() => editFieldBloc.state).thenReturn(
//       EditFieldState(
//         mapPoints: mockField.mapPoints,
//         beanType: mockField.beanType,
//       ),
//     );
//   });

//   group('EditFieldPage', () {
//     Widget buildSubject() {
//       return MockNavigatorProvider(
//         navigator: navigator,
//         child: BlocProvider.value(
//           value: editFieldBloc,
//           child: const EditFieldPage(),
//         ),
//       );
//     }

//     testWidgets('adds item to the cart', (tester) async {
//       when(() => editFieldBloc.state).thenReturn(const EditFieldState());

//       await tester.pumpWidget(
//         MaterialApp(
//           home: BlocProvider.value(
//             value: editFieldBloc,
//             child: const EditFieldView(),
//           ),
//         ),
//       );

//       await tester.tap(find.byKey(const Key('edit-field-page-field-map')));

//       await tester.pumpAndSettle();

//       expect(editFieldBloc.state.mapPoints.length, 3);
//     });

//     // testWidgets('tapping increment button invokes increment', (tester) async {
//     //   when(() => editFieldBloc.state).thenReturn(
//     //     const EditFieldState(mapPoints: [MarkerLatLng(1.23, 23.4)]),
//     //   );

//     //   when(() => EditFieldMapPointsChanged).thenReturn(
//     //     EditFieldState(
//     //       mapPoints: [MarkerLatLng(1.23, 23.4)],
//     //       beanType: 'bean type 1',
//     //     ),
//     //   );

//     //   await tester.pumpWidget(
//     //     MaterialApp(
//     //       home: BlocProvider.value(
//     //         value: editFieldBloc,
//     //         child: const EditFieldView(),
//     //       ),
//     //     ),
//     //   );
//     //   await tester.tap(find.byKey(const Key('edit-field-page-field-map')));
//     //   verify(() => EditFieldMapPointsChanged).called(1);
//     // });

//     group('route', () {
//       testWidgets('renders EditFieldPage', (tester) async {
//         await tester.pumpRoute(EditFieldPage.route());
//         expect(find.byType(EditFieldPage), findsOneWidget);
//       });
//     });

//     testWidgets(
//       'pops when a field is saved successfully',
//       (tester) async {
//         whenListen<EditFieldState>(
//           editFieldBloc,
//           Stream.fromIterable(const [
//             EditFieldState(),
//             EditFieldState(
//               status: EditFieldStatus.success,
//             ),
//           ]),
//         );
//         await tester.pumpApp(buildSubject());

//         verify(() => navigator.pop(any<dynamic>())).called(1);
//       },
//     );

//     testWidgets(
//         'adds [EditFieldSubmitted] '
//         'to [EditFieldBloc] '
//         'when tapped', (tester) async {
//       await tester.pumpApp(buildSubject());
//       await tester.tap(find.byType(FloatingActionButton));

//       verify(() => editFieldBloc.add(EditFieldSubmitted())).called(1);
//     });
//   });

//   group('EditFieldView', () {
//     Widget buildSubject() {
//       return MockNavigatorProvider(
//         navigator: navigator,
//         child: BlocProvider.value(
//           value: editFieldBloc,
//           child: const EditFieldView(),
//         ),
//       );
//     }
//   });
// }
