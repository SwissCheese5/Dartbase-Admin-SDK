# Dartbase Admin SDK™️

A dart-native implementation of the Firebase Admin SDK.

This library is a fork of cachapa's client firebase sdk; cachapa/firedart; modified and converted to support admin only firebase features.
This library also uses these files from appsup-dart/firebase_admin to enable admin authentication to firebase because it is not documented on firebase's official documentation (May 2020):
* user_record.dart.
* token_handler.dart

### Currently supported:

* Firebase Auth
* Firestore
* Firebase Storage
* Firebase Cloud Messaging

# INCOMPLETE README

## Dependencies

Add firedart to your `pubspec.yaml` file:

``` yaml
dependencies:
  firedart: [latest version]
```

## Firebase Auth

The `Firebase` class implements the necessary functionality for managing accounts. It currently only supports `Email/Password` sign-in, so make sure it's enabled under `Authentication` -> `Sign-in Method`.

You'll also need to go to your `Firebase Console`, open `Project Settings` and under the `General` tab copy the `Web API Key`.

> **Note: in order to reduce external dependencies this library doesn't include a mechanism for persisting tokens. Please look at the following examples based on [SharedPreferences](https://gist.github.com/cachapa/539dd1007fcf097179040f4056cdd4c7) and [Hive](https://gist.github.com/cachapa/33944987bd8fe6c6ba84021cecef8fb7).**

### Usage

``` dart
import 'package:firedart/firedart.dart';
```

`Firebase` has a singleton version which should be enough for most use cases. You'll need to initialise it with your API key and a token store (see note above):

``` dart
Firebase.initialize(apiKey, await HiveStore());
await Firebase.instance.signIn(email, password);
var user = await Firebase.instance.getUser();
```

Alternatively you can instantiate your own `Firebase` object:

``` dart
var firebaseAuth = Firebase.(apiKey, await PreferencesStore());
await firebaseAuth.signIn(email, password);
var user = await firebaseAuth.getUser();
```

Further usage examples can be found in the [integration tests](https://github.com/cachapa/firedart/blob/master/test/firebase_auth_test.dart).

### Limitations

* Currently the only supported authentication provider is `Email/Password`.

## Firestore

The `Firestore` class is a basic implementation of the service's RPC interface. The API is similar (but not identical) to that of the official SDK.

### Usage

``` dart
import 'package:firedart/firedart.dart';
```

As with `Firebase`, `Firestore` offers a singleton version that needs to be initialised with your `Project ID`, which you can find under `Project Settings` -> `General`:

``` dart
Firestore.initialize(projectId);
var map = await Firestore.instance.collection("users").get();
var users = UserCollection.fromMap(map);
```

You can also instantiate your own `Firestore` object. Please note that if your database requires authenticated access, you'll need to pass along an instance of `Firebase`.

``` dart
var firebaseAuth = Firebase.(apiKey, await HiveStore());
var firestore = Firestore(projectId, auth: firebaseAuth);

await firebaseAuth.signIn(email, password);
var map = await firestore.collection("users").get();
var users = UserCollection.fromMap(map);
```

Further usage examples can be found in the [integration tests](https://github.com/cachapa/firedart/blob/master/test/firestore_test.dart).

### Using the Firestore Admin SDK

Limited support is provided for using the Firestore Admin SDK.  See (example/admin.dart)[example/admin.dart].


### Limitations

* Collection queries (limit, sort, etc.) are currently not supported.
* The data is not cached locally.
* Failed writes (e.g. due to network errors) are not retried.
* Closed streams are not automatically recovered.

### Regenerating the RPC stubs

The Firestore RPC stubs are based on Google's official protobuf definition files from [googleapis](https://github.com/googleapis/googleapis).

To regenerate them, you will need to check out both [googleapis](https://github.com/googleapis/googleapis) and [protobuf](https://github.com/google/protobuf).

Set the `PROTOBUF` and `GOOGLEAPIS` environment variables to point to your clones of the above repositories respectively, and then run:

```sh
$ tool/regenerate.sh
```

## Firebase Cloud Messaging

The `FCM` class implements the necessary functionality for sending cloud messages.

Make sure you've enabled `Cloud Messaging` in the `Firebase Console`, also enroll a test device there.
You'll also need to go to open `Project Settings` and under the `Cloud Messaging` tab copy the `Server key`.

### Usage

You'll need to create a `test_config.dart` file:
``` dart
const projectId = "Project Settings -> General -> Project ID";
const serviceAccountPath = 'Project Settings -> Service Accounts -> generate new private key -> download and get file path';
const cloudMessagingServerKey = 'Project settings -> Cloud Messaging -> Server key';
```

Then in your main script:
``` dart
import 'package:dartbase/dartbase.dart';
import 'package:dartbase/fcm/message.dart';

main() async {
  var firebase = await Firebase.initialize(projectId,
      await ServiceAccount.fromFile(serviceAccountPath));
  var fcm = FCM(firebase, FCMConfig(firebase.projectId));
  const token = '<Your device token here>';
  const topic = '<Choose a topic name>';

  // Send to a token
  var message = V1Message(
    token: token,
    notification: V1MessageNotification(
      title: "plantyplants test",
      body: "Some body text here",
    ),
  );
  var nameTopicMessage = await fcm.send(message);

  // Send to a topic
  var message = V1Message(
    topic: topic,
    notification: V1MessageNotification(
      title: "plantyplants test",
      body: "Some body text here",
    ),
  );
  var nameTopicMessage = await fcm.send(message);

  return;
}
```

Further usage examples can be found in the [integration tests](https://github.com/SwissCheese5/Dartbase-Admin-SDK/blob/master/test/firebase_fcm_test.dart).

### Limitations

* Doesn't support [batch send](https://firebase.google.com/docs/cloud-messaging/send-message#send-messages-to-multiple-devices).
* Doesn't support receiving a cloud message.

## Debugging

For debugging `Firebase Auth` you can use `VerboseClient`, an HTTP client that logs all communication to the console. The logs can expose sensitive data including passwords and keys, so it's recommended to only enable it for development builds. In Flutter this can be achieved using the `kReleaseMode` constant from the `foundation` package:

``` dart
var client = !kReleaseMode ? VerboseClient() : http.Client();
var firebaseAuth = Firebase(apiKey, await PreferencesStore(), httpClient: client);
```

## Securing Tokens

If you're running your code in an environment that requires securing access tokens, you can extend `TokenStore` to persist data in a secure maner, e.g. by encrypting the data or storing it in an external vault. Example implementations can be found in [token_store.dart](https://github.com/cachapa/firedart/blob/master/lib/auth/token_store.dart).
