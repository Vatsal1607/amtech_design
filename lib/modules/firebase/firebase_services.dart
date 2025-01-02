import 'package:amtech_design/core/utils/constants/keys.dart';
import 'package:amtech_design/services/local/shared_preferences_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class FirebaseServices {
  String? _fcmToken;
  String? get fcmToken => _fcmToken;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initNotifications() async {
    try {
      // * Enable auto-init for FCM
      await _firebaseMessaging.setAutoInitEnabled(true);

      // * Request permission for notifications
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
        // * Get the FCM token
        _fcmToken = await _firebaseMessaging.getToken();
        if (_fcmToken != null) {
          // * Save the token to shared preferences
          sharedPrefsService.setString(SharedPrefsKeys.fcmToken, _fcmToken!);
          debugPrint("FCM Token: $_fcmToken");
        }

        // * Set up a listener for token refresh
        _firebaseMessaging.onTokenRefresh.listen((newToken) {
          _fcmToken = newToken;
          // * Save the token to shared preferences
          sharedPrefsService.setString(SharedPrefsKeys.fcmToken, newToken);
          debugPrint("FCM Token refreshed: $newToken");
        });
      } else {
        debugPrint("Notifications not authorized");
      }
    } catch (e) {
      debugPrint("Error in initNotifications: $e");
    }
  }
}
