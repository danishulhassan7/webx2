import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as path;

class FirestorageService {
  static final FirestorageService _firestorageService = FirestorageService._();
  FirestorageService._();
  factory FirestorageService() => _firestorageService;

  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String> uploadFile(File file, String uid) async {
    try {
      String _name = path.basename(file.path);
      final _result = await _storage
          .ref()
          .child('images')
          .child(uid)
          .child(_name)
          .putData(file.readAsBytesSync());
      final _url = await _result.ref.getDownloadURL();
      return _url;
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<void> deleteFile(String url) async {
    final _ref = _storage.refFromURL(url);
    await _ref.delete();
  }
}
