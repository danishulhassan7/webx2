import 'package:mistriandlabours/models/labour.dart';
import 'package:mistriandlabours/services/doc_path.dart';
import 'package:mistriandlabours/services/firestore_service.dart';

class LabourService {
  static final LabourService instance = LabourService._();
  LabourService._();

  final FirestoreService _service = FirestoreService.instance;

  Stream<List<Labour>> labourStream({String? queryStr}) =>
      _service.collectionStream<Labour>(
        path: DocPath.labours,
        builder: (data, documentId) => Labour.fromMap(data, documentId),
        queryBuilder: (queryStr?.isEmpty ?? true)
            ? null
            : (query) => query
                .where("location", isGreaterThanOrEqualTo: queryStr ?? '')
                .where("location", isLessThanOrEqualTo: "${queryStr}\uf7ff"),
      );

  Future<void> setLabour(Labour user) async {
    await _service.setData(
      path: DocPath.labour(user.id),
      data: user.toMap(),
    );
  }

  Future<Labour?> getUserInfo(String id) async {
    return await _service.getSingle(
      path: DocPath.user(id),
      builder: (data, id) => Labour.fromMap(data, id),
    );
  }

  Stream<Labour> getUser(String userId) {
    return _service.streamSingle(
      path: DocPath.user(userId),
      builder: (data, id) => Labour.fromMap(data, id),
    );
  }

  Future<void> deleteLabour(String id) async {
    await _service.deleteData(
      path: DocPath.labour(id),
    );
  }
}
