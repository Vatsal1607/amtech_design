import 'dart:developer';
import 'package:amtech_design/services/network/api_service.dart';
import 'package:flutter/material.dart';
import '../../../../models/ingredients_and_addons_model.dart';
import '../../../../models/subscription_create_request_model.dart'
    as subscription;

class IngredientsBottomsheetProvider extends ChangeNotifier {
  TextEditingController noteController = TextEditingController();
  ApiService apiService = ApiService();

  List<MenuDetail>? ingredientList;
  List<MenuDetail>? addOnsList;

  // Map<String, bool> ingredientSelections = {};
  Map<String, Map<String, bool>> ingredientSelections = {};

  // * Call this method after fetching data to set up the checkboxes.
  void initializeIngredientSelections() {
    ingredientSelections = {
      for (var ingredient in ingredientList ?? [])
        ingredient.id ?? '': {ingredient.name ?? '': true}
    };
    notifyListeners();
  }

  void onChangedCheckBox(bool? value, String id) {
    if (ingredientSelections.containsKey(id)) {
      final name = ingredientSelections[id]?.keys.first;
      ingredientSelections[id] = {name ?? '': value ?? false};
    }
    notifyListeners();
  }

  // Map<String, bool> addOnsSelections = {};
  Map<String, Map<String, bool>> addOnsSelections = {};

  Map<String, int> addOnsQuantity = {};

  void initializeAddOnsSelections() {
    addOnsSelections = {
      for (var addOn in addOnsList ?? [])
        addOn.id ?? '': {addOn.name ?? '': false}
    };
    addOnsQuantity = {for (var addOn in addOnsList ?? []) addOn.id ?? '': 1};
    notifyListeners();
  }

  void onChangedAddOnsCheckBox(bool? value, String id) {
    if (addOnsSelections.containsKey(id)) {
      final name = addOnsSelections[id]?.keys.first;
      addOnsSelections[id] = {name ?? '': value ?? false};
      addOnsQuantity[id] = value == true ? 1 : 0;
    }
    notifyListeners();
  }

  void addOnsIncrement(String key) {
    log('Increment button pressed for $key');
    // Initialize the quantity if not present
    if (!addOnsQuantity.containsKey(key)) {
      addOnsQuantity[key] = 1;
    } else {
      addOnsQuantity[key] = addOnsQuantity[key]! + 1;
    }
    // Ensure that the selection map follows the new structure
    if (addOnsSelections.containsKey(key)) {
      String name = addOnsSelections[key]!.keys.first;
      addOnsSelections[key] = {name: true};
    } else {
      // Initialize selection if the key doesn't exist
      addOnsSelections[key] = {'default': true}; // Adjust 'default' as needed
    }
    notifyListeners();
  }

  void addOnsDecrement(String key) {
    log('Decrement button pressed for $key');
    if (addOnsQuantity.containsKey(key) && addOnsQuantity[key]! > 1) {
      addOnsQuantity[key] = addOnsQuantity[key]! - 1;
    } else {
      addOnsQuantity.remove(key);
      if (addOnsSelections.containsKey(key)) {
        String name = addOnsSelections[key]!.keys.first;
        addOnsSelections[key] = {name: false};
      }
    }
    notifyListeners();
  }

  void addAddOnsItem(String key) {
    log('Add button pressed for $key');

    if (addOnsSelections.containsKey(key)) {
      String name = addOnsSelections[key]!.keys.first;
      addOnsSelections[key] = {name: true};
    } else {
      addOnsSelections[key] = {'default': true}; // Adjust 'default' as needed
    }

    // Update the quantity map only if not already set to 1
    if (addOnsQuantity[key] == null || addOnsQuantity[key] == 0) {
      addOnsQuantity[key] = 1;
    }
    notifyListeners();
  }
  // void addAddOnsItem(String key) {
  //   log('Add button pressed for $key');
  //   if (addOnsSelections.containsKey(key)) {
  //     String name = addOnsSelections[key]!.keys.first;
  //     addOnsSelections[key] = {name: true};
  //   } else {
  //     addOnsSelections[key] = {'default': true}; // Adjust 'default' as needed
  //   }
  //   // Update the quantity map
  //   addOnsQuantity[key] = (addOnsQuantity[key] ?? 0) + 1;
  //   notifyListeners();
  // }

  // * Get selected ingredients for API
  List<subscription.Ingredient> getSelectedIngredients() {
    return ingredientSelections.entries
        .where((entry) => entry.value.values.first == true)
        .map((entry) => subscription.Ingredient(ingredientId: entry.key))
        .toList();
  }

  // * Get selected add-ons for API
  List<subscription.AddOn> getSelectedAddOns() {
    return addOnsSelections.entries
        .where((entry) => entry.value.values.first == true)
        .map((entry) => subscription.AddOn(
              addOnId: entry.key,
              quantity: addOnsQuantity[entry.key] ?? 1,
            ))
        .toList();
  }

  // * Get customization object for API
  subscription.Customization getCustomization() {
    return subscription.Customization(
      ingredients: getSelectedIngredients(),
      addOns: getSelectedAddOns(),
    );
  }

  bool isLoading = false;

  // * getIngredientsAndAddOns API
  Future<void> getIngredientsAndAddOns({
    required final String menuId,
  }) async {
    isLoading = true;
    try {
      final res = await apiService.getIngredientsAndAddOns(
        menuId: menuId,
      );
      log('getIngredientsAndAddOns: $res');
      if (res.success == true) {
        ingredientList = res.data?.ingredientDetails;
        addOnsList = res.data?.addOnDetails;
        initializeIngredientSelections(); // set up the checkboxes.
        initializeAddOnsSelections(); // set up the checkboxes.
        log('getIngredientsAndAddOns: ${res.message}');
      } else {
        log('${res.message}');
      }
    } catch (e) {
      debugPrint("Error fetching getIngredientsAndAddOns: ${e.toString()}");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
