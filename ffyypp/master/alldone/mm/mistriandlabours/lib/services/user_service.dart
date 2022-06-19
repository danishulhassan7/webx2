import 'package:mistriandlabours/models/app_user.dart';
import 'package:mistriandlabours/services/doc_path.dart';
import 'package:mistriandlabours/services/firestore_service.dart';

class UserService {
  static final UserService instance = UserService._();
  UserService._();

  final FirestoreService _service = FirestoreService.instance;

  Future<void> updateUser(AppUser user) async {
    await _service.setData(
      path: DocPath.user(user.id),
      data: user.toMap(),
    );
  }

  Future<AppUser?> getUserInfo(String id) async {
    return await _service.getSingle(
      path: DocPath.user(id),
      builder: (data, id) => AppUser.fromMap(data, id),
    );
  }

  Stream<List<AppUser>> usersStream({String? userID}) =>
      _service.collectionStream<AppUser>(
        path: DocPath.users,
        builder: (data, documentId) {
          var _newData = {...data, 'id': documentId};
          return AppUser.fromMap(_newData, documentId);
        },
      );

  Stream<AppUser> getUser(String userId) {
    return _service.streamSingle(
      path: DocPath.user(userId),
      builder: (data, id) => AppUser.fromMap(data, id),
    );
  }
}
