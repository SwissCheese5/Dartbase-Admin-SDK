import 'dart:io';

import 'package:dartbase/dartbase.dart';
import 'package:dartbase/storage/firebase_storage.dart';
import 'package:gcloud/storage.dart';
import 'package:test/test.dart';

import 'test_config.dart';

Future main() async {
  var bucket;
  var localFile = File('localDirectory/localFile.jpg');
  Firebase firebase;

  setUpAll(() async {
    firebase = await Firebase.initialize(
        projectId, await ServiceAccount.fromFile(serviceAccountPath));
    bucket = await FirebaseStorage.getBucket(storageUrl, firebase: firebase);

    await localFile.create(recursive: true);
    // Download a test image
    await HttpClient()
        .getUrl(Uri.parse('https://bit.ly/36HMid0'))
        .then((HttpClientRequest request) => request.close())
        .then((HttpClientResponse response) =>
            response.pipe(localFile.openWrite()));
  });

  await test('Storage upload', () async {
    expect(await localFile.exists(), true);

    await bucket.upload(
        'remoteDirectory/remoteFile.jpg', localFile.absolute.path,
        predefinedAcl: PredefinedAcl.publicRead);

    var info = await bucket.info('remoteDirectory/remoteFile.jpg');
    expect(info.downloadLink != null, true);

    print(info.downloadLink);
  });

  await test('Storage download', () async {
    await bucket.download(
        'remoteDirectory/remoteFile.jpg', localFile.absolute.path);

    expect(await localFile.exists(), true);
  });

  await test('Storage list', () async {
    var list = await (await bucket.list(prefix: 'remoteDirectory/')).toList();

    expect(list.isNotEmpty, true);

    print(list.map((e) => e.name).toList().join('\n'));
  });

  await test('Storage delete', () async {
    await bucket.delete('remoteDirectory/remoteFile.jpg');

    try {
      await bucket.info('remoteDirectory/remoteFile.jpg');
      fail('Object did not delete');
    } catch (e) {
      expect(e != null, true);
    }
  });

  tearDownAll(() async {
    await localFile.delete();
  });
}
