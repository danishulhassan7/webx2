class Labour {
  static const String idField = 'id';
  static const String nameField = 'name';
  static const String photoUrlField = 'photoUrl';
  static const String phoneNumberField = 'phoneNumber';
  static const String locationField = 'location';
  static const String aboutField = 'about';
  static const String memberField = 'member';
  static const String ratingField = 'rating';

  final String id;
  final String? displayName;
  final String? email;
  final String? photoUrl;
  final String? phoneNumber;
  final String? location;
  final String? about;
  final String? member;
  final double? rating;

  Labour({
    required this.id,
    this.displayName,
    this.email,
    this.photoUrl,
    this.member,
    this.phoneNumber,
    this.location,
    this.about,
    this.rating = 0,
  });

  factory Labour.fromMap(Map<String, dynamic> map, String id) {
    return Labour(
      id: id,
      displayName: map[nameField],
      photoUrl: map[photoUrlField],
      phoneNumber: map[phoneNumberField],
      location: map[locationField],
      about: map[aboutField],
      member: map[memberField],
      rating: map[ratingField],
    );
  }

  Labour copyWith({
    String? name,
    String? about,
    String? photoUrl,
    String? phoneNumber,
    String? location,
    String? member,
    double? rating,
  }) {
    return Labour(
      id: this.id,
      displayName: name ?? this.displayName,
      email: this.email,
      photoUrl: photoUrl ?? this.photoUrl,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      location: location ?? this.location,
      about: about ?? this.about,
      member: member ?? this.member,
      rating: rating ?? this.rating,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      idField: id,
      memberField: member,
      nameField: displayName,
      photoUrlField: photoUrl,
      locationField: location,
      aboutField: about,
      phoneNumberField: phoneNumber,
      ratingField: rating,
    };
  }
}
