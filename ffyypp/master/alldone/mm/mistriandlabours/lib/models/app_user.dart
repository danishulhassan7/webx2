import 'package:mistriandlabours/models/app_roles.dart';

class AppUser {
  static const String idField = 'id';
  static const String nameField = 'name';
  static const String emailField = 'email';
  static const String photoUrlField = 'photoUrl';
  static const String phoneNumberField = 'phoneNumber';
  static const String lastSeenField = 'lastSeen';
  static const String locationField = 'location';
  static const String aboutField = 'about';
  static const String roleField = 'role';
  static const String appliedJobsField = 'appliedJobs';
  static const String tokenField = 'token';
  static const String isActiveField = 'isActive';

  final String id;
  final String? displayName;
  final String? email;
  final String? photoUrl;
  final DateTime? lastSignIn;
  final String? phoneNumber;
  final String? location;
  final String? about;
  final String role;
  final List<String> appliedJobs;
  final String? token;
  final bool isActive;

  AppUser({
    required this.id,
    this.displayName,
    this.email,
    this.photoUrl,
    this.lastSignIn,
    this.phoneNumber,
    this.location,
    this.about,
    this.role = AppRoles.user,
    this.appliedJobs = const [],
    this.token,
    this.isActive = true,
  });

  factory AppUser.fromMap(Map<String, dynamic> map, String id) {
    return AppUser(
      id: id,
      displayName: map[nameField],
      email: map[emailField],
      lastSignIn: map[lastSeenField]?.toDate(),
      photoUrl: map[photoUrlField],
      phoneNumber: map[phoneNumberField],
      location: map[locationField],
      about: map[aboutField],
      role: map[roleField] ?? AppRoles.user,
      appliedJobs: (map[appliedJobsField] ?? []).cast<String>(),
      token: map[tokenField],
      isActive: map[isActiveField] ?? true,
    );
  }

  AppUser copyWith({
    String? name,
    String? about,
    String? photoUrl,
    String? phoneNumber,
    String? location,
    DateTime? lastSignIn,
    List<String>? appliedJobs,
    String? token,
    String? role,
    bool? isActive,
  }) {
    return AppUser(
      id: this.id,
      displayName: name ?? this.displayName,
      email: this.email,
      photoUrl: photoUrl ?? this.photoUrl,
      lastSignIn: lastSignIn ?? this.lastSignIn,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      location: location ?? this.location,
      about: about ?? this.about,
      role: role ?? this.role,
      appliedJobs: appliedJobs ?? this.appliedJobs,
      token: token ?? this.token,
      isActive: isActive ?? this.isActive,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      idField: id,
      emailField: email,
      nameField: displayName,
      photoUrlField: photoUrl,
      lastSeenField: lastSignIn,
      locationField: location,
      aboutField: about,
      roleField: role,
      phoneNumberField: phoneNumber,
      appliedJobsField: appliedJobs,
      tokenField: token,
      isActiveField: isActive,
    };
  }
}
