import 'package:dartbase_admin/auth/service_account/service_account.dart';
import 'package:http/http.dart' as http;

class AdminClient extends http.BaseClient {
  final http.Client? _client;
  late final ServiceAccount? _serviceAccount;
  String? token;
  DateTime? lastDate;

  AdminClient(this._client, this._serviceAccount);

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    if (token == null) {
      /// Generate a fresh token
      var tokenData = await _serviceAccount!.generateAdminAccessToken();
      token = tokenData['access_token'];
      lastDate = DateTime.now().add(Duration(seconds: tokenData['expires_in']));
    } else {
      /// Generate a new token after the current one expires.
      if (lastDate!.compareTo(DateTime.now()) <= 0) {
        var tokenData = await _serviceAccount!.generateAdminAccessToken();
        token = tokenData['access_token'];
        lastDate =
            DateTime.now().add(Duration(seconds: tokenData['expires_in']));
      }
    }

    request.headers['Authorization'] = 'Bearer $token';

    print('${request.headers['Authorization']}');

    return _client!.send(request);
  }
}
