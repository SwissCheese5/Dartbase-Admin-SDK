import 'dart:convert';

import 'package:http/http.dart' as http;

import '../base/firebase.dart';
import 'message.dart';

/// FCM Option defined here: https://firebase.google.com/docs/cloud-messaging/send-message#rest
/// Don't know why you should overwrite these settings but you can.
class FCMConfig {
  static const scheme = 'https';
  static const host = 'fcm.googleapis.com';
  static const method = 'POST';
  static const bool keepAlive = false;
  final headers = <String, String>{};

  Firebase? firebase;

  FCMConfig({Firebase? firebase}) {
    this.firebase = firebase ?? Firebase.instance;
  }

  String get path => '/v1/projects/${firebase!.projectId}/messages:send';
}

class FCM {
  /* Singleton instance */
  static FCM? _instance;

  static bool get initialized => _instance != null;

  static FCM initialize({Firebase? firebase, FCMConfig? fcmConfig}) {
    assert(!initialized,
        'FCM global instance is already initialized. Do not call this twice or create a local instance via FCM()');

    _instance = FCM(
        firebase: firebase ?? Firebase.instance,
        fcmConfig: fcmConfig ?? FCMConfig(firebase: firebase));
    return _instance!;
  }

  static FCM get instance {
    assert(initialized,
        "FCM hasn't been initialized. Call Firestore.initialize() before using this global instance. Alternatively, create a local instance via FCM() and use that.");

    return _instance!;
  }

  /* Instance interface */
  final Firebase? firebase;
  FCMConfig? fcmConfig;

  FCM({this.firebase, this.fcmConfig})
      : assert(firebase != null || Firebase.initialized,
            'Firebase global instance not initialized, run Firebase.initialize().\nAlternatively, provide a local instance via FCM.initialize(firebase: <firebase instance>)') {
    fcmConfig ??= FCMConfig(firebase: firebase ?? Firebase.instance);
  }

  /// https://firebase.google.com/docs/cloud-messaging/send-message#send-messages-to-specific-devices
  ///
  /// Throws a V1FcmError if the requests fails or server replies an error.
  ///
  /// Returns an ID string in format projects/{project_id}/messages/{message_id}
  /// if the request is successful. It uniquely identifies the message.
  /// ID string example: "projects/myproject-b5ae1/messages/0:1500415314455276%31bd1c9631bd1c96"
  Future<String> send(Message message) async {
    var request = http.Request(
        FCMConfig.method,
        Uri(
          scheme: FCMConfig.scheme,
          host: FCMConfig.host,
          path: fcmConfig!.path,
        ));
    request.body = json.encode({'message': message.toJson()});

    var response = await firebase!.client!.send(request);
    var responseContent = await response.stream.bytesToString();
    if (response.statusCode >= 400) {
      throw FcmError(responseContent);
    }

    var responseMessage = Response.fromJson(json.decode(responseContent));
    return responseMessage.name!;
  }
}
