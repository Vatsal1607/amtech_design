import 'dart:developer';

import 'package:amtech_design/services/network/api_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../models/subs_day_details_model.dart';

class SubscriptionDetailsProvider extends ChangeNotifier {
  DateTime firstDay = DateTime.utc(2000, 1, 1);
  DateTime lastDay = DateTime.utc(2100, 12, 31);

  late DateTime selectedDay;
  late DateTime focusedDay;

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

  void onDaySelected(DateTime selected, DateTime focused) {
    selectedDay = selected;
    focusedDay = focused;
    debugPrint('selectedDate: $selected');
    debugPrint('focusedDate: $focused');
    //* Get the day name
    String dayName = DateFormat('EEEE').format(selectedDay);
    debugPrint('You tapped on $selectedDay, which is a $dayName');
    notifyListeners();
  }

  DateTime normalizeDate(DateTime date) =>
      DateTime(date.year, date.month, date.day);

  final Map<DateTime, Color> customDateColors = {
    DateTime.utc(2025, 4, 20): Color(0xFFB9C9DD), // Total Jars
    DateTime.utc(2025, 4, 21): Colors.white, // Remaining
    DateTime.utc(2025, 4, 22): Color(0xFF3B944D), // Delivered
    DateTime.utc(2025, 4, 23): Color(0xFFE84D3F), // Postponed
  };

  //* Initialize created Date for Calendar
  void setInitialCalendarState(DateTime createdAt) {
    final normalized = DateTime(createdAt.year, createdAt.month, createdAt.day);
    selectedDay = normalized;
    focusedDay = normalized;
    firstDay = normalized;
    lastDay = normalized.add(const Duration(days: 30));
    notifyListeners();
  }

  //* Dropdown things
  String? selectedValue;
  bool isDropdownOpen = false;

  final List<Map<String, String>> items = [
    {"label": "08:00AM To 09:00AM", "value": "08:00AM To 09:00AM"},
    {"label": "10:00AM To 11:00AM", "value": "10:00AM To 11:00AM"},
    {"label": "12:00PM To 01:00PM", "value": "12:00PM To 01:00PM"},
    {"label": "02:00PM To 03:00PM", "value": "02:00PM To 03:00PM"},
    {"label": "04:00PM To 05:00PM", "value": "04:00PM To 05:00PM"},
  ];

  void setSelectedValue(String? value) {
    selectedValue = value;
    notifyListeners();
  }

  void setDropdownState(bool isOpen) {
    isDropdownOpen = isOpen;
    notifyListeners();
  }

  ApiService apiService = ApiService();
  bool isLoading = false;
  SubsDayDetails? dayDetailsRes;

  //* subsDayDetails API
  Future getSubsDayDetails({required String subsId}) async {
    isLoading = true;
    try {
      final res = await apiService.subsDayDetails(
        subsId: subsId,
        day: 'Monday',
      );
      log('subsDayDetails: $res');
      if (res.success == true && res.data != null) {
        dayDetailsRes = res.data!.first;
      } else {
        log('${res.message}');
      }
    } catch (e) {
      log("Error subsDayDetails: ${e.toString()}");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
