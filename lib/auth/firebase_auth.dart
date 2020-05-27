import 'package:firedart/auth/client.dart';
import 'package:firedart/auth/service_account/service_account.dart';
import 'package:firedart/auth/user_gateway.dart';
import 'package:http/http.dart' as http;

/// For service accounts, you can use ServiceAccount.fromJson(String) or ServiceAccount.fromEnvironmentVariable(optional String)
/// Using the environment variable implementation will crash if you are on a platform that dart:io does not support.
class FirebaseAuth {
  /* Singleton interface */
  static FirebaseAuth _instance;

  static Future<FirebaseAuth> initialize(String projectId, ServiceAccount serviceAccount) async {
    if (_instance != null) {
      throw Exception('FirebaseAuth instance was already initialized');
    }
    _instance = FirebaseAuth(projectId, serviceAccount);
    await _instance.init();
    return _instance;
  }

  static FirebaseAuth get instance {
    if (_instance == null) {
      throw Exception("FirebaseAuth hasn't been initialized. Please call FirebaseAuth.initialize() before using it.");
    }
    return _instance;
  }

  /* Instance interface */
  final String projectId;
  final ServiceAccount serviceAccount;

  http.Client httpClient;

  UserGateway _userGateway;

  FirebaseAuth(this.projectId, this.serviceAccount, {this.httpClient}) {
    httpClient ??= http.Client();
  }

  Future<void> init() async {
    var accessToken = await serviceAccount.getAccessToken();
    print(accessToken);
    var adminClient = AdminClient(httpClient, {'authorization': 'Bearer ${accessToken.accessToken}'});

    _userGateway = UserGateway(projectId, adminClient);
  }

  Future<void> requestEmailVerification() => _userGateway.requestEmailVerification();

  Future<void> changePassword(String password) => _userGateway.changePassword(password);

  Future<User> getUserById({String uid}) => _userGateway.getUserById(uid: uid);

  Future<void> updateProfile({String displayName, String photoUrl}) => _userGateway.updateProfile(displayName, photoUrl);

  Future<void> deleteAccount() async {
    await _userGateway.deleteAccount();
  }
}
