import 'package:flutter/material.dart';

class BusinessSelectionProvider extends ChangeNotifier {
  String? dropdownValue;

  final List<String> dropdownItems = [
    'AMTech Design',
    'AMTech Design 2',
    'AMTech Design 3',
  ];

  onChangeDropdown(String? newValue) {
    dropdownValue = newValue!;
    debugPrint(dropdownValue.toString());
    notifyListeners();
  }
}
