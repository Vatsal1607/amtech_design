import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/material.dart';

class NotificationService {
  static final FirebaseMessaging _firebaseMessaging =
      FirebaseMessaging.instance;
  // static final FlutterLocalNotificationsPlugin
  //     _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  static Future<void> initialize() async {
    // Request permission for notifications
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    debugPrint("User granted permission: ${settings.authorizationStatus}");

    // Get the FCM token
    String? token = await _firebaseMessaging.getToken();
    debugPrint("FCM Token: $token");

    // Initialize Local Notifications
    // const AndroidInitializationSettings androidInitSettings =
    //     AndroidInitializationSettings('@mipmap/ic_launcher');

    // final InitializationSettings initSettings =
    //     InitializationSettings(android: androidInitSettings);

    // await _flutterLocalNotificationsPlugin.initialize(
    //   initSettings,
    //   onDidReceiveNotificationResponse: (NotificationResponse response) {
    //     debugPrint("Notification clicked: ${response.payload}");
    //   },
    // );

    // Handle foreground notifications
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      debugPrint(
          "📩 Foreground Message Received: ${message.notification?.title}");
      // _showLocalNotification(message);
    });

    // Handle background & terminated state notifications
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      debugPrint(
          "📩 Background Notification Clicked: ${message.notification?.title}");
    });

    // Handle notification when the app is completely closed (terminated)
    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) {
      if (message != null) {
        debugPrint(
            "📩 Terminated App Notification Clicked: ${message.notification?.title}");
      }
    });
  }

  // Show a local notification when a foreground message arrives
  // static Future<void> _showLocalNotification(RemoteMessage message) async {
  //   const AndroidNotificationDetails androidDetails =
  //       AndroidNotificationDetails(
  //     'high_importance_channel',
  //     'High Importance Notifications',
  //     importance: Importance.high,
  //     priority: Priority.high,
  //   );

  //   const NotificationDetails notificationDetails = NotificationDetails(
  //     android: androidDetails,
  //   );

  //   await _flutterLocalNotificationsPlugin.show(
  //     0,
  //     message.notification?.title ?? "No Title",
  //     message.notification?.body ?? "No Body",
  //     notificationDetails,
  //     payload: message.data.toString(),
  //   );
  // }
}


// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';

// class NotificationService {
//   static final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

//   static Future<void> setupFCM() async {
//     // Request notification permissions
//     NotificationSettings settings = await _firebaseMessaging.requestPermission(
//       alert: true,
//       badge: true,
//       sound: true,
//     );

//     if (settings.authorizationStatus == AuthorizationStatus.authorized) {
//       debugPrint("User granted permission for notifications.");
//     } else {
//       debugPrint("User denied permission.");
//       return; // Exit if the user denied permissions
//     }

//     // Get the FCM token
//     String? token = await _firebaseMessaging.getToken();
//     debugPrint('FCM Token: $token');

//     // Listen for foreground messages
//     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//       debugPrint('📩 Foreground Message: ${message.notification?.title}');
//       _showNotification(message);
//     });

//     // Handle when a notification is tapped and opens the app
//     FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
//       debugPrint('🚀 Notification Clicked: ${message.notification?.title}');
//     });

//     // Handle background messages (outside of main UI thread)
//     FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
//   }

//   // Handle background messages
//   static Future<void> _firebaseMessagingBackgroundHandler(
//       RemoteMessage message) async {
//     debugPrint('📩 Background Message: ${message.notification?.title}');
//   }

//   // Display a simple debug notification (custom handling)
//   static void _showNotification(RemoteMessage message) {
//     debugPrint("🔔 New Notification: ${message.notification?.title}");
//   }


// }
