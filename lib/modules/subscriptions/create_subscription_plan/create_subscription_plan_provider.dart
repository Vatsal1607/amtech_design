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

  bool isSwitched = false;
  onToggleSwitch(val) {
    isSwitched = val;
    notifyListeners();
  }
}
