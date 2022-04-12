// ignore_for_file: prefer_const_constructors
import 'package:fields_api/fields_api.dart';
import 'package:fields_repository/fields_repository.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockfieldsApi extends Mock implements FieldsApi {}

class FakeField extends Fake implements Field {}

void main() {
  group('FieldsRepository', () {
    late FieldsApi api;

    final fields = [
      Field(
        id: '1',
        mapPoints: const [MarkerLatLng(1.23, 2.34)],
        cropType: CropType(),
      ),
      Field(
        id: '2',
        mapPoints: const [MarkerLatLng(1.23, 2.34)],
        cropType: CropType(),
      ),
      Field(
        id: '3',
        mapPoints: const [MarkerLatLng(1.23, 2.34)],
        cropType: CropType(),
      ),
    ];

    setUpAll(() {
      registerFallbackValue(FakeField());
    });

    setUp(() {
      api = MockfieldsApi();
      when(() => api.getFields()).thenAnswer((_) => Stream.value(fields));
      when(() => api.saveField(any())).thenAnswer((_) async {});
      when(() => api.deleteField(any())).thenAnswer((_) async {});
    });

    FieldsRepository createSubject() => FieldsRepository(fieldsApi: api);

    group('constructor', () {
      test('works properly', () {
        expect(
          createSubject,
          returnsNormally,
        );
      });
    });

    group('getfields', () {
      test('makes correct api request', () {
        final subject = createSubject();

        expect(
          subject.getFields(),
          isNot(throwsA(anything)),
        );

        verify(() => api.getFields()).called(1);
      });

      test('returns stream of current list fields', () {
        expect(
          createSubject().getFields(),
          emits(fields),
        );
      });
    });

    group('savefield', () {
      test('makes correct api request', () {
        final newfield = Field(
          id: '4',
          mapPoints: const [MarkerLatLng(1.23, 2.34)],
          cropType: CropType(),
        );

        final subject = createSubject();

        expect(subject.saveField(newfield), completes);

        verify(() => api.saveField(newfield)).called(1);
      });
    });

    group('deletefield', () {
      test('makes correct api request', () {
        final subject = createSubject();

        expect(subject.deleteField(fields[0].id), completes);

        verify(() => api.deleteField(fields[0].id)).called(1);
      });
    });
  });
}
