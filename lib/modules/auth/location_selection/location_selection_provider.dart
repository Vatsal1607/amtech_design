import 'package:flutter/material.dart';

import '../../../core/utils/constants/keys.dart';
import '../../../services/local/shared_preferences_service.dart';

class LocationSelectionProvider extends ChangeNotifier {
  String? selectedLocation;
  String? accountType;

  void updateAccountType(String newAccountType) {
    sharedPreferencesService.setString(
        SharedPreferencesKeys.accountType, newAccountType);

    accountType =
        sharedPreferencesService.getString(SharedPreferencesKeys.accountType);
    debugPrint('Account type is: $accountType (update)');
    notifyListeners();
  }

  // @override
  // void dispose() {
  //   sharedPreferencesService.remove(SharedPreferencesKeys.accountType);
  //   super.dispose();
  // }

  final List<String> dropdownItems = [
    'Titanium City Center',
    'Arista Business Hub',
    'Silp Corporate Park',
    '323 Corporate Park',
  ];

  onChangeDropdown(String? newValue) {
    selectedLocation = newValue!;
    debugPrint(selectedLocation.toString());
    notifyListeners();
  }
}
