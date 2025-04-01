import 'package:flutter/material.dart';

class SelectMealBottomsheetProvider extends ChangeNotifier {
  //! Categorywise quantity
  final Map<String, Map<int, int>> _categoryQuantities = {};

  int getQuantity(String category, int index) {
    return _categoryQuantities[category]?[index] ?? 0;
  }

  void addItem(String category, int index) {
    _categoryQuantities.putIfAbsent(category, () => {});
    _categoryQuantities[category]![index] = 1;
    notifyListeners();
  }

  void increment(String category, int index) {
    if (_categoryQuantities.containsKey(category)) {
      _categoryQuantities[category]![index] =
          (_categoryQuantities[category]![index] ?? 0) + 1;
      notifyListeners();
    }
  }

  void decrement(String category, int index) {
    if (_categoryQuantities.containsKey(category) &&
        _categoryQuantities[category]!.containsKey(index)) {
      _categoryQuantities[category]![index] =
          (_categoryQuantities[category]![index]! - 1);

      if (_categoryQuantities[category]![index] == 0) {
        _categoryQuantities[category]!.remove(index);
      }

      notifyListeners();
    }
  }
}
