import 'dart:developer';

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

  final Map<String, bool> ingredients = {
    "Watermelon": true,
    "Muskmelon": true,
    "Pineapple": true,
    "Grapes": true,
    "Apple": true,
    "Orange": true,
    "Dragon Fruit": true,
    "Kiwi": true,
    "Strawberry": true,
  };

  onChangedCheckBox(bool? value, String key) {
    ingredients[key] = value!;
    notifyListeners();
  }

  //* AddOns
  Map<String, bool> addOns = {
    "Orange Juice": false,
    "Watermelon Juice": false,
    "ABC DETOX Juice": false,
    "Apple Juice": false,
    "Banana Shake": false,
    "Mango Milk Shake": false,
  };

  Map<String, int> addOnsQuantity = {
    "Orange Juice": 1,
    "Watermelon Juice": 1,
    "ABC DETOX Juice": 1,
    "Apple Juice": 1,
    "Banana Shake": 1,
    "Mango Milk Shake": 1,
  };

  onChangedAddOnsCheckBox(bool? value, String key) {
    addOns[key] = value ?? false;
    if (addOns[key] == true) {
      // If checked, set quantity to 1 if it was null
      addOnsQuantity[key] = addOnsQuantity[key] ?? 1;
    }
    notifyListeners();
  }

  void addAddOnsItem(String key) {
    log('Add button pressed for $key');

    addOns[key] = true; // Mark as selected
    addOnsQuantity[key] = 1; // Initialize quantity to 1 if not already set
    notifyListeners(); // Notify UI to update
  }

  void addOnsIncrement(String key) {
    log('addOnsIncrement called');
    addOnsQuantity[key] = addOnsQuantity[key]! + 1;
    notifyListeners();
  }

  void addOnsDecrement(String key) {
    log('addOnsDecrement called');
    if (addOnsQuantity.containsKey(key) && addOnsQuantity[key]! > 1) {
      addOnsQuantity[key] = addOnsQuantity[key]! - 1;
    } else {
      addOnsQuantity.remove(key); // Remove if it reaches zero
      addOns[key] = false; // Also uncheck the checkbox
    }
    notifyListeners();
  }
}
