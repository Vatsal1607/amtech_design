import 'package:flutter/material.dart';
import '../../core/utils/constants/keys.dart';
import '../../core/utils/strings.dart';
import '../../services/local/shared_preferences_service.dart';

class MenuProvider extends ChangeNotifier {
  // String accountType = '';
  // MenuProvider() {
  //   accountType =
  //       sharedPreferencesService.getString(SharedPreferencesKeys.accountType) ??
  //           '';
  //   debugPrint('$accountType is from menu provider');
  // }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  double currentSliderValue = 20;

  onChangeSlider(double value) {
    currentSliderValue = value;
    notifyListeners();
  }

  final PageController pageController = PageController();

  final List<String> banners = [
    ImageStrings.bannerImage,
    ImageStrings.bannerImage,
    ImageStrings.bannerImage,
  ];

  final List<String> productImage = [
    ImageStrings.bestSeller1,
    ImageStrings.bestSeller2,
    ImageStrings.bestSeller3,
    ImageStrings.bestSeller1,
  ];

  final List<String> productName = [
    'everyday tea',
    'Zero suger c',
    'tea w/o milk',
    'everyday tea',
  ];
}
