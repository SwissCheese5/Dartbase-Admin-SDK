import 'package:grpc/grpc.dart';

import '../firedart.dart';

class TokenAuthenticator {
  final FirebaseAuth auth;

  TokenAuthenticator._internal(this.auth);

  factory TokenAuthenticator.from(FirebaseAuth auth) {
    return auth != null ? TokenAuthenticator._internal(auth) : null;
  }

  CallOptions get toCallOptions => JwtServiceAccountAuthenticator(auth.serviceAccount.serviceAccountString).toCallOptions;

  Future<Map<String, String>> getMetadata() async {
    var jwt = JwtServiceAccountAuthenticator(auth.serviceAccount.serviceAccountString);

    var metadata = <String, String>{};
    await jwt.authenticate(metadata, auth.projectId);

    return metadata;
  }
}
