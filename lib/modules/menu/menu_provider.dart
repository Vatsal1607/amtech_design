import 'package:flutter/material.dart';
import '../../core/utils/strings.dart';

class MenuProvider extends ChangeNotifier {
  // late ScrollController scrollController;

  // MenuProvider() {
  //   scrollController = ScrollController();
  //   scrollController.addListener(_restrictScroll);
  // }

  // void _restrictScroll() {
  //   // Limit scroll so that the sticky header is always visible above 150px
  //   if (scrollController.offset > 150.0) {
  //     scrollController.jumpTo(150.0); // Restrict scrolling beyond 150px
  //   }
  // }

  @override
  void dispose() {
    // scrollController.removeListener(_restrictScroll);
    // scrollController.dispose();
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
