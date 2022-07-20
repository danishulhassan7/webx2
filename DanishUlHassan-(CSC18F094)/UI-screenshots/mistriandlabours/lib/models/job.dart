class Job {
  static final String idField = 'id';
  static final String titleField = 'title';
  static final String descriptionField = 'description';
  static final String postedByField = 'posted_by';

  Job({
    required this.id,
    required this.title,
    required this.description,
    this.postedBy,
  });

  final String id;
  final String title;
  final String description;
  final JobPostedBy? postedBy;

  factory Job.fromMap(Map<String, dynamic> data, String documentId) {
    final String name = data[titleField];
    final String description = data[descriptionField];
    final JobPostedBy? _postedBy = data[postedByField] == null
        ? null
        : JobPostedBy.fromMap(data[postedByField]);
    return Job(
      id: documentId,
      title: name,
      description: description,
      postedBy: _postedBy,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      idField: id,
      titleField: title,
      descriptionField: description,
      postedByField: postedBy?.toJson(),
    };
  }
}

class JobPostedBy {
  static const String idField = 'id';
  static const String nameField = 'name';
  static const String photoUrlField = 'photo_url';

  final String id;
  final String name;
  final String? photoUrl;

  JobPostedBy({
    required this.id,
    required this.name,
    required this.photoUrl,
  });

  factory JobPostedBy.fromMap(Map<String, dynamic> map) {
    return JobPostedBy(
      id: map[idField],
      name: map[nameField],
      photoUrl: map[photoUrlField],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      idField: id,
      nameField: name,
      photoUrlField: photoUrl,
    };
  }
}
