import 'package:flutter/material.dart';
import 'notification_service.dart';

class NotificationProvider extends ChangeNotifier {
  String? _fcmToken;

  String? get fcmToken => _fcmToken;

  Future<void> fetchFCMToken() async {
    // _fcmToken = await NotificationService._messaging.getToken();
    notifyListeners(); // Update UI
  }
}
