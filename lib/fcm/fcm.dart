import 'dart:convert';

import 'package:http/http.dart' as http;

import '../base/client.dart';
import '../base/firebase.dart';
import 'message.dart';

/// FCM Option defined here: https://firebase.google.com/docs/cloud-messaging/send-message#rest
/// Don't know why you should overwrite these settings but you can.
class FCMConfig {
  static const scheme = 'https';
  static const host = 'fcm.googleapis.com';
  static const method = 'POST';
  static const bool keepAlive = false;
  final headers = <String,String>{};
  String project_id;

  FCMConfig(this.project_id);

  String get path => '/v1/projects/$project_id/messages:send';
}

class FCM {
  final Firebase _firebase;
  final FCMConfig _fcmConfig;

  FCM(this._firebase, this._fcmConfig);

  Future<void> init() async {
    var accessToken = await _firebase.serviceAccount.getAccessToken();
    _firebase.client = AdminClient(
        _firebase.httpClient,
        {
          'Content-Type': 'application/json',
          'authorization': 'Bearer ${accessToken.accessToken}',
        });
  }

  http.Request _createRequest(String body) {
    var request = http.Request(FCMConfig.method, Uri(
      scheme: FCMConfig.scheme,
      host: FCMConfig.host,
      path: _fcmConfig.path,
    ));
    request.body = body;
    return request;
  }

  /// https://firebase.google.com/docs/cloud-messaging/send-message#send-messages-to-specific-devices
  ///
  /// Throws a V1FcmError if the requests fails or server replies an error.
  ///
  /// Returns ID string in format projects/{project_id}/messages/{message_id}
  /// if the request is successful.
  /// Example: "projects/myproject-b5ae1/messages/0:1500415314455276%31bd1c9631bd1c96"
  Future<String> send(V1Message message) async {
    var body = json.encode({'message': message.toJson()});
    var request = _createRequest(body);
    var response = await _firebase.client.send(request);
    var responseContent = await response.stream.bytesToString();
    if (response.statusCode >= 400) {
      throw V1FcmError(responseContent);
    }

    var responseMessage = V1Response.fromJson(json.decode(responseContent));
    return responseMessage.name;
  }
}
