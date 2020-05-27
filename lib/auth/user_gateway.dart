import 'dart:convert';

import 'package:firedart/auth/client.dart';

class UserGateway {
  final AdminClient client;
  final String projectId;

  UserGateway(this.projectId, this.client);

  Future<void> requestEmailVerification() => _post('sendOobCode', {'requestType': 'VERIFY_EMAIL'});

  Future<User> getUserById({String uid}) async {
    var map = await _postProject('lookup', {'localId': uid});
    return User.fromMap(map['users'][0]);
  }

  Future<void> changePassword(String password) async {
    await _post('update', {
      'password': password,
    });
  }

  Future<void> updateProfile(String displayName, String photoUrl) async {
    await _post('update', {
      if (displayName != null) 'displayName': displayName,
      if (photoUrl != null) 'photoUrl': photoUrl,
    });
  }

  Future<void> deleteAccount() async {
    await _post('delete', {});
  }

  Future<Map<String, dynamic>> _postProject<T>(String method, Map<String, dynamic> body) async {
    var requestUrl = 'https://identitytoolkit.googleapis.com/v1/projects/$projectId/accounts:$method';

    var response = await client.post(requestUrl, body: body).catchError((error) => print(error));

    return json.decode(response.body);
  }

  Future<Map<String, dynamic>> _post<T>(String method, Map<String, dynamic> body) async {
    var requestUrl = 'https://identitytoolkit.googleapis.com/v1/accounts:$method';

    var response = await client.post(requestUrl, body: body).catchError((error) => print(error));

    return json.decode(response.body);
  }
}

class User {
  final String id;
  final String email;
  final bool emailVerified;
  final String displayName;
  final String photoUrl;
  final String phoneNumber;
  final String passwordHash;
  final List<ProviderUserInfoObject> providerUserInfo;

  // Whether the account is authenticated by the developer.
  final bool customAuth;

  // Google returns these values as strings, so we convert them to DateTime for ease of use
  final DateTime validSince;
  final DateTime lastLoginAt;
  final DateTime createdAt;

  // Google returns this one as a double.
  final DateTime passwordUpdatedAt;

  User.fromMap(Map<String, dynamic> map)
      : id = map['localId'],
        displayName = map['displayName'],
        photoUrl = map['photoUrl'],
        email = map['email'],
        emailVerified = map['emailVerified'],
        phoneNumber = map['phoneNumber'],
        validSince =
            map['validSince'] == null ? null : DateTime.fromMillisecondsSinceEpoch(int.parse(map['validSince']) * 1000),
        passwordHash = map['passwordHash'],
        passwordUpdatedAt = map['passwordUpdatedAt'] == null
            ? null
            : DateTime.fromMillisecondsSinceEpoch((map['passwordUpdatedAt'] * 1000).toInt()),
        createdAt =
            !map.containsKey('createdAt') ? null : DateTime.fromMillisecondsSinceEpoch(int.parse(map['createdAt']) * 1000),
        lastLoginAt = !map.containsKey('lastLoginAt')
            ? null
            : DateTime.fromMillisecondsSinceEpoch(int.parse(map['lastLoginAt']) * 1000),
        customAuth = map.containsKey('customAuth') ? map['customAuth'] : null,
        providerUserInfo = !map.containsKey('providerUserInfo')
            ? null
            : List<ProviderUserInfoObject>.from(
                map['providerUserInfo'].map((userInfoObj) => ProviderUserInfoObject.fromMap(userInfoObj)).toList());

  Map<String, dynamic> toMap() => {
        'localId': id,
        'displayName': displayName,
        'photoUrl': photoUrl,
        'email': email,
        'emailVerified': emailVerified,
        'phoneNumber': phoneNumber,
        'passwordHash': passwordHash,
        'validSince': validSince?.toIso8601String(),
        'passwordUpdatedAt': passwordUpdatedAt?.millisecondsSinceEpoch,
        'createdAt': createdAt?.toIso8601String(),
        'lastLoginAt': lastLoginAt?.toIso8601String(),
        'customAuth': customAuth,
        'providerUserInfo': providerUserInfo?.map((userInfoObj) => userInfoObj.toMap())?.toList()
      };

  @override
  String toString() => jsonEncode(toMap());
}

class ProviderUserInfoObject {
  final String providerId;
  final String displayName;
  final String photoUrl;
  final String federatedId;
  final String email;
  final String rawId;
  final String screenName;

  ProviderUserInfoObject.fromMap(Map<String, dynamic> map)
      : providerId = map['providerId'],
        displayName = map['displayName'],
        photoUrl = map['photoUrl'],
        email = map['email'],
        federatedId = map['federatedId'],
        rawId = map['rawId'],
        screenName = map['screenName'];

  Map<String, dynamic> toMap() => {
        'providerId': providerId,
        'displayName': displayName,
        'photoUrl': photoUrl,
        'email': email,
        'federatedId': federatedId,
        'rawId': rawId,
        'screenName': screenName,
      };

  @override
  String toString() => toMap().toString();
}
