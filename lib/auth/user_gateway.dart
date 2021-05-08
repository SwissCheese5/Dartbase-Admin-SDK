import 'dart:convert';

import 'package:dartbase_admin/base/exceptions.dart';
import 'package:dartbase_admin/base/firebase.dart';

import 'user_record.dart';

class UserGateway {
  final Firebase firebase;

  UserGateway(this.firebase);

  Future<UserRecord> getUserById(String uid) async {
    var map = await _post('lookup', {'localId': uid});
    if (!map.containsKey('users')) {
      throw Exception('User not found with id [$uid]');
    }
    return UserRecord.fromJson(map['users'][0]);
  }

  Future<Map<String, dynamic>> _post<T>(
      String method, Map<String, dynamic> body) async {
    var requestUrl = Uri.parse(
        'https://identitytoolkit.googleapis.com/v1/projects/${firebase.projectId}/accounts:$method');

    var response = await firebase.client!.post(requestUrl, body: body);

    if (response.statusCode != 200) {
      throw AuthException(response.body);
    }

    return json.decode(response.body);
  }
}
