import 'dart:developer';
import 'package:flutter/material.dart';
import '../../core/utils/constants/keys.dart';
import '../../models/notification_history_model.dart';
import '../../services/local/shared_preferences_service.dart';
import '../../services/network/api_service.dart';

class NotificationProvider extends ChangeNotifier {
  bool isLoading = false;
  ApiService apiService = ApiService();
  List<Notifications>? notificationsList;

  // *  Get NotificationHistory API
  Future notificationHistory() async {
    isLoading = true;
    try {
      String userId =
          sharedPrefsService.getString(SharedPrefsKeys.userId) ?? '';
      String accountType =
          sharedPrefsService.getString(SharedPrefsKeys.accountType) ?? '';
      final res = await apiService.notificationHistory(
        userId: userId,
        userType: accountType == 'business' ? '0' : '1',
      );
      log('notificationHistory: $res');
      if (res.success == true && res.data != null) {
        notificationsList = res.data?.notifications;
      } else {
        log('${res.message}');
      }
    } catch (e) {
      log("Error notificationHistory: ${e.toString()}");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  int unreadCount = 0;
  // *  Get Unread Count API
  Future unreadNotificationCount() async {
    // isLoading = true;
    try {
      String userId =
          sharedPrefsService.getString(SharedPrefsKeys.userId) ?? '';
      String accountType =
          sharedPrefsService.getString(SharedPrefsKeys.accountType) ?? '';
      final res = await apiService.unreadNotificationCount(
        userId: userId,
        userType: accountType == 'business' ? '0' : '1',
      );
      log('unreadNotificationCount: $res');
      if (res.success == true && res.data != null) {
        unreadCount = res.data?.unreadCount ?? 0;
        log('unreadCount: $unreadCount');
      } else {
        log('${res.message}');
      }
    } catch (e) {
      log("Error unreadNotificationCount: ${e.toString()}");
    } finally {
      // isLoading = false;
      notifyListeners();
    }
  }
}
