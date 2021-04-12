import 'dart:convert';

import 'package:http/http.dart' as http;

import '../firebase_auth.dart';
import 'jwt.dart';

/// Verify a Firebase token
Future<String> verifyToken(String token,
        {FirebaseAuth? firebaseAuth, bool checkRevoked = false}) async =>
    Jwt(token).validate(await _googleCertificates,
        firebaseAuth: firebaseAuth, checkRevoked: checkRevoked);

var _certificateUrl = Uri.parse(
    'https://www.googleapis.com/robot/v1/metadata/x509/securetoken@system.gserviceaccount.com');

Map<String, String>? _googleCertificatesCache;

Future<Map<String, String>> get _googleCertificates async =>
    _googleCertificatesCache ??=
        (jsonDecode((await http.get(_certificateUrl)).body)
                as Map<String, dynamic>)
            .cast<String, String>();
