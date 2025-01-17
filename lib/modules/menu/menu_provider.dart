import 'dart:developer';
import 'package:amtech_design/core/utils/constants/keys.dart';
import 'package:amtech_design/models/home_menu_model.dart';
import 'package:amtech_design/services/local/shared_preferences_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../core/utils/strings.dart';
import '../../models/api_global_model.dart';
import '../../models/menu_size_model.dart';
import '../../services/network/api_service.dart';

class MenuProvider extends ChangeNotifier {
  double sliderCreditValue = 135;
  final double sliderTotalCreditValue = 2000;
  onChangeCreditSlider(double value) {
    sliderCreditValue = value;
    notifyListeners();
  }

  double currentSliderValue = 20;
  onChangeSlider(double value) {
    currentSliderValue = value;
    notifyListeners();
  }

  int carouselCurrentIndex = 0;
  onPageChangedCarousel(index, reason) {
    carouselCurrentIndex = index;
    notifyListeners();
  }

  bool isVisibleSearchSpaceTop = false;
  bool onNotification(ScrollNotification scrollNotification) {
    if (scrollNotification.metrics.axis == Axis.vertical) {
      double scrollOffset = scrollNotification.metrics.pixels;
      // * Define the specific area range
      if (scrollOffset > 220) {
        if (!isVisibleSearchSpaceTop) {
          isVisibleSearchSpaceTop = true;
          notifyListeners();
        }
      } else {
        if (isVisibleSearchSpaceTop) {
          isVisibleSearchSpaceTop = false;
          notifyListeners();
        }
      }
    }
    return true;
  }

  final List<String> banners = [
    ImageStrings.healthFirstBanner,
    ImageStrings.healthFirstBanner,
  ];

  final List<String> productImage = [
    ImageStrings.masalaTea2,
    ImageStrings.masalaTea2,
    ImageStrings.masalaTea2,
    ImageStrings.masalaTea2,
  ];

  final List<String> productName = [
    'everyday tea',
    'Zero suger coffee ',
    'tea w/o milk',
    'everyday tea',
  ];

  // * get dynamic greetings
  String getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return "Good Morning,";
    } else if (hour < 17) {
      return "Good Afternoon,";
    } else {
      return "Good Evening,";
    }
  }

  String? selectedValue;
  bool isMenuOpen = false;

  // * Menu items (Also values of items)
  List<String> menuItemsName = [
    'Tea',
    'Coffee',
    'Best Seller',
  ];

  onSelectedMenuItem(value) {
    selectedValue = value;
    isMenuOpen = false;
    notifyListeners();
    if (value == "Best Seller") {
      scrollToSection(bestSellerKey);
    } else if (value == "Tea") {
      scrollToSection(teaKey);
    } else if (value == "Coffee") {
      scrollToSection(coffeeKey);
    }
  }

  onCanceledMenuItem() {
    isMenuOpen = false;
    notifyListeners();
  }

  onOpenedMenuItem() {
    isMenuOpen = true;
    notifyListeners();
  }

  // * Create keys for each section
  final GlobalKey bestSellerKey = GlobalKey();
  final GlobalKey teaKey = GlobalKey();
  final GlobalKey coffeeKey = GlobalKey();

  // * Scroll to the section with its key
  void scrollToSection(GlobalKey sectionKey) {
    final context = sectionKey.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  // * Account Selection UI data
  double panelHeight = 0.0;
  final double panelMaxHeight = 235.0;

  onVerticalDragDownLeading() {
    panelHeight = panelMaxHeight;
    notifyListeners();
  }

  onTapOutsideAccountUI() {
    panelHeight = 0;
    notifyListeners();
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  final ApiService apiService = ApiService();

  final requiredSizes = ['MEDIUM', 'LARGE', 'REGULAR'];
  MenuProvider() {
    homeMenuApi();
    quantities = {for (var size in requiredSizes) size: 0};
  }

  HomeMenuModel? homeMenuResponse;
  List<MenuCategories>? menuCategories;
  // * HomeMenu API
  Future homeMenuApi({
    String? search,
  }) async {
    _isLoading = true;
    notifyListeners();
    try {
      String userId =
          sharedPrefsService.getString(SharedPrefsKeys.userId) ?? '';
      final accountType =
          sharedPrefsService.getString(SharedPrefsKeys.accountType);

      final HomeMenuModel response = await apiService.getHomeMenu(
        userId: userId,
        userType: accountType == 'business' ? 0 : 1,
        search: search,
      );
      log('homeMenuApi Response: ${response.data?.menuCategories}');
      if (response.success == true) {
        homeMenuResponse = response;
        menuCategories = response.data?.menuCategories;
        // menuItemsName =
        log('Success: homeMenuApi: ${response.message.toString()}');
        return true; // * Indicat success
      } else {
        debugPrint('homeMenuApi Message: ${response.message}');
        return false; // * Indicat failure
      }
    } catch (error) {
      log("Error during homeMenuApi Response: $error");
      if (error is DioException) {
        // Parse API error response
        final apiError = ApiGlobalModel.fromJson(error.response?.data ?? {});
        log(apiError.message ?? 'An error occurred');
        // customSnackBar(
        //   context: context,
        //   message: apiError.message ?? 'An error occurred',
        //   backgroundColor: AppColors.seaShell,
        //   textColor: AppColors.primaryColor,
        // );
      } else {
        // Handle unexpected errors
        log('An unexpected error occurred');
        // customSnackBar(
        //   context: context,
        //   message: 'An unexpected error occurred',
        //   backgroundColor: AppColors.seaShell,
        //   textColor: AppColors.primaryColor,
        // );
      }
    } finally {
      // Ensure loading state is reset
      _isLoading = false;
      notifyListeners();
    }
  }

  MenuSizeModel? menuSizeResponse;
  bool isLoadingSize = false;

  Map<String, int> quantities = {};

  void incrementQuantity(String sizeName) {
    quantities[sizeName] = (quantities[sizeName] ?? 0) + 1;
    log('incrementQuantity quantity: ${quantities[sizeName]}');
    notifyListeners();
  }

  void decrementQuantity(String sizeName) {
    quantities[sizeName] = (quantities[sizeName] ?? 0) - 1;
    log('decrementQuantity quantity: ${quantities[sizeName]}');
    notifyListeners();
  }

  // * getMenuSize API
  Future<void> getMenuSize({
    required String menuId,
  }) async {
    isLoadingSize = true;
    notifyListeners();
    try {
      final res = await apiService.getMenuSize(
        menuId: menuId,
      );
      log('getMenuSize: $res');
      if (res.success == true && res.data != null) {
        menuSizeResponse = res;
      } else {
        log('${res.message}');
      }
    } catch (e) {
      debugPrint("Error fetching menuSizeResponse: ${e.toString()}");
    } finally {
      isLoadingSize = false;
      notifyListeners();
    }
  }
}
