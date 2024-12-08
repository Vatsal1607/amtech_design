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
      debugPrint('scrollOffset: $scrollOffset');
      // Define the specific area range
      if (scrollOffset > 230) {
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
  //

  final List<String> banners = [
    ImageStrings.masalaTeaBanner,
    ImageStrings.navratiBanner,
  ];

  final List<String> productImage = [
    ImageStrings.masalaTea3,
    ImageStrings.masalaTea3,
    ImageStrings.masalaTea3,
    ImageStrings.masalaTea3,
    // ImageStrings.bestSeller2,
    // ImageStrings.bestSeller3,
    // ImageStrings.bestSeller1,
  ];

  final List<String> productName = [
    'everyday tea',
    'Zero suger coffee ',
    'tea w/o milk',
    'everyday tea',
  ];
}
