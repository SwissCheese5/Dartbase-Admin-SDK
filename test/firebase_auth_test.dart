import 'package:firedart/firedart.dart';
import 'package:test/test.dart';

import 'test_config.dart';

Future main() async {
  TokenStore tokenStore;
  FirebaseAuth auth;

  setUpAll(() async {
    tokenStore = VolatileStore();
    auth = FirebaseAuth(projectId, await ServiceAccount.fromFile(serviceAccountPath));
  });
}
