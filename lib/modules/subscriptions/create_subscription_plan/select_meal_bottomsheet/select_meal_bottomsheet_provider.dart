import 'dart:developer';
import 'package:flutter/material.dart';

class SelectMealBottomsheetProvider extends ChangeNotifier {
  //! Categorywise quantity
  Map<String, Map<String, Map<int, int>>> categoryQuantities = {};

  int getQuantity(String day, String meal, int index) {
    return categoryQuantities[day]?[meal]?[index] ?? 0;
  }

  void addMealItem(String day, String itemName, int index) {
    // Ensure the day entry exists
    categoryQuantities.putIfAbsent(day, () => {});
    // Ensure the meal entry exists for the given day
    categoryQuantities[day]!.putIfAbsent(itemName, () => {});
    // Add or update the item quantity
    categoryQuantities[day]![itemName]![index] = 1;
    notifyListeners();
  }

  void incrementMealItem(String day, String itemName, int index) {
    if (categoryQuantities.containsKey(day) &&
        categoryQuantities[day]!.containsKey(itemName)) {
      categoryQuantities[day]![itemName]![index] =
          (categoryQuantities[day]![itemName]![index] ?? 0) + 1;
      notifyListeners();
    }
  }

  void decrementMealItem(String day, String itemName, int index) {
    if (categoryQuantities.containsKey(day) &&
        categoryQuantities[day]!.containsKey(itemName) &&
        categoryQuantities[day]![itemName]!.containsKey(index)) {
      categoryQuantities[day]![itemName]![index] =
          (categoryQuantities[day]![itemName]![index]! - 1);
      // Remove the item if the quantity reaches 0
      if (categoryQuantities[day]![itemName]![index] == 0) {
        categoryQuantities[day]![itemName]!.remove(index);
        // If the item map is empty after removal, remove the item itself
        if (categoryQuantities[day]![itemName]!.isEmpty) {
          categoryQuantities[day]!.remove(itemName);
          // If the day's map is empty after removal, remove the day itself
          if (categoryQuantities[day]!.isEmpty) {
            categoryQuantities.remove(day);
          }
        }
      }
      notifyListeners();
    }
  }
}
