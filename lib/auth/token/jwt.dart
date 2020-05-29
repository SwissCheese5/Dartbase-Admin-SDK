import 'dart:convert';

import 'package:firedart/auth/firebase_auth.dart';
import 'package:firedart/firedart.dart';

import 'rsa.dart';

class Jwt {
  static final _rsaMap = <String, Rsa>{};

  final List<String> _tokenParts;
  final String token;

  // TODO Improve this when dart gets lazy field instantiation
  _Header _h;
  _Payload _p;

  _Header get _header => _h ??= _Header(_tokenParts[0]);

  _Payload get _payload => _p ??= _Payload(_tokenParts[1]);

  String get userId => _payload.subject;

  Jwt(this.token) : _tokenParts = token.split(' ').last.split('.');

  // If check revoked is true, we get user information from Google and check if the remote token we got is
  // not expired compared to the one we got offered here.
  Future<void> validate(Map<String, String> certificates,
      {FirebaseAuth authInstance, bool enforceEmailVerification = false, bool checkRevoked = false}) async {
    var auth = authInstance ?? FirebaseAuth.instance;

    if (checkRevoked) {
      var user = await auth.getUserById(_payload.subject);
      if (user.tokensValidAfterTime != null) {
        final authTimeUtc = DateTime.fromMillisecondsSinceEpoch(_payload.issueTime);
        final validSinceUtc = user.tokensValidAfterTime;
        if (authTimeUtc.isBefore(validSinceUtc)) {
          throw RevokedTokenException();
        }
      }
    }

    var now = (DateTime.now().toUtc().millisecondsSinceEpoch / 1000).floor();

    if (_payload.authenticationTime >= now) {
      throw Exception('Authentication time must be in the past');
    }
    if (_payload.issueTime >= now) {
      throw Exception('Issue time must be in the past');
    }
    if (_payload.expirationTime <= now) {
      throw Exception('Token expired');
    }

    if (_payload.audience != auth.projectId) {
      throw Exception('Unexpected audience: ${_payload.audience}');
    }
    if (_payload.issuer != 'https://securetoken.google.com/${auth.projectId}') {
      throw Exception('Unexpected issuer: ${_payload.issuer}');
    }

    if (enforceEmailVerification && !_payload.isEmailVerified) {
      throw EmailVerificationException();
    }

    // Validate header
    if (_header.algorithm != 'RS256') {
      throw Exception('Unrecognized algorithm: ${_header.algorithm}');
    }

    // Validate signature
    if (!certificates.containsKey(_header.certificateId)) {
      throw Exception('Unrecognized certificate id: ${_header.certificateId}');
    }

    _rsaMap[_header.certificateId] ??= Rsa.fromCertificate(certificates[_header.certificateId]);
    var rsa = _rsaMap[_header.certificateId];
    var verified = rsa.verify('${_tokenParts[0]}.${_tokenParts[1]}', _tokenParts[2]);

    if (!verified) {
      throw Exception('Could not verify the token against its signature');
    }
  }
}

class _Header {
  final Map<String, dynamic> data;

  String get algorithm => data['alg'];

  String get certificateId => data['kid'];

  _Header(String tokenPart) : data = _parse(tokenPart);
}

class _Payload {
  final Map<String, dynamic> data;

  int get authenticationTime => data['auth_time'];

  int get issueTime => data['iat'];

  int get expirationTime => data['exp'];

  String get audience => data['aud'];

  String get issuer => data['iss'];

  String get subject => data['sub'];

  bool get isEmailVerified => data['email_verified'];

  _Payload(String tokenPart) : data = _parse(tokenPart);
}

class RevokedTokenException implements Exception {
  final message = 'The token has been revoked';
}

class EmailVerificationException implements Exception {
  final message = 'Email has not been verified';
}

Map<String, dynamic> _parse(String tokenPart) => jsonDecode(utf8.decode(relaxedBase64Decode(tokenPart)));
