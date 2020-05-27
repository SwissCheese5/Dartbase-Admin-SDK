import 'dart:convert';

import 'package:firedart/auth/token_provider.dart';
import 'package:http/http.dart' as http;

class VerboseClient extends http.BaseClient {
  http.Client _client;

  VerboseClient() {
    _client = http.Client();
  }

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    print('--> ${request.method} ${request.url}');
    print(request.headers);
    print((request as http.Request).body);

    var response = await _client.send(request);
    print('<-- ${response.statusCode} ${response.reasonPhrase} ${response.request.url}');
    var loggedStream = response.stream.map((event) {
      print(utf8.decode(event));
      return event;
    });

    return http.StreamedResponse(
      loggedStream,
      response.statusCode,
      headers: response.headers,
      contentLength: response.contentLength,
      isRedirect: response.isRedirect,
      persistentConnection: response.persistentConnection,
      reasonPhrase: response.reasonPhrase,
      request: response.request,
    );
  }
}

class AdminClient extends http.BaseClient {
  final http.Client client;
  final Map<String, String> metadata;

  AdminClient(this.client, this.metadata);

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    if (!request.headers.containsKey('authorization')) {
      request.headers.addAll(metadata);
    }
    return client.send(request);
  }
}

class UserClient extends http.BaseClient {
  final AdminClient client;
  final TokenProvider tokenProvider;

  UserClient(this.client, this.tokenProvider);

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    var body = (request as http.Request).bodyFields;
    request = http.Request(request.method, request.url)
      ..headers['content-type'] = 'application/x-www-form-urlencoded'
      ..bodyFields = {...body, if (!body.containsKey('idToken')) 'idToken': await tokenProvider.idToken};
    return client.send(request);
  }
}
