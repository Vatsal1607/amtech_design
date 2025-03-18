import 'dart:developer';
import 'package:amtech_design/core/utils/constants/keys.dart';
import 'package:amtech_design/models/add_to_cart_model.dart';
import 'package:amtech_design/models/add_to_cart_request_model.dart';
import 'package:amtech_design/models/home_menu_model.dart';
import 'package:amtech_design/services/local/shared_preferences_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../core/utils/enums/enums.dart';
import '../../core/utils/strings.dart';
import '../../models/api_global_model.dart';
import '../../models/get_banner_model.dart';
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

  int subscriptionCurrentIndex = 0;
  onPageChangedsubscription(index, reason) {
    subscriptionCurrentIndex = index;
    notifyListeners();
  }

  final List<String> subscriptionImages = [
    ImageStrings.salad,
    ImageStrings.salad,
  ];

  TextEditingController searchController = TextEditingController();

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

  // final List<String> banners = [
  //   ImageStrings.healthFirstBanner,
  //   ImageStrings.healthFirstBanner,
  // ];

  List<String> banners = [];
  List<BannersData> bannersData = [];

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

  void onSelectedMenuItem(String value) {
    selectedValue = value;
    isMenuOpen = false;
    notifyListeners();
    if (dynamicKeys.containsKey(value)) {
      scrollToSection(dynamicKeys[value]!);
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

  Map<String, GlobalKey> dynamicKeys = {}; // Store category keys dynamically

  void generateCategoryKeys(List<MenuCategories> categories) {
    for (var category in categories) {
      dynamicKeys[category.categoryTitle ?? ""] = GlobalKey();
    }
    notifyListeners(); // Update UI after keys are generated
  }

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

  final addressWidth = 290;
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

  double viewOrderBottomPadding = 28;
  bool isSnackBarVisible = false;
  updateSnackBarVisibility(value) {
    isSnackBarVisible = value;
    notifyListeners();
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  final ApiService apiService = ApiService();

  final requiredSizes = ['MEDIUM', 'LARGE', 'REGULAR'];
  MenuProvider() {
    quantities = {for (var size in requiredSizes) size: 0};

    // Initially set the filtered categories to the original categories
    filteredCategories = menuCategories ?? [];
    // Add listener for search functionality
    searchController.addListener(_filterSearchResults);
  }

  void _filterSearchResults() {
    String query = searchController.text.toLowerCase();
    // Filter categories based on the search query
    filteredCategories = (menuCategories ?? []).where((category) {
      // Filter categories by title
      bool categoryMatches =
          category.categoryTitle?.toLowerCase().contains(query) ?? false;
      // Filter products within the category
      bool productMatches = category.menuItems?.any((item) {
            return item.itemName?.toLowerCase().contains(query) ?? false;
          }) ??
          false;

      return categoryMatches || productMatches;
    }).toList();
    notifyListeners();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  List<MenuCategories> filteredCategories = []; // List for filtered categories
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
        filteredCategories = menuCategories ?? [];
        if (menuCategories != null) {
          generateCategoryKeys(menuCategories!);
        }
        log('Success: homeMenuApi: ${response.message.toString()}');
        return true; // * Indicat success
      } else {
        debugPrint('homeMenuApi Message: ${response.message}');
        return false; // * Indicat failure
      }
    } catch (error) {
      log("Error during homeMenuApi Response------- $error");
      if (error is DioException) {
        final apiError = ApiGlobalModel.fromJson(error.response?.data ?? {});
        log(apiError.message ?? 'An error occurred');
      } else {
        log('An unexpected error occurred');
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

  void decrementQuantity({
    required String sizeName,
    required String menuId,
    required String sizeId,
  }) {
    if ((quantities[sizeName] ?? 0) > 0) {
      quantities[sizeName] = (quantities[sizeName] ?? 0) - 1;
      log('decrementQuantity quantity: ${quantities[sizeName]}');
      notifyListeners();
    }
  }

  void incrementQuantity({
    required String sizeName,
    required String menuId,
    required String sizeId,
  }) {
    quantities[sizeName] = (quantities[sizeName] ?? 0) + 1;
    log('incrementQuantity quantity: ${quantities[sizeName]}');
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

  bool isLoadingGetBanner = false;
  // * getBanner API
  Future<void> getBanner() async {
    log('Get banner called');
    isLoadingGetBanner = true;
    notifyListeners();
    try {
      final res = await apiService.getBanner();
      log('getBanner: $res');
      if (res.success == true && res.data != null) {
        // Extracting image URLs from the response
        banners = res.data!
            .where((banner) =>
                banner.imageUrl != null && banner.imageUrl!.isNotEmpty)
            .map((banner) =>
                banner.imageUrl!.first) // Get the first image from each banner
            .toList();
        bannersData = res.data!
            .where((banner) =>
                banner.imageUrl != null && banner.imageUrl!.isNotEmpty)
            .toList();
      } else {
        log('${res.message}');
      }
    } catch (e) {
      debugPrint("Error fetching getBanner: ${e.toString()}");
    } finally {
      isLoadingGetBanner = false;
      notifyListeners();
    }
  }

  // * countBanner API
  Future<void> countBanner({
    required final String bannerId,
  }) async {
    try {
      final res = await apiService.countBanner(
        bannerId: bannerId,
      );
      log('countBanner: $res');
      if (res.success == true) {
        log('countBanner: ${res.message}');
      } else {
        log('${res.message}');
      }
    } catch (e) {
      debugPrint("Error fetching countBanner: ${e.toString()}");
    }
  }

  bool isLoadingAddToCart = false;
  Map<String, bool> loadingStates = {
    "MEDIUM": false,
    "LARGE": false,
    "REGULAR": false,
  };
  bool getIsLoadingStates(String size) => loadingStates[size] ?? false;
  void setLoading(String size, bool isLoading) {
    loadingStates[size] = isLoading;
    notifyListeners();
  }

  int cartSnackbarTotalItems = 0;
  String cartSnackbarItemText = '';
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  // * addToCart API
  Future<void> addToCart({
    required String menuId,
    required String sizeId,
    required Function(bool) callback, // Callback parameter
    required String size,
    List<RequestItems>? items,
    BuildContext? context,
  }) async {
    isLoadingAddToCart = true;
    setLoading(size, true);
    notifyListeners();
    try {
      final requestBody = AddToCartRequestModel(
        userId: sharedPrefsService.getString(SharedPrefsKeys.userId),
        items: items ??
            [
              RequestItems(
                menuId: menuId,
                quantity: 1,
                size: [
                  RequestSize(
                    sizeId: sizeId,
                  ),
                ],
              ),
            ],
      );
      final res = await apiService.addToCart(
        addToCartRequestBody: requestBody,
      );
      log('addToCart: ${res.data}');
      if (res.success == true) {
        callback(true); //* Notify success
        AddToCartModel addToCartResponse = res;
        List<Items> items = addToCartResponse.data!.cart!.items ?? [];
        //* Calculate total item count
        cartSnackbarTotalItems =
            items.fold(0, (sum, item) => sum + (item.quantity ?? 0));
        //* Extract unique item names
        List<String> itemNames =
            items.map((item) => item.itemName ?? '').toSet().toList();
        //* Format item names for display
        cartSnackbarItemText = itemNames.length > 2
            ? "${itemNames[0]}, ${itemNames[1]} & more"
            : itemNames.join(", ");
        log('cartSnackbarItemText: $cartSnackbarTotalItems');
        log('cartSnackbarItemText: $cartSnackbarItemText');

        //* Show Snackbar here using the GlobalKey
        // if (context != null) {
        //   scaffoldMessengerKey.currentState?.showSnackBar(
        //     cartSnackbarWidget(
        //       message: '$cartSnackbarTotalItems Items added',
        //       items: cartSnackbarItemText,
        //       context: context,
        //     ),
        //   );
        // } else {
        //   debugPrint('context is null');
        // }

        debugPrint('callback called');
      } else {
        log('${res.message}');
        callback(false); // Notify failure
      }
    } catch (e) {
      callback(false); // Notify failure on exception
      debugPrint("Error addToCart: ${e.toString()}");
    } finally {
      isLoadingAddToCart = false;
      setLoading(size, false);
      notifyListeners();
    }
  }

  bool isLoadingUpdateCart = false;
  // * UpdateCart API
  Future<void> updateCart({
    required String menuId,
    required String sizeId,
    required Function(bool) callback, // Callback parameter
    required String size,
  }) async {
    isLoadingUpdateCart = true;
    setLoading(size, true);
    notifyListeners();
    try {
      final requestBody = AddToCartRequestModel(
        userId: sharedPrefsService.getString(SharedPrefsKeys.userId),
        items: [
          RequestItems(
            menuId: menuId,
            quantity: 1,
            size: [
              RequestSize(
                sizeId: sizeId,
              ),
            ],
          ),
        ],
      );

      final res = await apiService.updateCart(
        updateCartRequestBody: requestBody,
      );
      log('updateCart: ${res.data}');
      if (res.success == true) {
        callback(true);
        AddToCartModel updateCartResponse = res;
        // log(updateCartResponse.data.toString());
      } else {
        callback(false);
        log('${res.message}');
      }
    } catch (e) {
      callback(false);
      debugPrint("Error UpdateCart: ${e.toString()}");
    } finally {
      isLoadingUpdateCart = false;
      setLoading(size, false);
      notifyListeners();
    }
  }

  HomeAddressType? selectedAddressType; // HomeAddressType.remote
  void updateHomeAddress(HomeAddressType type) {
    selectedAddressType = type;
    //* store locally
    sharedPrefsService.setString(
        SharedPrefsKeys.selectedAddressType, selectedAddressType?.name ?? '');
    log('selectedAddressType: ${selectedAddressType.toString()}');
    notifyListeners();
  }
}
