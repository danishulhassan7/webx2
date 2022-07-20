import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:mistriandlabours/services/user_service.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

const APP_ID = '3695bd87-fe86-4c59-a296-2fdf70784a53';

class OneSignalService {
  // final _authService = Auth();
  final UserService _userService = UserService.instance;

  static final OneSignalService instance = OneSignalService._();
  OneSignalService._() {
    OneSignal.shared
      ..setAppId(APP_ID)
      ..setLocationShared(false);
  }

  // OneSignalService() {
  //   OneSignal.shared
  //     ..setAppId('3695bd87-fe86-4c59-a296-2fdf70784a53')
  //     ..setLocationShared(false);
  // }

  Future<String?> getDeviceId() async {
    final OSDeviceState? _osDeviceState =
        await OneSignal.shared.getDeviceState();
    return _osDeviceState?.userId;
  }

  void listenForNotification() {
    OneSignal.shared
        .promptUserForPushNotificationPermission()
        .then((accepted) {});

    OneSignal.shared.setNotificationWillShowInForegroundHandler(
        (OSNotificationReceivedEvent event) {
      if (event.notification.title != null &&
          event.notification.body != null &&
          !Platform.isIOS) {}
      event.complete(event.notification);
    });

    OneSignal.shared
        .setNotificationOpenedHandler((OSNotificationOpenedResult result) {
      // Will be called whenever a notification is opened/button pressed.
    });

    OneSignal.shared.setPermissionObserver((OSPermissionStateChanges changes) {
      // Will be called whenever the permission changes
      // (ie. user taps Allow on the permission prompt in iOS)
    });

    OneSignal.shared
        .setSubscriptionObserver((OSSubscriptionStateChanges changes) {
      // Will be called whenever the subscription changes
      // (ie. user gets registered with OneSignal and gets a user ID)
    });

    OneSignal.shared.setEmailSubscriptionObserver(
        (OSEmailSubscriptionStateChanges emailChanges) {
      // Will be called whenever then user's email subscription changes
      // (ie. OneSignal.setEmail(email) is called and the user gets registered
    });
  }

  Future<void> updateDevicetoken(String userID) async {
    final user = await _userService.getUserInfo(userID);
    final _token = await getDeviceId();

    if (_token != null && user != null) {
      await _userService.updateUser(user.copyWith(token: _token));
    }
  }

  Future<Response> sendNotification({
    required List<String> tokenIdList,
    required String contents,
    required String heading,
  }) async {
    return await post(
      Uri.parse('https://onesignal.com/api/v1/notifications'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        "app_id": APP_ID,
        "include_player_ids": tokenIdList,
        "android_accent_color": "FF9976D2",
        "small_icon": "ic_stat_onesignal_default",
        "headings": {"en": heading},
        "contents": {"en": contents},
      }),
    );
  }
}
