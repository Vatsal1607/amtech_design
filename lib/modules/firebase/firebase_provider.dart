import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class FirebaseProvider with ChangeNotifier {
  String? _fcmToken;
  String? get fcmToken => _fcmToken;

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  FirebaseProvider() {
    _initializeFCM();
    debugPrint('FirebaseProvider called');
  }

  Future<void> _initializeFCM() async {
    try {
      // Request notification permissions (for iOS)
      NotificationSettings settings =
          await FirebaseMessaging.instance.requestPermission(
        alert: true,
        badge: true,
        sound: true,
      );

      // Check if permission is granted
      if (settings.authorizationStatus == AuthorizationStatus.authorized) {
        debugPrint("Notification permissions granted");

        // Give some time to ensure APNs token is set
        await Future.delayed(const Duration(seconds: 2));

        // Get the APNS token
        String? apnsToken = await _firebaseMessaging.getAPNSToken();
        if (apnsToken != null) {
          debugPrint("APNS Token: $apnsToken");
        } else {
          debugPrint(
              "APNS Token not set yet. Ensure that you have enabled push notifications.");
        }

        // Get the FCM token
        _fcmToken = await _firebaseMessaging.getToken();
        debugPrint('FCM Token: $_fcmToken');

        // Listen for token refresh events
        _firebaseMessaging.onTokenRefresh.listen((newToken) {
          _fcmToken = newToken;
        });
      } else {
        debugPrint("Notification permissions not granted");
      }
    } catch (e) {
      debugPrint('Error initializing FCM: $e');
    }
  }
}
