import 'dart:developer';
import 'package:flutter/material.dart';

class SelectMealBottomsheetProvider extends ChangeNotifier {
  //! Categorywise quantity
  // final Map<String, Map<int, int>> _categoryQuantities = {};
  final Map<String, Map<String, Map<int, int>>> _categoryQuantities = {};

  // int getQuantity(String category, int index) {
  //   log('_categoryQuantities: ${_categoryQuantities.toString()}');
  //   return _categoryQuantities[category]?[index] ?? 0;
  // }
  int getQuantity(String day, String meal, int index) {
    return _categoryQuantities[day]?[meal]?[index] ?? 0;
  }

  // void addMealItem(String itemName, int index) {
  //   _categoryQuantities.putIfAbsent(itemName, () => {});
  //   _categoryQuantities[itemName]![index] = 1;
  //   notifyListeners();
  // }
  void addMealItem(String day, String itemName, int index) {
    // Ensure the day entry exists
    _categoryQuantities.putIfAbsent(day, () => {});
    // Ensure the meal entry exists for the given day
    _categoryQuantities[day]!.putIfAbsent(itemName, () => {});
    // Add or update the item quantity
    _categoryQuantities[day]![itemName]![index] = 1;
    notifyListeners();
  }

  // void incrementMealItem(String itemName, int index) {
  //   if (_categoryQuantities.containsKey(itemName)) {
  //     _categoryQuantities[itemName]![index] =
  //         (_categoryQuantities[itemName]![index] ?? 0) + 1;
  //     notifyListeners();
  //   }
  // }
  void incrementMealItem(String day, String itemName, int index) {
    if (_categoryQuantities.containsKey(day) &&
        _categoryQuantities[day]!.containsKey(itemName)) {
      _categoryQuantities[day]![itemName]![index] =
          (_categoryQuantities[day]![itemName]![index] ?? 0) + 1;
      notifyListeners();
    }
  }

  // void decrementMealItem(String itemName, int index) {
  //   if (_categoryQuantities.containsKey(itemName) &&
  //       _categoryQuantities[itemName]!.containsKey(index)) {
  //     _categoryQuantities[itemName]![index] =
  //         (_categoryQuantities[itemName]![index]! - 1);

  //     if (_categoryQuantities[itemName]![index] == 0) {
  //       _categoryQuantities[itemName]!.remove(index);
  //     }

  //     notifyListeners();
  //   }
  // }
  void decrementMealItem(String day, String itemName, int index) {
    if (_categoryQuantities.containsKey(day) &&
        _categoryQuantities[day]!.containsKey(itemName) &&
        _categoryQuantities[day]![itemName]!.containsKey(index)) {
      _categoryQuantities[day]![itemName]![index] =
          (_categoryQuantities[day]![itemName]![index]! - 1);
      // Remove the item if the quantity reaches 0
      if (_categoryQuantities[day]![itemName]![index] == 0) {
        _categoryQuantities[day]![itemName]!.remove(index);
        // If the item map is empty after removal, remove the item itself
        if (_categoryQuantities[day]![itemName]!.isEmpty) {
          _categoryQuantities[day]!.remove(itemName);
          // If the day's map is empty after removal, remove the day itself
          if (_categoryQuantities[day]!.isEmpty) {
            _categoryQuantities.remove(day);
          }
        }
      }
      notifyListeners();
    }
  }
}
