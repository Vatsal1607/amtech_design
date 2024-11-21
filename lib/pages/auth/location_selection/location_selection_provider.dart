import 'package:flutter/material.dart';

class LocationSelectionProvider extends ChangeNotifier {
  String? dropdownValue;

  onChangeDropdown(String? newValue) {
    dropdownValue = newValue!;
    debugPrint(dropdownValue.toString());
    notifyListeners();
  }
}
