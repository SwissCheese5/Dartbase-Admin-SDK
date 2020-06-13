import 'package:dartbase/dartbase.dart';
import 'package:dartbase/fcm/message.dart';
import 'package:test/test.dart';

import 'test_config.dart';



Future main() async {
  Firebase firebase;
  FCM fcm;
  final nameRegExp = RegExp(r'projects/.*/messages/[0-9]+');

  setUpAll(() async {
    firebase = await Firebase.initialize(projectId, await ServiceAccount.fromFile(serviceAccountPath));

    await FirebaseAuth.initialize();
    fcm = FCM(firebase, FCMConfig(firebase.projectId));
  });

  await test('Send message with token', () async {
    var message = V1Message(
      token: cloudMessagingToken,
      notification: V1MessageNotification(
        title: 'test with token',
        body: 'Some body text here',
      ),
    );
    var name = await fcm.send(message);
    expect(nameRegExp.hasMatch(name), true);
  });

  await test('Send message with topic', () async {
    var message = V1Message(
      topic: cloudMessagingTopic,
      notification: V1MessageNotification(
        title: 'test with token',
        body: 'Some body text here',
      ),
    );
    var name = await fcm.send(message);
    expect(nameRegExp.hasMatch(name), true);
  });
}
