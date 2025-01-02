import 'dart:io';
import 'package:amtech_design/core/utils/constants/keys.dart';
import 'package:amtech_design/services/local/shared_preferences_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class FirebaseServices {
  String? _fcmToken;
  String? get fcmToken => _fcmToken;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initNotifications() async {
    await _firebaseMessaging.setAutoInitEnabled(true);

    final permissionRequest = await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (permissionRequest.authorizationStatus ==
        AuthorizationStatus.authorized) {
      if (Platform.isIOS) {
        String? apnsToken = await _firebaseMessaging.getAPNSToken();
        await Future<void>.delayed(const Duration(seconds: 2));
        if (apnsToken != null) {
          debugPrint("APNS Token: $apnsToken");
          _fcmToken = await _firebaseMessaging.getToken();
          if (_fcmToken != null) {
            sharedPrefsService.setString(SharedPrefsKeys.fcmToken, _fcmToken!);
          }
          debugPrint("FCM Token: $_fcmToken");
        } else {
          debugPrint("APNS Token not available, waiting ...");
        }
      } else {
        // * platform Android
        _fcmToken = await _firebaseMessaging.getToken();
        if (_fcmToken != null) {
          sharedPrefsService.setString(SharedPrefsKeys.fcmToken, _fcmToken!);
        }

        debugPrint("FCM Token: $_fcmToken");
      }
    } else {
      debugPrint("Notifications not authorized");
    }
  }
}
