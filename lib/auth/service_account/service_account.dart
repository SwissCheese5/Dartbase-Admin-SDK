import 'dart:convert';

import 'package:firedart/auth/service_account/access_exporter.dart';
import 'package:firedart/auth/service_account/access_token_handler.dart';

class ServiceAccount {
  final String serviceAccountString;

  ServiceAccount.fromJson(this.serviceAccountString);

  ServiceAccount.fromEnvironmentVariable({String environmentVariable = 'GOOGLE_APPLICATION_CREDENTIALS'})
      : serviceAccountString = getIOAccess().getEnvironmentVariable(environmentVariable);

  Future<AccessToken> getAccessToken() async {
    return ServiceAccountCredential(jsonDecode(serviceAccountString)).getAccessToken();
  }

  static Future<ServiceAccount> fromFile(String filePath) async =>
      ServiceAccount.fromJson(await getIOAccess().getStringFromFile(filePath));
}

abstract class AbstractPlatformAccess {
  String getEnvironmentVariable(String environmentVariable);

  Future<String> getStringFromFile(String filePath);
}
