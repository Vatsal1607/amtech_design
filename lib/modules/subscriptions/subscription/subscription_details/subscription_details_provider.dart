import 'dart:convert';
import 'dart:developer';
import 'package:amtech_design/services/network/api_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../models/subs_day_details_model.dart';
import 'package:amtech_design/models/subscription_create_request_model.dart'
    as create;
import 'package:amtech_design/models/subscription_modify_request_model.dart'
    as modify;
import 'package:amtech_design/models/subscription_summary_model.dart'
    as summary;

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

  //* onTap Calendar Date
  void onDaySelected({
    required DateTime selected,
    required DateTime focused,
    required String subsId,
  }) {
    selectedDay = selected;
    focusedDay = focused;
    debugPrint('selectedDate: $selected');
    debugPrint('focusedDate: $focused');
    //* Get the day name
    String dayName = DateFormat('EEEE').format(selectedDay);
    getSubsDayDetails(subsId: subsId, day: dayName); //* API call
    debugPrint('You tapped on $selectedDay, which is a $dayName');
    notifyListeners();
  }

  String getDayName(DateTime date) {
    return DateFormat('EEEE').format(date);
  }

  DateTime normalizeDate(DateTime date) =>
      DateTime(date.year, date.month, date.day);

  final Map<DateTime, Color> customDateColors = {
    DateTime.utc(2025, 4, 20): const Color(0xFFB9C9DD), // Total Jars
    DateTime.utc(2025, 4, 21): Colors.white, // Remaining
    DateTime.utc(2025, 4, 22): const Color(0xFF3B944D), // Delivered
    DateTime.utc(2025, 4, 23): const Color(0xFFE84D3F), // Postponed
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
  String? selectedTimeSlotValue;
  bool isDropdownOpen = false;

  final List<Map<String, String>> items = [
    {"label": "08:00AM To 09:00AM", "value": "08:00AM To 09:00AM"},
    {"label": "10:00AM To 11:00AM", "value": "10:00AM To 11:00AM"},
    {"label": "12:00PM To 01:00PM", "value": "12:00PM To 01:00PM"},
    {"label": "02:00PM To 03:00PM", "value": "02:00PM To 03:00PM"},
    {"label": "04:00PM To 05:00PM", "value": "04:00PM To 05:00PM"},
  ];

  //* onChanged Dropdown
  void setSelectedValue(String? value) {
    selectedTimeSlotValue = value;
    if (selectedTimeSlotValue != null) {
      updateOnlyTimeSlotForDay(
        day: getDayName(selectedDay),
        newTimeSlot: selectedTimeSlotValue!,
      );
    }
    log('selectedTimeSlotValue: $selectedTimeSlotValue');
    notifyListeners();
  }

  void setDropdownState(bool isOpen) {
    isDropdownOpen = isOpen;
    notifyListeners();
  }

  ApiService apiService = ApiService();
  bool isLoading = false;
  String? errorMsg;
  SubsDayDetails? dayDetailsRes;

  //* subs Day Details API
  Future getSubsDayDetails({
    required String subsId,
    required String day,
  }) async {
    isLoading = true;
    dayDetailsRes = null; // clear previous data before API call
    notifyListeners(); // notify UI about immediate clearing
    try {
      log('request body subsDayDetails: $subsId & $day');
      final res = await apiService.subsDayDetails(
        subsId: subsId,
        day: day, //'Monday'
      );
      if (res.success == true && res.data != null) {
        dayDetailsRes = res.data!.first;
        selectedTimeSlotValue = res.data?.first.timeSlot;
        log('Timeslot: ${res.data?.first.timeSlot}');
      } else {
        dayDetailsRes = null;
        log('${res.message}');
      }
    } on DioException catch (e) {
      dayDetailsRes = null;
      if (e.response != null && e.response?.data != null) {
        final data = e.response!.data;
        if (data is Map<String, dynamic> && data['message'] != null) {
          errorMsg = data['message'];
        }
      }
      log("Error subsDayDetails: ${e.toString()}");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // List<summary.SubscriptionItem> subsItem = [];
  List<modify.SubscriptionItem> subsItem = [];

  //* Update daywise subs Item
  void updateDayWiseSubsItem({
    required String menuId,
    List<modify.Size>? size,
    List<modify.Customization>? customize,
    List<modify.MealSubscription>? meals,
    required String day,
  }) {
    log('updateSubsItem called');
    // Find all items that match the day
    List<int> updateIndices = [];
    for (int i = 0; i < subsItem.length; i++) {
      if (subsItem[i].mealSubscription?.any((meal) => meal.day == day) ??
          false) {
        updateIndices.add(i);
      }
    }
    // Create the updated item
    final updatedItem = modify.SubscriptionItem(
      // menuId: menuId,
      menuIds: menuId,
      size: size,
      customize: customize,
      mealSubscription: meals,
    );
    if (updateIndices.isNotEmpty) {
      // Update all the items that match the day
      for (int index in updateIndices) {
        subsItem[index] = updatedItem;
      }
      log('subsItem: ${jsonEncode(subsItem.map((e) => e.toJson()).toList())}');
    } else {
      log('No item updated as no match for the day');
    }
    notifyListeners();
  }

  //* updateOnlyTimeSlotForDay
  void updateOnlyTimeSlotForDay({
    required String day,
    required String newTimeSlot,
  }) {
    log('updateOnlyTimeSlotForDay called for day: $day with new timeSlot: $newTimeSlot');
    bool isUpdated = false;
    for (var item in subsItem) {
      final mealList = item.mealSubscription;

      if (mealList != null) {
        for (var meal in mealList) {
          if (meal.day == day) {
            meal.timeSlot = newTimeSlot;
            isUpdated = true;
            log('Updated timeSlot for $day');
          }
        }
      }
    }
    if (isUpdated) {
      notifyListeners();
      log('Updated subsItem: ${jsonEncode(subsItem.map((e) => e.toJson()).toList())}');
    } else {
      log('No matching day found to update timeSlot.');
    }
  }
}
