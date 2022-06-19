import 'package:firebase_auth/firebase_auth.dart';
import 'package:mistriandlabours/models/app_user.dart';
import 'package:mistriandlabours/services/one_signal_service.dart';
import 'package:mistriandlabours/services/user_service.dart';

abstract class BaseAuth {
  String get userId;
  Stream<AppUser?> get authStateChanges;
  Future<AppUser?> signInWithEmailAndPassword(String email, String password);
  Future<AppUser?> signUpWithEmailAndPassword(
    String name,
    String role,
    String email,
    String password, [
    String? url,
  ]);
  Future<void> sendPasswordResetEmail(String email);
  Future<void> signOut();
  Future<void> updateUser(AppUser user);
}

class Auth implements BaseAuth {
  final _auth = FirebaseAuth.instance;
  final UserService _userService = UserService.instance;
  final OneSignalService _oneSignalService = OneSignalService.instance;

  late String _userId;
  String get userId => _userId;

  @override
  Stream<AppUser?> get authStateChanges =>
      _auth.authStateChanges().map(_mapUserToAppUser);

  AppUser? _mapUserToAppUser(User? user) {
    if (user == null) return null;

    _userId = user.uid;
    final _appUser = AppUser(
      id: user.uid,
      displayName: user.displayName,
      email: user.email,
      lastSignIn: DateTime.now(),
      photoUrl: user.photoURL,
    );
    //update user in firestore
    _updateUser(_appUser);
    //update firebase token

    return _appUser;
  }

  _updateUser(AppUser? appUser) async {
    if (appUser == null) return;
    final _eUser = await _userService.getUserInfo(appUser.id);

    if (_eUser == null) {
      await _userService.updateUser(appUser);
    } else {
      await _userService.updateUser(_eUser.copyWith(
        lastSignIn: appUser.lastSignIn,
      ));
    }
    print('updated user');
    _oneSignalService.updateDevicetoken(_userId);
  }

  @override
  Future<void> signOut() async {
    await Future.wait([_auth.signOut()]);
  }

  @override
  Future<AppUser?> signInWithEmailAndPassword(
      String email, String password) async {
    final authResult = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return _mapUserToAppUser(authResult.user);
  }

  @override
  Future<void> sendPasswordResetEmail(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }

  @override
  Future<void> updateUser(AppUser appUser) async {
    //update user name if firebase
    final user = await _auth.currentUser;
    user?.updateDisplayName(appUser.displayName);
    if (appUser.photoUrl != null) user?.updatePhotoURL(appUser.photoUrl!);
    await _userService.updateUser(appUser);
  }

  @override
  Future<AppUser?> signUpWithEmailAndPassword(
      String name, String role, String email, String password,
      [String? url]) async {
    final authResult = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    final user = await _auth.currentUser;
    user?.updateDisplayName(name);
    if (url != null) user?.updatePhotoURL(url);
    final _appUser = AppUser(
      id: user!.uid,
      displayName: name,
      email: email,
      lastSignIn: DateTime.now(),
      photoUrl: url,
      role: role,
    );
    await _userService.updateUser(_appUser);
    return _mapUserToAppUser(authResult.user);
  }
}
