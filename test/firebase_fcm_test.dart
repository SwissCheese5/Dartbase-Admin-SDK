import 'package:dartbase_admin/dartbase_admin.dart';
import 'package:dartbase_admin/fcm/message.dart';
import 'package:test/test.dart';

import 'test_config.dart';

Future main() async {
  final nameRegExp = RegExp(r'projects/.*/messages/[0-9]+');

  setUpAll(() async {
    await Firebase.initialize(
        projectId, await ServiceAccount.fromFile(serviceAccountPath));
    FCM.initialize();
  });

  test('Send message with token', () async {
    var message = Message(
      token: cloudMessagingToken,
      notification: MessageNotification(
        title: 'test with token',
        body: 'Some body text here',
      ),
    );
    var name = await FCM.instance.send(message);
    expect(nameRegExp.hasMatch(name), true);
  });

  test('Send message with topic', () async {
    var message = Message(
      topic: cloudMessagingTopic,
      notification: MessageNotification(
        title: 'test with token',
        body: 'Some body text here',
      ),
    );
    var name = await FCM.instance.send(message);
    expect(nameRegExp.hasMatch(name), true);
  });
}
