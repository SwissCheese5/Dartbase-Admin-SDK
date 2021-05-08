import 'package:dartbase_admin/auth/user_gateway.dart';

import '../base/firebase.dart';
import 'token/verify_token.dart';
import 'user_record.dart';

class FirebaseAuth {
  /* Singleton instance */
  static FirebaseAuth? _instance;

  static bool get initialized => _instance != null;

  static FirebaseAuth initialize({Firebase? firebase}) {
    assert(!initialized,
        'Firebase Auth global instance is already initialized. Do not call this twice or create a local instance via FirebaseAuth()');

    _instance = FirebaseAuth(firebase: firebase ?? Firebase.instance);
    return _instance!;
  }

  static FirebaseAuth get instance {
    assert(initialized,
        "Firebase Auth hasn't been initialized. Call FirebaseAuth.initialize() before using this global instance. Alternatively, create a local instance via FirebaseAuth() and use that.");

    return _instance!;
  }

  /* Instance interface */
  final UserGateway _userGateway;
  final Firebase? firebase;

  FirebaseAuth({this.firebase})
      : assert(firebase != null || Firebase.initialized,
            'Firebase global instance not initialized, run Firebase.initialize().\nAlternatively, provide a local instance via Firestore.initialize(firebase: <firebase instance>)'),
        _userGateway = UserGateway(firebase ?? Firebase.instance);

  Future<UserRecord> getUserById(String uid) => _userGateway.getUserById(uid);

  // Returns the uid of the subject if the token is valid. Throws exception otherwise.
  Future<String> verifyIdToken(String token,
      {bool checkRevoked = false}) async {
    var uid = await verifyToken(token,
        firebaseAuth: this, checkRevoked: checkRevoked);
    return uid;
  }
}
