import 'package:amtech_design/core/utils/constants/keys.dart';
import 'package:amtech_design/services/local/shared_preferences_service.dart';
import 'package:flutter/foundation.dart';

class BottomBarProvider extends ChangeNotifier {
  int _selectedIndex = 0;
  int get selectedIndex => _selectedIndex;

  void updateIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }

  BottomBarProvider() {
    getCurrentAccountType();
  }

  bool isBottomBarVisible = true;

  void setBottomBarVisibility(bool isVisible) {
    if (isBottomBarVisible != isVisible) {
      isBottomBarVisible = isVisible;
      notifyListeners();
    }
  }

  String? selectedAccountType;
  getCurrentAccountType() {
    selectedAccountType =
        sharedPrefsService.getString(SharedPrefsKeys.accountType);
    return selectedAccountType;
  }

  setCurrentAccountType(String accountType) {
    sharedPrefsService.setString(SharedPrefsKeys.accountType, accountType);
    notifyListeners();
  }
}
