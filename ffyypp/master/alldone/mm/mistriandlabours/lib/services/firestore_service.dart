import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService<T> {
  FirestoreService._();
  static final instance = FirestoreService._();

  final _firestore = FirebaseFirestore.instance;

  Future<T?> getSingle<T>({
    required String path,
    required T builder(Map<String, dynamic> data, String id),
  }) async {
    final _ref = _firestore.doc(path);
    final _snap = await _ref.get();
    if (_snap.exists) {
      return builder(_snap.data()!, _snap.id);
    }
    return null;
  }

  Stream<T> streamSingle<T>({
    required String path,
    required T builder(Map<String, dynamic> data, String id),
  }) {
    final _ref = _firestore.doc(path);
    final _snap = _ref.snapshots();
    return _snap.map((event) => builder(event.data()!, event.id));
  }

  Future<void> setData({
    required String path,
    required Map<String, dynamic> data,
  }) async {
    final _ref = _firestore.doc(path);
    await _ref.set(data, SetOptions(merge: true));
  }

  Future<void> addData({
    required String path,
    required Map<String, dynamic> data,
  }) async {
    final _ref = _firestore.collection(path);
    await _ref.add(data);
  }

  Stream<List<T>> collectionStream<T>({
    required String path,
    required T Function(Map<String, dynamic> data, String documentId) builder,
    Query Function(Query query)? queryBuilder,
    int Function(T lhs, T rhs)? sort,
  }) {
    Query query = FirebaseFirestore.instance.collection(path);
    if (queryBuilder != null) {
      query = queryBuilder(query);
    }
    final snapshots = query.snapshots();
    return snapshots.map((snapshot) {
      final result = snapshot.docs
          .map((snapshot) =>
              builder(snapshot.data() as Map<String, dynamic>, snapshot.id))
          .where((value) => value != null)
          .toList();
      if (sort != null) {
        result.sort(sort);
      }
      return result;
    });
  }

  Future<void> deleteData({
    required String path,
  }) async {
    final _ref = _firestore.doc(path);
    await _ref.delete();
  }
}
