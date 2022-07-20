class JobApplication {
  static const String idField = 'id';
  static const String titleField = 'title';
  static const String descriptionField = 'description';
  static const String dateField = 'date';
  static const String timeField = 'time';
  static const String paymentField = 'payment';
  static const String locationField = 'location';
  static const String additionalInfoField = 'additionalInfo';
  static const String jobIdField = 'jobId';
  static const String userIdField = 'userId';
  static const String createdAtField = 'createdAt';
  static const String updatedAtField = 'updatedAt';
  static const String statusField = 'status';

  final String id;
  final String title;
  final String? description;
  final String date;
  final String time;
  final String payment;
  final String location;
  final String? additionalInfo;
  final String jobId;
  final String userId;
  final String createdAt;
  final String? updatedAt;
  final String status;

  JobApplication({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.time,
    required this.payment,
    required this.location,
    this.additionalInfo,
    required this.jobId,
    required this.userId,
    required this.createdAt,
    this.updatedAt,
    this.status = 'pending', //pending,accepted,rejected
  });

  factory JobApplication.fromMap(Map<String, dynamic> map, String id) {
    return JobApplication(
      id: id,
      title: map[titleField],
      description: map[descriptionField],
      date: map[dateField],
      time: map[timeField],
      payment: map[paymentField],
      location: map[locationField],
      additionalInfo: map[additionalInfoField],
      jobId: map[jobIdField],
      userId: map[userIdField],
      createdAt: map[createdAtField],
      updatedAt: map[updatedAtField],
      status: map[statusField],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      titleField: title,
      descriptionField: description,
      dateField: date,
      timeField: time,
      paymentField: payment,
      locationField: location,
      additionalInfoField: additionalInfo,
      jobIdField: jobId,
      userIdField: userId,
      createdAtField: createdAt,
      updatedAtField: updatedAt,
      statusField: status,
    };
  }

  JobApplication copyWith({
    String? status,
  }) {
    return JobApplication(
      id: id,
      title: title,
      description: description,
      date: date,
      time: time,
      payment: payment,
      location: location,
      jobId: jobId,
      userId: userId,
      createdAt: createdAt,
      status: status ?? this.status,
    );
  }
}
