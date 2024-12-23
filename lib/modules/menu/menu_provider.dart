import 'package:flutter/material.dart';
import '../../core/utils/strings.dart';

class MenuProvider extends ChangeNotifier {
  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

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

  final PageController pageController = PageController();
  bool isVisibleSearchSpaceTop = false;
  bool onNotification(ScrollNotification scrollNotification) {
    if (scrollNotification.metrics.axis == Axis.vertical) {
      double scrollOffset = scrollNotification.metrics.pixels;
      // debugPrint('scrollOffset: $scrollOffset');
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
}
