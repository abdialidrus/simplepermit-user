import 'package:flutter_test/flutter_test.dart';
import 'package:permit_user_app/app/app.locator.dart';

import '../helpers/test_helpers.dart';

void main() {
  group('ApplicationServiceTest -', () {
    setUp(() => registerServices());
    tearDown(() => locator.reset());
  });
}
