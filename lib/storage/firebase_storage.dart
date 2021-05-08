import 'dart:async';
import 'dart:typed_data';

import 'package:dartbase_admin/platform/access_exporter.dart';
import 'package:gcloud/storage.dart';

import '../base/firebase.dart';

class FirebaseStorage {
  final Bucket _bucket;

  FirebaseStorage._internal(this._bucket);

  static Future<FirebaseStorage> getBucket(String bucketId,
      {Firebase? firebase}) async {
    assert(firebase != null || Firebase.initialized,
        'Firebase global instance not initialized, run Firebase.initialize().\nAlternatively, provide a local instance via FirebaseStorage.getBucket(bucketId, firebase: <firebase instance>)');
    assert(bucketId.isNotEmpty, 'Bucket ID cannot be null');

    firebase ??= Firebase.instance;

    var storage = Storage(firebase.client, firebase.projectId);
    var bucket = await storage.bucket(bucketId);

    return FirebaseStorage._internal(bucket);
  }

  /*
  Future<void> download(String remotePath, String localPath,
      {int? offset, int? length}) async {
    var sink = getPlatformAccess().openWrite(localPath);
    await _bucket.read(remotePath, offset: offset, length: length).pipe(sink);
    await sink.close();
  }
  */
  Future<ObjectInfo> upload(String remotePath, String localPath,
      {int? length,
      ObjectMetadata? metadata,
      Acl? acl,
      PredefinedAcl? predefinedAcl,
      String? contentType}) async {
    var streamSink = _bucket.write(remotePath,
        length: length,
        metadata: metadata,
        acl: acl,
        predefinedAcl: predefinedAcl,
        contentType: contentType);

    await getPlatformAccess().openRead(localPath).pipe(streamSink);

    return await streamSink.done;
  }

  Future<ObjectInfo> uploadBytes(String remotePath, Uint8List bytes,
          {ObjectMetadata? metadata,
          Acl? acl,
          PredefinedAcl? predefinedAcl,
          String? contentType}) =>
      _bucket.writeBytes(remotePath, bytes,
          metadata: metadata,
          acl: acl,
          predefinedAcl: predefinedAcl,
          contentType: contentType);

  Future<ObjectInfo> info(String remotePath) => _bucket.info(remotePath);

  Future delete(String remotePath) => _bucket.delete(remotePath);

  Future updateMetadata(String remotePath, ObjectMetadata metadata) =>
      _bucket.updateMetadata(remotePath, metadata);

  Stream<BucketEntry> list({String? prefix}) => _bucket.list(prefix: prefix);

  Future<Page<BucketEntry>> page({String? prefix, int pageSize = 50}) async =>
      (await _bucket.page(prefix: prefix, pageSize: pageSize));
}
