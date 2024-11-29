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
