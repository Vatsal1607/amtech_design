import 'package:flutter/material.dart';

import '../../../core/utils/constants/keys.dart';
import '../../../services/local/shared_preferences_service.dart';

class LocationSelectionProvider extends ChangeNotifier {
  String? selectedLocation;
  String? accountType;

  void updateAccountType(String newAccountType) {
    sharedPrefsService.setString(SharedPrefsKeys.accountType, newAccountType);

    accountType = sharedPrefsService.getString(SharedPrefsKeys.accountType);
    debugPrint('Account type is: $accountType (update)');
    notifyListeners();
  }

  // @override
  // void dispose() {
  //   sharedPreferencesService.remove(SharedPreferencesKeys.accountType);
  //   super.dispose();
  // }

  clearSelectedLocation() {
    selectedLocation = null;
    notifyListeners();
  }

  final List<String> dropdownItems = [
    'Titanium City Center',
    'Arista Business Hub',
    'Silp Corporate Park',
    '323 Corporate Park',
  ];

  // final List<String> locations = [
  //   'Titanium City Center',
  //   'Arista Business Hub',
  //   'Silp Corporate Park',
  //   '323 Corporate Park',
  // ];

  TextEditingController locationSearchController = TextEditingController();
  void selectLocation(String? location) {
    selectedLocation = location;
    notifyListeners();
  }

  onChangeDropdown(String? newValue) {
    selectedLocation = newValue!;
    debugPrint(selectedLocation.toString());
    notifyListeners();
  }
}
