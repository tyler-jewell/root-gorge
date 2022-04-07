// import 'dart:convert';

// import 'package:fields_api/fields_api.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:firestore_fields_api/firestore_fields_api.dart';
// import 'package:mocktail/mocktail.dart';

// class MockSharedPreferences extends Mock implements SharedPreferences {}

// void main() {
//   group('LocalStorageFieldsApi', () {
//     late SharedPreferences plugin;

//     final fields = [
//       Field(
//         id: '1',
//         mapPoints: const [MarkerLatLng(1.23, 4.56)],
//         beanType: 'bean type 1',
//       ),
//       Field(
//         id: '2',
//         mapPoints: const [MarkerLatLng(1.23, 4.56)],
//         beanType: 'bean type 2',
//       ),
//       Field(
//         id: '3',
//         mapPoints: const [MarkerLatLng(1.23, 4.56)],
//         beanType: 'bean type 3',
//       ),
//     ];

//     setUp(() {
//       plugin = MockSharedPreferences();
//       when(() => plugin.getString(any())).thenReturn(json.encode(fields));
//       when(() => plugin.setString(any(), any())).thenAnswer((_) async => true);
//     });

//     LocalStorageFieldsApi createSubject() {
//       return LocalStorageFieldsApi(
//         plugin: plugin,
//       );
//     }

//     group('constructor', () {
//       test('works properly', () {
//         expect(
//           createSubject,
//           returnsNormally,
//         );
//       });

//       group('initializes the fields stream', () {
//         test('with existing fields if present', () {
//           final subject = createSubject();

//           expect(subject.getFields(), emits(fields));
//           verify(
//             () => plugin.getString(
//               LocalStorageFieldsApi.kFieldsCollectionKey,
//             ),
//           ).called(1);
//         });

//         test('with empty list if no fields present', () {
//           when(() => plugin.getString(any())).thenReturn(null);

//           final subject = createSubject();

//           expect(subject.getFields(), emits(const <Field>[]));
//           verify(
//             () => plugin.getString(
//               LocalStorageFieldsApi.kFieldsCollectionKey,
//             ),
//           ).called(1);
//         });
//       });
//     });

//     test('getfields returns stream of current list fields', () {
//       expect(
//         createSubject().getFields(),
//         emits(fields),
//       );
//     });

//     group('savefield', () {
//       test('saves new fields', () {
//         final newField = Field(
//           id: '4',
//           mapPoints: const [MarkerLatLng(1.23, 4.56)],
//           beanType: 'bean type 4',
//         );

//         final newFields = [...fields, newField];

//         final subject = createSubject();

//         expect(subject.saveField(newField), completes);
//         expect(subject.getFields(), emits(newFields));

//         verify(
//           () => plugin.setString(
//             LocalStorageFieldsApi.kFieldsCollectionKey,
//             json.encode(newFields),
//           ),
//         ).called(1);
//       });

//       test('updates existing fields', () {
//         final updatedField = Field(
//           id: '1',
//           mapPoints: const [MarkerLatLng(1.23, 4.56)],
//           beanType: 'new bean type 1',
//         );
//         final newFields = [updatedField, ...fields.sublist(1)];

//         final subject = createSubject();

//         expect(subject.saveField(updatedField), completes);
//         expect(subject.getFields(), emits(newFields));

//         verify(
//           () => plugin.setString(
//             LocalStorageFieldsApi.kFieldsCollectionKey,
//             json.encode(newFields),
//           ),
//         ).called(1);
//       });
//     });

//     group('deleteField', () {
//       test('deletes existing fields', () {
//         final newFields = fields.sublist(1);

//         final subject = createSubject();

//         expect(subject.deleteField(fields[0].id), completes);
//         expect(subject.getFields(), emits(newFields));

//         verify(
//           () => plugin.setString(
//             LocalStorageFieldsApi.kFieldsCollectionKey,
//             json.encode(newFields),
//           ),
//         ).called(1);
//       });

//       test(
//         'throws fieldNotFoundException if field '
//         'with provided id is not found',
//         () {
//           final subject = createSubject();

//           expect(
//             () => subject.deleteField('non-existing-id'),
//             throwsA(isA<FieldNotFoundException>()),
//           );
//         },
//       );
//     });
//   });
// }
