import 'dart:async';
import 'dart:convert';

import 'package:clock/clock.dart';
import 'package:crypto_keys/crypto_keys.dart';
import 'package:http/http.dart' as http;
import 'package:jose/jose.dart';
import 'package:x509/x509.dart';

/// CODE SALVAGED FROM
/// https://github.com/appsup-dart/firebase_admin/blob/a1dcabe3e2e2cc400f31947ceff7d4c8eb7aeadb/lib/src/auth/credential.dart
///
/// Copyright (c) 2020, Rik Bellens.
/// All rights reserved.
class Certificate {
  final String projectId;
  final JsonWebKey privateKey;
  final String clientEmail;

  Certificate._({this.projectId, this.privateKey, this.clientEmail}) {
    if (privateKey == null) {
      throw Exception('Invalid Credentials: Certificate object must contain a string "private_key" property.');
    } else if (clientEmail == null) {
      throw Exception('Invalid Credentials: Certificate object must contain a string "client_email" property.');
    }
  }

  factory Certificate._fromJson(Map<String, dynamic> json) {
    if (json == null) {
      throw Exception(
        'Invalid Credentials: Certificate object must be an object.',
      );
    }

    var privateKey = json['private_key'];
    if (privateKey is! String) privateKey = null;
    var clientEmail = json['client_email'];
    if (clientEmail is! String) clientEmail = null;

    var v = parsePem(privateKey).first;
    var keyPair = (v is PrivateKeyInfo) ? v.keyPair : v as KeyPair;
    var pKey = keyPair.privateKey as RsaPrivateKey;

    String _bytesToBase64(List<int> bytes) {
      return base64Url.encode(bytes).replaceAll('=', '');
    }

    String _intToBase64(BigInt v) {
      return _bytesToBase64(v
          .toRadixString(16)
          .replaceAllMapped(RegExp('[0-9a-f]{2}'), (m) => '${m.group(0)},')
          .split(',')
          .where((v) => v.isNotEmpty)
          .map((v) => int.parse(v, radix: 16))
          .toList());
    }

    var k = JsonWebKey.fromJson({
      'kty': 'RSA',
      'n': _intToBase64(pKey.modulus),
      'd': _intToBase64(pKey.privateExponent),
      'p': _intToBase64(pKey.firstPrimeFactor),
      'q': _intToBase64(pKey.secondPrimeFactor),
      'alg': 'RS256',
      'kid': json['private_key_id']
    });

    return Certificate._(projectId: json['project_id'], privateKey: k, clientEmail: clientEmail);
  }
}

/// Implementation of Credential that uses a service account certificate.
class ServiceAccountCredential {
  final Certificate certificate;
  final http.Client httpClient = http.Client();

  ServiceAccountCredential(Map<String, dynamic> map) : certificate = Certificate._fromJson(map);

  Future<AccessToken> getAccessToken() async {
    final token = _createAuthJwt();
    final postData = 'grant_type=urn%3Aietf%3Aparams%3Aoauth%3A'
        'grant-type%3Ajwt-bearer&assertion=$token';
    final request = http.Request('POST', Uri.parse('https://accounts.google.com/o/oauth2/token'))
      ..headers.addAll({
        'Content-Type': 'application/x-www-form-urlencoded',
      })
      ..body = postData;

    return _requestAccessToken(httpClient, request);
  }

  /// Obtain a OAuth2 token by making a remote service call.
  Future<AccessToken> _requestAccessToken(http.Client client, http.Request request) async {
    var resp = await http.Response.fromStream(await client.send(request));

    var data = json.decode(resp.body);
    if (resp.statusCode < 300) {
      var token = AccessToken.fromJson(data);
      if (token.expirationTime == null || token.accessToken == null) {
        throw Exception(
          'Invalid Credentials: Unexpected response while fetching access token: ${json.encode(data)}',
        );
      }
      return token;
    }
    throw Exception(
      'Invalid Credentials: Invalid access token generated: "${json.encode(data)}". Valid access '
      'tokens must be an object with the "expires_in" (number) and "access_token" '
      '(string) properties.',
    );
  }

  String _createAuthJwt() {
    final claims = {
      'scope': [
        'https://www.googleapis.com/auth/cloud-platform',
        'https://www.googleapis.com/auth/firebase.database',
        'https://www.googleapis.com/auth/firebase.messaging',
        'https://www.googleapis.com/auth/identitytoolkit',
        'https://www.googleapis.com/auth/userinfo.email',
      ].join(' '),
      'aud': 'https://accounts.google.com/o/oauth2/token',
      'iss': certificate.clientEmail,
      'iat': clock.now().millisecondsSinceEpoch ~/ 1000,
      'exp': clock.now().add(Duration(hours: 1)).millisecondsSinceEpoch ~/ 1000
    };

    var builder = JsonWebSignatureBuilder()
      ..jsonContent = claims
      ..addRecipient(certificate.privateKey, algorithm: 'RS256');

    return builder.build().toCompactSerialization();
  }
}

/// Google OAuth2 access token object used to authenticate with Firebase
/// services.
class AccessToken {
  final String accessToken;

  final DateTime expirationTime;

  AccessToken.fromJson(Map<String, dynamic> json) : this(json['access_token'], Duration(seconds: json['expires_in']));

  AccessToken(this.accessToken, Duration expiresIn) : expirationTime = expiresIn == null ? null : clock.now().add(expiresIn);

  Map<String, dynamic> toJson() => {'accessToken': accessToken, 'expirationTime': expirationTime?.toIso8601String()};
}
