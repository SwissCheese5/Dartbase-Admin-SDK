import 'dart:convert';

import 'package:corsac_jwt/corsac_jwt.dart';
import 'package:dartbase_admin/base/exceptions.dart';
import 'package:http/http.dart' as http;

import '../firebase_auth.dart';

class Jwt {
  final String token;

  Jwt(this.token);

  // Returns subject uid if token is valid. Throws exception otherwise.
  Future<String> validate(Map<String, String> certificates,
      {FirebaseAuth? firebaseAuth, bool checkRevoked = false}) async {
    assert(firebaseAuth != null || FirebaseAuth.initialized,
        "Firebase Auth hasn't been initialized. Call FirebaseAuth.initialize() before using this global instance. Alternatively, create a local instance via FirebaseAuth() and use that.");

    var auth = firebaseAuth ?? FirebaseAuth.instance;

    var decodedToken = JWT.parse(token);

    if (decodedToken.headers['alg'] != 'RS256') {
      throw TokenValidationException(
          'Algorithm is not RS256. alg header returned ${decodedToken.headers['alg']}');
    }

    /// CREATE A VALIDATOR TO MATCH OUR FIREBASE PROJECT
    var validator = JWTValidator()
      ..audience = firebaseAuth!.firebase!.projectId
      ..issuer =
          'https://securetoken.google.com/${firebaseAuth.firebase!.projectId}';

    /// RUN VALIDATION
    var errors = validator.validate(decodedToken);
    if (errors.isNotEmpty) {
      throw TokenValidationException(errors.join('\n'));
    }

    /// GET GOOGLE PUBLIC KEYS
    var response = await http.get(Uri.parse(
        'https://www.googleapis.com/robot/v1/metadata/x509/securetoken@system.gserviceaccount.com'));
    Map<String, dynamic> publicKeys = jsonDecode(response.body);

    /// RUN SIGNATURE VERIFICATION
    if (!publicKeys.containsKey(decodedToken.headers['kid'])) {
      throw TokenValidationException(
          'No matching public keys for kid claim in token.'
          '\nKid claim:'
          '\n     > ${decodedToken.headers['kid']}'
          '\nPublic Keys:'
          '\n     > ${publicKeys.keys.join('\n     > ')}');
    }

    var publicKey = publicKeys[decodedToken.headers['kid']];
    var signer = JWTRsaSha256Signer(publicKey: publicKey);
    var verified = decodedToken.verify(signer);
    if (!verified) {
      throw TokenValidationException(
          'Could not verify token against public key.'
          '\nToken:            ${decodedToken.toString()}'
          '\nPublic Key:       ${decodedToken.headers['kid']}'
          '\nPublic Key Value: $publicKey');
    }

    if (decodedToken.subject?.isEmpty ?? false) {
      throw TokenValidationException('Subject is empty or null.');
    }
    if (decodedToken.subject != null && decodedToken.subject.length > 128) {
      throw TokenValidationException('Subject is larger than 128 characters.');
    }

    /// CHECK IF IT'S REVOKED
    if (checkRevoked) {
      var user = await auth.getUserById(decodedToken.subject);
      if (user.tokensValidAfterTime != null) {
        final authTimeUtc =
            DateTime.fromMillisecondsSinceEpoch(decodedToken.issuedAt * 1000);
        final validSinceUtc = user.tokensValidAfterTime;
        if (authTimeUtc.isBefore(validSinceUtc!)) {
          throw TokenValidationException('Token is revoked');
        }
      }
    }

    return decodedToken.subject;
  }
}
