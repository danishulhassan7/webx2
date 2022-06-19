import 'package:mistriandlabours/models/job.dart';
import 'package:mistriandlabours/services/doc_path.dart';
import 'package:mistriandlabours/services/firestore_service.dart';

class JobService {
  static final JobService instance = JobService._();
  JobService._();

  final FirestoreService _service = FirestoreService.instance;

  Future<void> setJob(Job job) async {
    await _service.setData(
      path: DocPath.job(job.id),
      data: job.toMap(),
    );
  }

  Future<void> deleteJob(String jobID) async {
    await _service.deleteData(
      path: DocPath.job(jobID),
    );
  }

  Stream<List<Job>> JobsStream({String? userID}) =>
      _service.collectionStream<Job>(
        path: DocPath.jobs,
        builder: (data, documentId) => Job.fromMap(data, documentId),
        queryBuilder: userID != null
            ? (query) => query.where('posted_by.id', isEqualTo: userID)
            : null,
      );
}
