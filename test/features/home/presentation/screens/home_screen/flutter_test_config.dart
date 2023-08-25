import 'dart:async';

import '../../../../../utils/golden_test_config.dart';

Future<void> testExecutable(FutureOr<void> Function() testMain) async {
  await goldenTestConfig();
  await testMain();
}
