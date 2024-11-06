// ignore_for_file: prefer_const_constructors
import 'package:permit_api/permit_api.dart';
import 'package:test/test.dart';

class TestPermitApi extends PermitApi {
  TestPermitApi() : super();

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

void main() {
  group('PermitApi', () {
    test('can be constructed', () {
      expect(TestPermitApi.new, returnsNormally);
    });
  });
}
