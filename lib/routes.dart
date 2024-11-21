import 'package:amtech_design/pages/auth/account_selection/account_selection_page.dart';
import 'package:amtech_design/pages/auth/location_selection/location_selection_page.dart';
import 'package:amtech_design/pages/bottom_bar/bottom_bar_page.dart';
import 'package:amtech_design/pages/splash/splash_page.dart';
import 'package:amtech_design/pages/welcome/welcome_page.dart';
// import 'package:amtech_design/pages/menu/menu_page.dart';
import 'package:flutter/material.dart';

import 'pages/product_page/product_page.dart';

class Routes {
  static const String initial = '/';
  static const String welcome = '/welcome';
  static const String accountSelection = '/accountSelection';
  static const String locationSelection = '/locationSelection';
  static const String bottomBarPage = '/bottomBarPage';
  static const String productPage = '/productPage`';
  static const String details = '/details';

  static final Map<String, WidgetBuilder> routes = {
    initial: (context) => const SplashPage(),
    welcome: (context) => const WelcomePage(),
    accountSelection: (context) => const AccountSelectionPage(),
    locationSelection: (context) => const LocationSelectionPage(),
    bottomBarPage: (context) => BottomBarPage(),
    productPage: (context) => const ProductPage(),
    details: (context) => const ProductPage(),
  };
}
