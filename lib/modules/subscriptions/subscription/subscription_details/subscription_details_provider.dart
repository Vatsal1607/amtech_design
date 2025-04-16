import 'dart:math';

import 'package:flutter/material.dart';

class SubscriptionDetailsProvider extends ChangeNotifier {
  final DateTime firstDay = DateTime.utc(2000, 1, 1);
  final DateTime lastDay = DateTime.utc(2100, 12, 31);

  late DateTime selectedDay;
  late DateTime focusedDay;

  // Map<DateTime, String> deliveryStatus = {
  //   DateTime(2025, 4, 14): 'delivered',
  //   DateTime(2025, 4, 15): 'postponed',
  //   DateTime(2025, 4, 16): 'delivered',
  //   DateTime(2025, 4, 17): 'postponed',
  //   DateTime(2025, 4, 18): 'delivered',
  // };

  SubscriptionDetailsProvider() {
    final DateTime today = DateTime.now();

    if (_isWithinRange(today)) {
      focusedDay = today;
      selectedDay = today;
    } else {
      focusedDay = lastDay; // or _firstDay, depending on your preference
      selectedDay = focusedDay;
    }
  }
  bool _isWithinRange(DateTime date) {
    return (date.isAtSameMomentAs(firstDay) || date.isAfter(firstDay)) &&
        (date.isAtSameMomentAs(lastDay) || date.isBefore(lastDay));
  }

  DateTime _clampDate(DateTime date, DateTime min, DateTime max) {
    if (date.isBefore(min)) return min;
    if (date.isAfter(max)) return max;
    return date;
  }

  void onDaySelected(DateTime selected, DateTime focused) {
    selectedDay = selected;
    focusedDay = focused;
    debugPrint('selectedDate: $selected');
    debugPrint('focusedDate: $focused');
    notifyListeners();
  }

  DateTime normalizeDate(DateTime date) =>
      DateTime(date.year, date.month, date.day);

  // Color getDateColor(DateTime date) {
  //   switch (date.weekday) {
  //     case DateTime.sunday:
  //     case DateTime.monday:
  //     case DateTime.tuesday:
  //     case DateTime.thursday:
  //       return Colors.green;
  //     case DateTime.wednesday:
  //       return Colors.red;
  //     default:
  //       return Colors.white;
  //   }
  // }
  final Map<DateTime, Color> customDateColors = {
    DateTime.utc(2025, 4, 20): Colors.orange,
    DateTime.utc(2025, 4, 21): Colors.blue,
    DateTime.utc(2025, 4, 22): Colors.purple,
  };
}
