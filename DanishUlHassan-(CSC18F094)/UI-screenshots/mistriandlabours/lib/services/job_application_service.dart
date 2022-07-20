import 'package:mistriandlabours/models/job_application.dart';
import 'package:mistriandlabours/services/doc_path.dart';
import 'package:mistriandlabours/services/firestore_service.dart';

class JobApplicationService {
  static final JobApplicationService instance = JobApplicationService._();
  JobApplicationService._();

  final FirestoreService _service = FirestoreService.instance;

  Future<void> setJobApplication(JobApplication jobApplication) async {
    await _service.setData(
      path: DocPath.jobApplication(jobApplication.id),
      data: jobApplication.toMap(),
    );
  }

  Stream<List<JobApplication>> jobApplicationsStream({
    String? jobID,
  }) =>
      _service.collectionStream<JobApplication>(
        path: DocPath.jobApplications,
        builder: (data, documentId) => JobApplication.fromMap(data, documentId),
        queryBuilder: jobID == null
            ? null
            : (query) => query.where('jobId', isEqualTo: jobID),
      );
}
