import 'package:fields_api/src/fields_api.dart';
import 'package:test/test.dart';

class TestFieldsApi extends FieldsApi {
  TestFieldsApi() : super();

  @override
  dynamic noSuchMethod(Invocation invocation) {
    return super.noSuchMethod(invocation);
  }
}

void main() {
  group('FieldsApi', () {
    test('can be constructed', () {
      expect(TestFieldsApi.new, returnsNormally);
    });
  });
}
