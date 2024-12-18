import 'package:amtech_design/modules/auth/account_selection/account_selection_page.dart';
import 'package:amtech_design/modules/auth/location_selection/location_selection_page.dart';
import 'package:amtech_design/modules/auth/login/login_page.dart';
import 'package:amtech_design/modules/auth/otp/otp_page.dart';
import 'package:amtech_design/modules/bottom_bar/bottom_bar_page.dart';
import 'package:amtech_design/modules/cart/cart_page.dart';
import 'package:amtech_design/modules/splash/splash_page.dart';
import 'package:amtech_design/modules/welcome/welcome_page.dart';
// import 'package:amtech_design/pages/menu/menu_page.dart';
import 'package:flutter/material.dart';

import 'modules/auth/business_register/register_page.dart';
import 'modules/auth/business_selection/business_selection_page.dart';
import 'modules/auth/otp/widgets/verify_success.dart';
import 'modules/order_status/order_status_page.dart';
import 'modules/product_page/product_details_page.dart';
import 'modules/profile/profile_page.dart';
import 'modules/razorpay/razorpay_page.dart';
import 'modules/recharge/recharge_page.dart';

class Routes {
  static const String initial = '/';
  static const String welcome = '/welcome';
  static const String accountSelection = '/accountSelection';
  static const String locationSelection = '/locationSelection';
  static const String bottomBarPage = '/bottomBarPage';
  static const String productPage = '/productPage`';
  static const String details = '/details';
  static const String companySelection = '/companySelection';
  static const String login = '/login';
  static const String otp = '/otp';
  static const String register = '/register';
  static const String verifySuccess = '/verifySuccess';
  static const String profile = '/profile';
  static const String cart = '/cart';
  static const String recharge = '/rechargePage';
  static const String orderStatusPage = '/orderStatusPage';
  static const String razorPayPage = '/razorPayPage';

  static final Map<String, WidgetBuilder> routes = {
    initial: (context) => const SplashPage(),
    welcome: (context) => const WelcomePage(),
    accountSelection: (context) => const AccountSelectionPage(),
    locationSelection: (context) => const LocationSelectionPage(),
    bottomBarPage: (context) => BottomBarPage(),
    productPage: (context) => const ProductDetailsPage(),
    details: (context) => const ProductDetailsPage(),
    companySelection: (context) => const BusinessSelectionPage(),
    login: (context) => const LoginPage(),
    otp: (context) => const OtpPage(),
    register: (context) => const RegisterPage(),
    verifySuccess: (context) => const VerifySuccess(),
    profile: (context) => const ProfilePage(),
    cart: (context) => const CartPage(),
    recharge: (context) => const RechargePage(),
    orderStatusPage: (context) => const OrderStatusPage(),
    razorPayPage: (context) => const RazorPayPage(),
  };
}
