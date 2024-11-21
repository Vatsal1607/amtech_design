import 'package:amtech_design/pages/welcome/widgets/welcome_build_pages.dart';
import 'package:flutter/material.dart';
import '../../core/utils/app_colors.dart';
import '../../core/utils/strings.dart';

class WelcomeProvider extends ChangeNotifier {
  final PageController pageController = PageController();

  final List<Widget> welcomePages = [
    const WelcomeBuildPages(
      image: ImageStrings.welcome1,
      title: 'Brew\nthe\nPerfect\nBreak.',
      subTitle: 'Your perfect cup is just a tap away.',
    ),
    const WelcomeBuildPages(
      image: ImageStrings.welcome2,
      title: 'Savor\nClean,\nSip\nFresh.',
      titleColor: AppColors.deepGreen,
      subTitle: 'Every sip as pure as your work ethic.',
    ),
    const WelcomeBuildPages(
      image: ImageStrings.welcome3,
      title: 'Seamless\nOrdering,\nSwift\nDelivery.',
      titleColor: AppColors.ironStone,
      subTitle: 'Because every minute counts.',
    ),
  ];

  int _currentPage = 0;

  int get currentPage => _currentPage;

  // Method to update current page
  void updatePage(int page) {
    debugPrint('Current page is: ${page.toString()}');
    _currentPage = page;
    notifyListeners();
  }

  @override
  void dispose() {
    pageController.dispose(); // Don't forget to dispose the controller
    super.dispose();
  }
}
