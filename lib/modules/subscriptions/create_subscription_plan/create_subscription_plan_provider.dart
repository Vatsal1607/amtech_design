import 'dart:developer';

import 'package:flutter/material.dart';

class CreateSubscriptionPlanProvider extends ChangeNotifier {
  String? _selectedValue;
  bool _isDropdownOpen = false;

  final List<Map<String, String>> items = [
    {"label": "40 Units | ₹ 4999", "value": "40"},
    {"label": "6 Units | ₹ 799", "value": "6"},
    {"label": "25 Units | ₹ 2199", "value": "25"},
    {"label": "35 Units | ₹ 3499", "value": "35"},
  ];

  String? get selectedValue => _selectedValue ?? items.first["value"];
  bool get isDropdownOpen => _isDropdownOpen;

  void setSelectedValue(String? newValue) {
    _selectedValue = newValue;
    notifyListeners();
  }

  void setDropdownState(bool isOpen) {
    _isDropdownOpen = isOpen;
    notifyListeners();
  }

  Map<String, bool> switchStates = {}; // Holds switch states for each day
  void toggleSwitch(String day, bool value) {
    switchStates[day] = value;
    log('switchStates[$day] ${switchStates[day]}');
    notifyListeners();
  }

  final List<String> days = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday'
  ];

  // Map to track if each day's time slot dropdown is open
  Map<String, bool> isTimeslotDropdownOpen = {
    "Monday": false,
    "Tuesday": false,
    "Wednesday": false,
    "Thursday": false,
    "Friday": false,
    "Saturday": false,
    "Sunday": false,
  };

  // Handle dropdown open/close state for time slots (day-wise)
  void onMenuStateChange(String day, bool isOpen) {
    isTimeslotDropdownOpen[day] = isOpen;
    notifyListeners();
  }

  // Map to track if each day's day dropdown is open
  Map<String, bool> isDayDropdownOpen = {
    "Monday": false,
    "Tuesday": false,
    "Wednesday": false,
    "Thursday": false,
    "Friday": false,
    "Saturday": false,
  };

  // Handle dropdown open/close state for day selection (day-wise)
  void onDayDropdownMenuStateChange(String day, bool isOpen) {
    isDayDropdownOpen[day] = isOpen;
    notifyListeners();
  }

  void onChangedTimeslot(String day, String? newTime) {
    selectedTimeslots[day] = newTime;
    log('selectedTimeslots[day] ${selectedTimeslots[day]}');
    notifyListeners();
  }

  final List<String> timeSlots = [
    "08:00AM To 09:00AM",
    "10:00AM To 11:00AM",
    "12:00PM To 01:00PM"
  ];

  // * Map to store selected time slot for each day
  Map<String, String?> selectedTimeslots = {
    "Monday": '08:00AM To 09:00AM',
    "Tuesday": '08:00AM To 09:00AM',
    "Wednesday": '08:00AM To 09:00AM',
    "Thursday": '08:00AM To 09:00AM',
    "Friday": '08:00AM To 09:00AM',
    "Saturday": '08:00AM To 09:00AM',
  };
}
