import 'package:amtech_design/core/utils/app_colors.dart';
import 'package:amtech_design/modules/auth/login/login_provider.dart';
import 'package:amtech_design/modules/favorite/favorite_provider.dart';
import 'package:amtech_design/modules/notification/notification_provider.dart';
import 'package:amtech_design/modules/product_page/product_details_provider.dart';
import 'package:amtech_design/modules/welcome/welcome_provider.dart';
import 'package:amtech_design/services/local/shared_preferences_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'core/utils/app_globals.dart';
import 'modules/bottom_bar/account_switcher_provider.dart';
import 'modules/bottom_bar/bottom_bar_page.dart';
import 'modules/order/order_list/order_list_provider.dart';
import 'modules/subscriptions/create_subscription_plan/ingredients_bottomsheet/ingredients_bottomsheet_provider.dart';
import 'modules/subscriptions/create_subscription_plan/select_meal_bottomsheet/select_meal_bottomsheet_provider.dart';
import 'modules/auth/business_register/register_provider.dart';
import 'modules/auth/business_selection/business_selection_provider.dart';
import 'modules/auth/location_selection/location_selection_provider.dart';
import 'modules/auth/otp/otp_provider.dart';
import 'modules/authorized_emp/authorized_emp_provider.dart';
import 'modules/billing/billing_provider.dart';
import 'modules/bottom_bar/bottom_bar_provider.dart';
import 'modules/cart/cart_provider.dart';
import 'modules/feedback/feedback_provider.dart';
import 'modules/map/address/saved_address/saved_address_provider.dart';
import 'modules/map/google_map_provider.dart';
import 'modules/menu/menu_provider.dart';
import 'modules/notification/notification_service.dart';
import 'modules/order/order_status/order_status_provider.dart';
import 'modules/profile/edit_profile/edit_profile_provider.dart';
import 'modules/profile/profile_provider.dart';
import 'modules/provider/socket_provider.dart';
import 'modules/ratings/ratings_provider.dart';
import 'modules/recharge/recharge_provider.dart';
import 'modules/reorder/reorder_provider.dart';
import 'modules/subscriptions/create_subscription_plan/create_subscription_plan_provider.dart';
import 'modules/subscriptions/subscription/subscription_details/subscription_details_provider.dart';
import 'modules/subscriptions/subscription/subscription_provider.dart';
import 'modules/subscriptions/subscription_cart/subscription_cart_provider.dart';
import 'modules/subscriptions/subscription_summary/subscription_summary_provider.dart';
import 'routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  await sharedPrefsService.init();
  await Firebase.initializeApp();
  await NotificationService.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => BottomBarProvider()),
        ChangeNotifierProvider(create: (_) => MenuProvider()),
        ChangeNotifierProvider(create: (_) => WelcomeProvider()),
        ChangeNotifierProvider(create: (_) => LocationSelectionProvider()),
        ChangeNotifierProvider(create: (_) => BusinessSelectionProvider()),
        ChangeNotifierProvider(create: (_) => LoginProvider()),
        ChangeNotifierProvider(create: (_) => OtpProvider()),
        ChangeNotifierProvider(create: (_) => ProductDetailsProvider()),
        ChangeNotifierProvider(create: (_) => RegisterProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => ReorderProvider()),
        ChangeNotifierProvider(create: (_) => RechargeProvider()),
        ChangeNotifierProvider(create: (_) => OrderStatusProvider()),
        ChangeNotifierProvider(create: (_) => AuthorizedEmpProvider()),
        ChangeNotifierProvider(create: (_) => RatingsProvider()),
        ChangeNotifierProvider(create: (_) => FavoritesProvider()),
        ChangeNotifierProvider(create: (_) => FeedbackProvider()),
        ChangeNotifierProvider(create: (_) => ProfileProvider()),
        ChangeNotifierProvider(create: (_) => EditProfileProvider()),
        ChangeNotifierProvider(create: (_) => SocketProvider()),
        ChangeNotifierProvider(create: (_) => BillingProvider()),
        ChangeNotifierProvider(create: (_) => GoogleMapProvider()),
        ChangeNotifierProvider(create: (_) => SavedAddressProvider()),
        ChangeNotifierProvider(create: (_) => NotificationProvider()),
        ChangeNotifierProvider(create: (_) => CreateSubscriptionPlanProvider()),
        ChangeNotifierProvider(create: (_) => SelectMealBottomsheetProvider()),
        ChangeNotifierProvider(create: (_) => SubscriptionSummaryProvider()),
        ChangeNotifierProvider(create: (_) => IngredientsBottomsheetProvider()),
        ChangeNotifierProvider(create: (_) => SubscriptionCartProvider()),
        ChangeNotifierProvider(create: (_) => SubscriptionDetailsProvider()),
        ChangeNotifierProvider(create: (_) => SubscriptionProvider()),
        ChangeNotifierProvider(create: (_) => OrderListProvider()),
        ChangeNotifierProvider(create: (_) => AccountSwitcherProvider()),
      ],
      child: ScreenUtilInit(
        designSize: const Size(430, 932), // Base screen size (width x height)
        minTextAdapt: true,
        child: Consumer<MenuProvider>(
          builder: (context, menuProvider, child) => MaterialApp(
            navigatorKey: navigatorKey,
            debugShowCheckedModeBanner: false,
            title: '135 Degrees',
            scaffoldMessengerKey: menuProvider.scaffoldMessengerKey,
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
              scaffoldBackgroundColor: AppColors.seaShell,
              snackBarTheme: const SnackBarThemeData(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero,
                ),
              ),
            ),
            // home: BottomBarPage(),
            initialRoute: Routes.initial,
            routes: Routes.routes,
            // onGenerateRoute: (settings) {},
          ),
        ),
      ),
    );
  }
}
