class DocPath {
  static String users = 'users';
  static String user(String userId) => '$users/$userId';

  static String labours = 'labours';
  static String labour(String labourId) => '$labours/$labourId';

  static String jobs = 'jobs';
  static String job(String jobId) => '$jobs/$jobId';

  static String jobApplications = 'jobApplications';
  static String jobApplication(String jobApplicationId) =>
      '$jobApplications/$jobApplicationId';
}
