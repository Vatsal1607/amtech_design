import 'package:amtech_design/modules/about_us/about_us_page.dart';
import 'package:amtech_design/modules/auth/account_selection/account_selection_page.dart';
import 'package:amtech_design/modules/auth/location_selection/location_selection_page.dart';
import 'package:amtech_design/modules/auth/login/login_page.dart';
import 'package:amtech_design/modules/auth/otp/otp_page.dart';
import 'package:amtech_design/modules/bottom_bar/bottom_bar_page.dart';
import 'package:amtech_design/modules/cart/cart_page.dart';
import 'package:amtech_design/modules/favorite/favorite_page.dart';
import 'package:amtech_design/modules/feedback/feedback_page.dart';
import 'package:amtech_design/modules/map/address/saved_address/saved_address_page.dart';
import 'package:amtech_design/modules/notification/notification_page.dart';
import 'package:amtech_design/modules/order/order_list/order_list_page.dart';
import 'package:amtech_design/modules/profile/edit_profile/edit_profile_page.dart';
import 'package:amtech_design/modules/ratings/ratings_page.dart';
import 'package:amtech_design/modules/splash/splash_page.dart';
import 'package:amtech_design/modules/welcome/welcome_page.dart';
import 'package:flutter/material.dart';
import 'modules/auth/business_register/register_page.dart';
import 'modules/auth/business_selection/business_selection_page.dart';
import 'modules/auth/otp/widgets/verify_success_page.dart';
import 'modules/authorized_emp/authorized_emp_page.dart';
import 'modules/map/google_map_page.dart';
import 'modules/order/order_status/order_status_page.dart';
import 'modules/product_page/product_details_page.dart';
import 'modules/profile/profile_page.dart';
import 'modules/recharge/recharge_page.dart';
import 'modules/subscriptions/create_subscription_plan/create_subscription_plan.dart';

class Routes {
  static const String initial = '/';
  static const String welcome = '/welcome';
  static const String accountSelection = '/accountSelection';
  static const String locationSelection = '/locationSelection';
  static const String bottomBarPage = '/bottomBarPage';
  static const String productDetails = '/productDetailsPage`';
  static const String companySelection = '/companySelection';
  static const String login = '/login';
  static const String otp = '/otp';
  static const String register = '/register';
  static const String verifySuccess = '/verifySuccess';
  static const String profile = '/profile';
  static const String editProfile = '/editProfile';
  static const String cart = '/cart';
  static const String recharge = '/rechargePage';
  static const String orderList = '/orderList';
  static const String orderStatus = '/orderStatus';
  static const String authorizedEmp = '/authorizedEmp';
  static const String notification = '/notification';
  static const String ratings = '/ratings';
  static const String favoriteItems = '/favoriteItems';
  static const String feedback = '/feedback';
  static const String aboutUs = '/aboutUs';
  static const String googleMapPage = '/googleMapPage';
  static const String savedAddress = '/savedAddress';
  static const String createSubscriptionPlan = '/createSubscriptionPlan';

  static final Map<String, WidgetBuilder> routes = {
    initial: (context) => const SplashPage(),
    welcome: (context) => const WelcomePage(),
    accountSelection: (context) => const AccountSelectionPage(),
    locationSelection: (context) => const LocationSelectionPage(),
    bottomBarPage: (context) => BottomBarPage(),
    productDetails: (context) => const ProductDetailsPage(),
    companySelection: (context) => const BusinessSelectionPage(),
    login: (context) => const LoginPage(),
    otp: (context) => const OtpPage(),
    register: (context) => const RegisterPage(),
    verifySuccess: (context) => const VerifySuccessPage(),
    profile: (context) => const ProfilePage(),
    editProfile: (context) => const EditProfilePage(),
    cart: (context) => const CartPage(),
    recharge: (context) => const RechargePage(),
    orderList: (context) => const OrderListPage(),
    orderStatus: (context) => const OrderStatusPage(),
    authorizedEmp: (context) => AuthorizedEmpPage(),
    notification: (context) => const NotificationPage(),
    ratings: (context) => const RatingsPage(),
    favoriteItems: (context) => const FavoritePage(),
    feedback: (context) => const FeedbackPage(),
    aboutUs: (context) => const AboutUsPage(),
    googleMapPage: (context) => const GoogleMapPage(),
    savedAddress: (context) => const SavedAddressPage(),
    createSubscriptionPlan: (context) => const CreateSubscriptionPlanPage(),
  };
}
