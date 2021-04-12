import '../base/firebase.dart';
import 'firestore_gateway.dart';
import 'models.dart';

class Firestore {
  /* Singleton instance */
  static Firestore? _instance;

  static bool get initialized => _instance != null;

  static Firestore initialize(
      {Firebase? firebase, String databaseId = '(default)'}) {
    assert(!initialized,
        'Firestore global instance is already initialized. Do not call this twice or create a local instance via Firestore()');

    _instance = Firestore(
        firebase: firebase ?? Firebase.instance, databaseId: databaseId);
    return _instance!;
  }

  static Firestore get instance {
    assert(initialized,
        "Firestore hasn't been initialized. Call Firestore.initialize() before using this global instance. Alternatively, create a local instance via Firestore() and use that.");

    return _instance!;
  }

  /* Instance interface */
  final FirestoreGateway _gateway;
  final Firebase? firebase;

  Firestore({this.firebase, String databaseId = '(default)'})
      : assert(firebase != null || Firebase.initialized,
            'Firebase global instance not initialized, run Firebase.initialize().\nAlternatively, provide a local instance via Firestore.initialize(firebase: <firebase instance>)'),
        _gateway = FirestoreGateway(firebase ?? Firebase.instance,
            databaseId: databaseId);

  Reference reference(String path) => Reference.create(_gateway, path);

  CollectionReference collection(String path) =>
      CollectionReference(_gateway, path);

  DocumentReference document(String path) => DocumentReference(_gateway, path);

  Future<void> close() async {
    await _gateway.close();
  }
}
