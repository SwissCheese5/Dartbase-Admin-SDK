import 'dart:convert';

import 'package:dartbase_admin/base/exceptions.dart';
import 'package:eosdart_ecc/eosdart_ecc.dart';

import '../base/firebase.dart';

/// This class is to enable server-side reward-ad verification.
/// https://developers.google.com/admob/android/rewarded-video-ssv#manual_verification_of_rewarded_video_ssv
class Admob {
  /* Singleton instance */
  static Admob? _instance;

  static bool get initialized => _instance != null;

  static Future<Admob> initialize({Firebase? firebase}) async {
    assert(!initialized,
        'Admob global instance is already initialized. Do not call this twice or create a local instance via Admob()');

    _instance = Admob(firebase: firebase ?? Firebase.instance);
    await _instance!.init();

    return _instance!;
  }

  static Admob get instance {
    assert(initialized,
        "Admob hasn't been initialized. Call Admob.initialize() before using this global instance. Alternatively, create a local instance via Admob() and use that.");

    return _instance!;
  }

  /* Instance interface */
  final Firebase? firebase;
  Map<int, String> admobPublicKeys = <int, String>{};

  Admob({this.firebase})
      : assert(firebase != null || Firebase.initialized,
            'Firebase global instance not initialized, run Firebase.initialize().\nAlternatively, provide a local instance via Firestore.initialize(firebase: <firebase instance>)');

  Future<void> init() async {
    var response = await firebase!.client!.get(
        Uri.parse('https://www.gstatic.com/admob/reward/verifier-keys.json'));
    if (response.statusCode == 200) {
      try {
        Map<String, dynamic> admobPublicKeys = jsonDecode(response.body);
        for (var keyMap in admobPublicKeys['keys'] as List) {
          this.admobPublicKeys[keyMap['keyId']] = keyMap['base64'];
        }
      } catch (error) {
        throw InitializationException("Couldn't parse admob public keys.");
      }
    } else {
      throw InitializationException(
          "Couldn't get admob public keys. Check your network connection. Network response:\nCODE: ${response.statusCode}\nMessage: ${response.reasonPhrase}");
    }
  }

  /// You can get the parameters by passing the Admob Rewards Callback URL that google calls to your server
  /// You can see the list of parameters here:
  /// https://developers.google.com/admob/android/rewarded-video-ssv#ssv_callback_parameters
  /// You just need to pass the URL as is to this method.
  ///
  /// Key Point: Content from the SSV callback should not be modified in any way (including keeping the order of query parameters).
  bool verifyRewardAd(String callbackURL) {
    var uri = Uri.parse(callbackURL);
    var params = uri.queryParameters;

    if (!params.containsKey('signature')) {
      throw GeneralSecurityException('Needs a signature query parameter.');
    }
    if (!params.containsKey('key_id')) {
      throw GeneralSecurityException('Needs a key_id query parameter.');
    }

    var keyId = int.parse(params['key_id']!);
    var signature = params['signature'];
    var dataMap = Map<String, String>.from(params)
      ..remove('key_id')
      ..remove('signature');
    var data = Uri(queryParameters: dataMap).query;

    if (admobPublicKeys.containsKey(keyId)) {
      var base64 = base64Decode(admobPublicKeys[keyId]!);
      var privateKey = EOSPrivateKey.fromBuffer(base64);
      var publicKey = privateKey.toEOSPublicKey();
      var signer = privateKey.signString(signature);

      return signer.verify(data, publicKey);
    } else {
      throw GeneralSecurityException(
          'Cannot find verifying key with key id: $keyId');
    }
  }
}
