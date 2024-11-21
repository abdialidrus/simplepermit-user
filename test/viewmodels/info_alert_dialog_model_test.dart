import 'package:flutter_test/flutter_test.dart';
import 'package:stacked_permit_user_app/app/app.locator.dart';

import '../helpers/test_helpers.dart';

void main() {
  group('InfoAlertDialogModel Tests -', () {
    setUp(() => registerServices());
    tearDown(() => locator.reset());
  });
}
