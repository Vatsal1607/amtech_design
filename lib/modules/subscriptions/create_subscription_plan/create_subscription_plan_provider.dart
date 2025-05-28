import 'dart:developer';
import 'package:amtech_design/core/utils/constants/keys.dart';
import 'package:amtech_design/custom_widgets/snackbar.dart';
import 'package:amtech_design/models/subscription_create_request_model.dart';
import 'package:amtech_design/modules/subscriptions/create_subscription_plan/ingredients_bottomsheet/ingredients_bottomsheet_provider.dart';
import 'package:amtech_design/services/local/shared_preferences_service.dart';
import 'package:amtech_design/services/network/api_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../models/get_all_units_model.dart';
import '../../../models/subscription_modify_request_model.dart' as modify;
import '../../../models/timeslot_day_model.dart';
import '../../../routes.dart';

class CreateSubscriptionPlanProvider extends ChangeNotifier {
  String? _selectedValue;
  bool _isDropdownOpen = false;

  List<UnitItem> unitItems = [];

  bool isLoadingUnits = false;

  Future getAllUnits() async {
    isLoadingUnits = true;
    notifyListeners();
    try {
      final res = await apiService.getAllUnits();
      if (res.success == true && res.data != null) {
        //* Assign data to the item
        unitItems = res.data ?? [];
        selectedUnits = res.data?.first.value ?? '0';
        log('initial selectedPrice ${res.data?.first.price}');
        selectedPrice =
            double.tryParse(res.data?.first.price?.toString() ?? '') ?? 0.0;
      } else {
        log('${res.message}');
      }
    } on DioException catch (e) {
      if (e.response != null && e.response?.data != null) {
        final data = e.response!.data;
        if (data is Map<String, dynamic> && data['message'] != null) {
          log(data['message']);
        }
      }
      log("Error getAllUnits: ${e.toString()}");
    } finally {
      isLoadingUnits = false;
      notifyListeners();
    }
  }

  String? get selectedValue => _selectedValue ?? unitItems.first.value;
  bool get isDropdownOpen => _isDropdownOpen;

  String selectedUnits = '';
  double selectedPrice = 0;

  void setSelectedValue(String? newValue) {
    _selectedValue = newValue;
    final selectedItem = unitItems.firstWhere(
      (item) => item.value == newValue,
      orElse: () => UnitItem(label: '', value: '0', price: '0.0'),
    );
    selectedUnits = selectedItem.value ?? '0';
    if (selectedItem.price != null && selectedItem.price!.isNotEmpty) {
      selectedPrice = double.tryParse(selectedItem.price ?? '0') ?? 0.0;
    } else {
      selectedPrice = 0.0;
    }
    notifyListeners();
  }

  void setDropdownState(bool isOpen) {
    _isDropdownOpen = isOpen;
    notifyListeners();
  }

  Map<String, bool> switchStates = {}; // Holds switch states for each day

  void toggleSwitch(String day, bool value, BuildContext context) {
    switchStates[day] = value;
    if (!value) {
      addOrUpdateDayWiseSelectedItem(day, '');
      // Remove the item if the switch is set to inactive
      subsItems.removeWhere((item) =>
          item.mealSubscription?.any((meal) => meal.day == day) ?? false);
      log('Removed subscription for $day Need to Reselect Meal details while its Active again!');
      // snackbar
      customSnackBar(
        context: context,
        message:
            'Removed subscription for $day Need to Reselect Meal details while its Active again!',
      );
    }
    log('Updated subsItems subsItems.length: ${subsItems.length}');
    notifyListeners();
  }

