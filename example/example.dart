import 'package:dartbase_admin/dartbase_admin.dart';
import 'package:dartbase_admin/fcm/message.dart';

const projectId = 'Project Settings -> General -> Project ID';
const storageUrl =
    'Bucket name without gs://, should look like <project-id>.appspot.com';

/// Note: Beware of pushing your credentials to source control.
void main() async {
  /// You can use environment variable look-up to find your service-account.json like so:
  /// (GOOGLE_APPLICATION_CREDENTIALS is the default environment variable we look for.)
  /// ServiceAccount.fromEnvironmentVariable();
  /// or from a file
  /// ServiceAccount.fromFile(filePath);
  /// or directly from a json string
  /// ServiceAccount.fromJson(String);
  await Firebase.initialize(projectId, ServiceAccount.fromJson(r'''
{
      Project Settings -> Service Accounts -> generate new private key
      Paste the json here
}
'''));

  await firestoreExample();
  await firebaseStorageExample();
  await authExample();
  await fcmExample();
}

Future<void> firestoreExample() async {
  /// Initialize the global firestore instance.
  /// Firestore fall back to the global firebase instance we initialized in main().
  Firestore.initialize();

  /// Instantiate a reference to a document - this happens offline.
  var ref = Firestore.instance.collection('test').document('doc');

  /// Subscribe to changes to that document.
  ref.stream.listen((document) => print('updated: $document'));

  /// Update the document
  await ref.update({'value': 'test'});

  /// Get a snapshot of the document
  var document = await ref.get();
  print('snapshot: ${document['value']}');
}

Future<void> firebaseStorageExample() async {
  /// FirebaseStorage doesn't have a global instance. You just get a bucket reference whenever you need it.
  var bucket = await FirebaseStorage.getBucket(storageUrl);
  var localFilePath = 'path/to/your/file.jpg';

  /// UPLOAD
  await bucket.upload('remoteDirectory/remoteFile.jpg', localFilePath);

  /// INFO
  var info = await bucket.info('remoteDirectory/remoteFile.jpg');
  print(info.downloadLink);

  /// DOWNLOAD
  //await bucket.download('remoteDirectory/remoteFile.jpg', localFilePath);

  /// LIST
  var list = await (await bucket.list(prefix: 'remoteDirectory/')).toList();
  print(list.map((info) => info.name).join(','));

  /// DELETE
  await bucket.delete('remoteDirectory/remoteFile.jpg');
}

Future<void> authExample() async {
  /// Initialize the global firebase auth instance.
  /// Firebase Auth will fall back to the global firebase instance we initialized in main().
  await FirebaseAuth.initialize();

  try {
    /// Get the user id from a client generate id token through verification.
    /// A bad token will throw an exception.
    var userId = await FirebaseAuth.instance
        .verifyIdToken('A client generated id token.', checkRevoked: true);

    /// We can use that id to get the user object or pass any user id we want that
    /// signed up to our project's firebase auth flow.
    var user = await FirebaseAuth.instance.getUserById(userId);
    print(user.displayName);
  } catch (e) {
    /// If the token is revoked, you will know here.
    print('User has a revoked token!');
    print(e);
  }
}

Future<void> fcmExample() async {
  /// Initialize the global FCM instance.
  /// FCM fall back to the global firebase instance we initialized in main().
  await FCM.initialize();

  /// Create a message to send. Many options exist here.
  var message = Message(
    topic: 'Some topic',
    notification: MessageNotification(
      title: 'Some title',
      body: 'Some body text here',
    ),
  );

  /// Send the message and return the firebase-assigned name of the message.
  var name = await FCM.instance.send(message);

  print('Firebase-assigned message name: $name');
}
