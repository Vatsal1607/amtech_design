import 'package:flutter/foundation.dart';
import '../../models/user_account_model.dart';

class AccountSwitcherProvider with ChangeNotifier {
  List<UserAccount> _accounts = [];
  UserAccount? _activeAccount;

  List<UserAccount> get accounts => _accounts;
  UserAccount? get activeAccount => _activeAccount;

  void setAccounts(List<UserAccount> accounts, {String? currentId}) {
    _accounts = accounts;
    _activeAccount = accounts.firstWhere((acc) => acc.id == currentId,
        orElse: () => accounts.first);
    notifyListeners();
  }

  void switchAccount(UserAccount account) {
    _activeAccount = account;
    notifyListeners();
    // Optionally persist this choice using SharedPreferences or secure storage
  }
}
