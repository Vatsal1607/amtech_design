import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../core/utils/constants/keys.dart';
import '../../../services/local/shared_preferences_service.dart';

class LocationSelectionProvider extends ChangeNotifier {
  String? selectedLocation;
  String? accountType;

  void updateAccountType(String newAccountType) {
    sharedPrefsService.setString(SharedPrefsKeys.accountType, newAccountType);
    accountType = sharedPrefsService.getString(SharedPrefsKeys.accountType);
    notifyListeners();
  }

  clearSelectedLocation() {
    selectedLocation = null;
    notifyListeners();
  }

  bool isSearchOpen = false;
  onTapSearch() {
    isSearchOpen = true;
    notifyListeners();
  }

  onItemTap() {
    isSearchOpen = false;
    notifyListeners();
  }

  final List<String> locations = [
    'Titanium City Center',
    'Arista Business Hub',
    'Silp Corporate Park',
    '323 Corporate Park',
  ];

  SearchController searchController = SearchController();
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
