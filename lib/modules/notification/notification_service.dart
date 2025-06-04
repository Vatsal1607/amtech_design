import 'dart:convert';
import 'dart:developer';
import 'package:amtech_design/core/utils/constants/keys.dart';
import 'package:amtech_design/services/local/shared_preferences_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../../models/notification_model.dart';
import '../../services/local/hive_service.dart';

class NotificationService {
  static String? _fcmToken;
  static String? get fcmToken => _fcmToken;
  static final FirebaseMessaging _firebaseMessaging =
      FirebaseMessaging.instance;
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static Future<void> initialize() async {
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
        initLocalNotifications();
        // * Handle foreground notifications
        FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
          // log("Foreground NOTIFICATION RECEIVED: ${message.data}");
          final Map<String, dynamic> rawData = message.data;
          dynamic dataField = rawData['data'];
          Map<String, dynamic>? parsedInnerData;

          if (dataField is String) {
            try {
              parsedInnerData = jsonDecode(dataField);
            } catch (e) {
              log("Failed to decode 'data' field: $e");
            }
          } else if (dataField is Map) {
            parsedInnerData = Map<String, dynamic>.from(dataField);
          }

          NotificationModel notification = NotificationModel(
            body: rawData['body'],
            title: rawData['title'],
            clickAction: rawData['click_action'],
            type: rawData['type'],
            userType: rawData['user_type'],
            data:
                parsedInnerData != null ? Data.fromJson(parsedInnerData) : null,
          );

          final bool isActive = notification.data?.isActive ?? false;
          await HiveLocalStorageHelper.setStoreActive(isActive);

          showNotification(
            id: DateTime.now().millisecondsSinceEpoch.remainder(100000),
            title: message.notification?.title ?? 'No Title',
            body: message.notification?.body ?? 'No Body',
          );
        });
        FirebaseMessaging.onBackgroundMessage(backgroundMessageHandler);
      } else {
        debugPrint("Notifications not authorized");
      }
    } catch (e) {
      debugPrint("Error in initNotifications: $e");
    }
  }

  // * Background message handler
  @pragma('vm:entry-point') // Important for iOS background execution
  static Future<void> backgroundMessageHandler(RemoteMessage message) async {
    // log("Background NOTIFICATION RECEIVED: ${message.data}");
    await Firebase.initializeApp();
    await HiveLocalStorageHelper.init();
    final Map<String, dynamic> rawData = message.data;
    dynamic dataField = rawData['data'];
    Map<String, dynamic>? parsedInnerData;
    if (dataField is String) {
      try {
        parsedInnerData = jsonDecode(dataField);
      } catch (e) {
        log("Failed to decode 'data' field: $e");
      }
    } else if (dataField is Map) {
      parsedInnerData = Map<String, dynamic>.from(dataField);
    }
    NotificationModel notification = NotificationModel(
      body: rawData['body'],
      title: rawData['title'],
      clickAction: rawData['click_action'],
      type: rawData['type'],
      userType: rawData['user_type'],
      data: parsedInnerData != null ? Data.fromJson(parsedInnerData) : null,
    );
    final bool isActive = notification.data?.isActive ?? false;
    await HiveLocalStorageHelper.setStoreActive(isActive);
  }

  static Future<void> initLocalNotifications() async {
    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const DarwinInitializationSettings iosSettings =
        DarwinInitializationSettings();

    InitializationSettings settings = const InitializationSettings(
        android: androidSettings, iOS: iosSettings);

    await _notificationsPlugin.initialize(settings);
  }

  static Future<void> showNotification(
      {required int id, required String title, required String body}) async {
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
      'channel_id',
      'channel_name',
      channelDescription: 'channel_description',
      importance: Importance.high,
      priority: Priority.high,
    );

    const NotificationDetails details =
        NotificationDetails(android: androidDetails);

    await _notificationsPlugin.show(id, title, body, details);
  }
}