  final List<String> days = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday'
  ];

  Map<String, bool> isTimeslotDropdownOpen = {
    "Monday": false,
    "Tuesday": false,
    "Wednesday": false,
    "Thursday": false,
    "Friday": false,
    "Saturday": false,
    "Sunday": false,
  };

  void onMenuStateChange(String day, bool isOpen) {
    isTimeslotDropdownOpen[day] = isOpen;
    notifyListeners();
  }

  Map<String, bool> isDayDropdownOpen = {
    "Monday": false,
    "Tuesday": false,
    "Wednesday": false,
    "Thursday": false,
    "Friday": false,
    "Saturday": false,
  };

  void onDayDropdownMenuStateChange(String day, bool isOpen) {
    isDayDropdownOpen[day] = isOpen;
    notifyListeners();
  }

  final List<String> timeSlots = [
    "08:00AM To 09:00AM",
    "10:00AM To 11:00AM",
    "12:00PM To 01:00PM",
    "02:00PM To 03:00PM",
    "04:00PM To 05:00PM"
  ];

  // Multiple timeslots
  Map<String, Map<int, String?>> selectedTimeSlots = {
    "Monday": {0: "08:00AM To 09:00AM"},
    "Tuesday": {0: "08:00AM To 09:00AM"},
    "Wednesday": {0: "08:00AM To 09:00AM"},
    "Thursday": {0: "08:00AM To 09:00AM"},
    "Friday": {0: "08:00AM To 09:00AM"},
    "Saturday": {0: "08:00AM To 09:00AM"},
  };

  String getSelectedTimeSlot(String day, int mealIndex) {
    final timeSlots = selectedTimeSlots[day];
    if (timeSlots != null && mealIndex < timeSlots.values.length) {
      return timeSlots.values.elementAt(mealIndex) ?? '';
    }
    return ''; // Return an empty string if not found
  }

  void onTapTimeSlot(String day, int mealIndex, String? value) {
    if (!selectedTimeSlots.containsKey(day)) {
      selectedTimeSlots[day] = {};
    }
    selectedTimeSlots[day]![mealIndex] = value;
    log('selectedTimeSlots[day]: ${selectedTimeSlots[day]}');
    notifyListeners();
  }

  // Default timeslot for each day
  final String defaultTimeSlot = "08:00AM To 09:00AM";
  // Store day-wise selected time slots and meals
  Map<String, TimeSlotDayModel> selectedPlan = {};

  // * Add Meal & remove meal
  Map<String, List<String>> selectedMeals = {}; // Track meals per day

  initializeDay(String day) {
    if (!selectedMeals.containsKey(day)) {
      selectedMeals[day] = ["Select Meal"]; // Ensure at least one meal
      log('selectedMeals[day]: ${selectedMeals[day]}');
    }
  }

  // Initialize all days with default timeslot and empty meal list
  initializeAllDays() {
    for (String day in [
      "Monday",
      "Tuesday",
      "Wednesday",
      "Thursday",
      "Friday",
      "Saturday"
    ]) {
      selectedPlan[day] = TimeSlotDayModel(
        selectedTimeSlot: defaultTimeSlot,
        meals: [],
      );
    }
  }

  void addMeal(String day) {
    log('Selected meal is: $selectedMeals');
    if (!selectedMeals.containsKey(day)) {
      selectedMeals[day] = ["Select Meal"];
    }
    selectedMeals[day]!.add("Select Meal");
    notifyListeners();
  }

  void removeMeal(String day, int index) {
    if (selectedMeals.containsKey(day) && selectedMeals[day]!.length > 1) {
      selectedMeals[day]!.removeAt(index);

      if (selectedTimeSlots.containsKey(day) &&
          selectedTimeSlots[day]!.containsKey(index)) {
        selectedTimeSlots[day]!.remove(index);
      }

      if (selectedTimeSlots.containsKey(day)) {
        Map<int, String> updatedSlots = {};
        int newIndex = 0;

        selectedTimeSlots[day]!.forEach((key, value) {
          if (key != index) {
            updatedSlots[newIndex] = value ?? "";
            newIndex++;
          }
        });

        selectedTimeSlots[day] = updatedSlots;
      }

      notifyListeners();
    }
  }

  Map<String, String> daywiseSelectedItem = {}; // To store day-wise item names

  // * Note: Pass an empty string to remove
  void addOrUpdateDayWiseSelectedItem(String day, String itemName) {
    if (itemName.isNotEmpty) {
      // Add or update the item for the given day
      daywiseSelectedItem[day] = itemName;
      log('Added/Updated: $day -> $itemName');
    } else {
      // Remove the item if itemName is empty
      daywiseSelectedItem.remove(day);
      log('Removed: $day');
    }
    log('Current Day-wise Items: $daywiseSelectedItem');
    notifyListeners();
  }

  ApiService apiService = ApiService();
  bool isLoading = false;
  String? subsId;

  // * SubscriptionCreate API
  Future<void> subscriptionCreate(BuildContext context) async {
    isLoading = true;
    try {
      String userId =
          sharedPrefsService.getString(SharedPrefsKeys.userId) ?? '';
      String accountType =
          sharedPrefsService.getString(SharedPrefsKeys.accountType) ?? '';
      // * Request data
      final requestData = SubscriptionCreateRequestModel(
        userId: userId,
        userType: accountType == 'business' ? 'BusinessUser' : 'User',
        items: subsItems, //* Subscription itemList
        price: selectedPrice,
        units: selectedUnits,
        paymentStatus: false,
      );

      log('requestData: ${requestData.price}');
      final res = await apiService.subscriptionCreate(
        subscriptionCreateRequestData: requestData,
      );
      log('subscriptionCreate: $res');
      if (res.success == true) {
        subsId = res.data?.sId; //! Subscription ID
        // subsItems.clear(); //* Clear subsItem list on subc create
        Navigator.pushNamed(context, Routes.subscriptionSummary);
      } else {
        log('${res.message}');
      }
    } catch (e) {
      log("Error subscriptionCreate: ${e.toString()}");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  //! Subscription variables
  List<SubscriptionItem> subsItems = [];

  void addSubsItem({
    required String menuId,
    Size? size,
    List<MealSubscription>? meals,
    List<Customization>? customize,
    String? notes,
  }) {
    log('addSubsItem called');
    subsItems.add(
      SubscriptionItem(
        menuIds: menuId,
        size: size,
        mealSubscription: meals,
        customize: customize,
        notes: notes,
      ),
    );
    notifyListeners();
  }

  void updateSubsItem({
    required String menuId,
    Size? size,
    List<MealSubscription>? meals,
    List<Customization>? customize,
    required String day,
    String? notes,
  }) {
    // Find the index of the item to update based on the day
    int updateIndex = subsItems.indexWhere((item) =>
        item.mealSubscription?.any((meal) => meal.day == day) ?? false);

    if (updateIndex != -1) {
      // Update the existing item if day matches
      subsItems[updateIndex] = SubscriptionItem(
        menuIds: menuId,
        size: size,
        mealSubscription: meals,
        customize: customize,
        notes: notes,
      );
    } else {
      // Add a new item if no matching day is found
      subsItems.add(
        SubscriptionItem(
          menuIds: menuId,
          size: size,
          mealSubscription: meals,
          customize: customize,
        ),
      );
    }
    notifyListeners();
  }

  void removeItem(int index) {
    if (index >= 0 && index < subsItems.length) {
      subsItems.removeAt(index);
      notifyListeners();
    }
  }

  void clearItems() {
    // items.clear();
    unitItems.clear();
    notifyListeners();
  }

  // Set items
  void setSubsItems(List<SubscriptionItem> newItems) {
    subsItems = newItems;
    notifyListeners();
  }

  //* isUpdate or isCreate Subscription
  bool isUpdateSubscription = false;
  void setUpdateSubscription(bool value) {
    isUpdateSubscription = value;
    log('isUpdate subscription: $isUpdateSubscription');
    notifyListeners();
  }

  bool isLoadingSubsUpdate = false;

  // * SubscriptionUpdate API
  Future subscriptionUpdate({
    required BuildContext context,
    DateTime? createdAtDate,
    String? deliveryAddress,
    bool isModifySubsItem = false,
    List<modify.SubscriptionItem>? modifySubsItem, //* for Modify subscription
    String? modifySubsId,
  }) async {
    isLoadingSubsUpdate = true;
    try {
      String userId =
          sharedPrefsService.getString(SharedPrefsKeys.userId) ?? '';
      String accountType =
          sharedPrefsService.getString(SharedPrefsKeys.accountType) ?? '';
      final ingredientsProvider =
          Provider.of<IngredientsBottomsheetProvider>(context, listen: false);

      // ! Request data (SubscriptionCreateRequestModel)
      final requestData = SubscriptionCreateRequestModel(
        userId: userId,
        userType: accountType == 'business' ? 'BusinessUser' : 'User',
        items: subsItems,
        price: selectedPrice,
        units: selectedUnits,
        paymentStatus: false,
        createdAt: createdAtDate,
        deliveryAddress: deliveryAddress,
      );
      // ! Request data (SubscriptionModifyRequestModel)
      final requestModifyData = modify.SubscriptionModifyRequestModel(
        userId: userId,
        userType: accountType == 'business' ? 'BusinessUser' : 'User',
        items: modifySubsItem,
        price: selectedPrice,
        units: selectedUnits,
        notes: ingredientsProvider.noteController.text,
        paymentMethod: 'paymentMethod',
        paymentStatus: true,
        createdAt: createdAtDate,
        deliveryAddress: deliveryAddress,
      );
      final res = isModifySubsItem
          ? await apiService.subscriptionModify(
              subsId: modifySubsId ?? '',
              subscriptionModifyRequestModel: requestModifyData,
            )
          : await apiService.subscriptionUpdate(
              subsId: subsId ?? '',
              subscriptionUpdateRequestData: requestData,
            );
      if (res.success == true) {
        if (isModifySubsItem) {
          customSnackBar(context: context, message: '${res.message}');
        } else {
          if (createdAtDate == null && deliveryAddress == null) {
            context
                .read<CreateSubscriptionPlanProvider>()
                .setUpdateSubscription(false); // isUpadte: False
            Navigator.pushNamed(context, Routes.subscriptionSummary);
          }
        }
        return true; // * success
      } else {
        log('${res.message}');
        return false; // * failure
      }
    } catch (e) {
      log("Error subscriptionUpdate: ${e.toString()}");
      return false; // * failure
    } finally {
      isLoadingSubsUpdate = false;
      notifyListeners();
    }
  }
}
