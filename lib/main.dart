import 'package:amtech_design/core/utils/app_colors.dart';
import 'package:amtech_design/modules/auth/login/login_provider.dart';
import 'package:amtech_design/modules/product_page/product_details_provider.dart';
import 'package:amtech_design/modules/welcome/welcome_provider.dart';
import 'package:amtech_design/services/local/shared_preferences_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'modules/auth/business_register/register_provider.dart';
import 'modules/auth/business_selection/business_selection_provider.dart';
import 'modules/auth/location_selection/location_selection_provider.dart';
import 'modules/auth/otp/otp_provider.dart';
import 'modules/bottom_bar/bottom_bar_provider.dart';
import 'modules/menu/menu_provider.dart';
import 'routes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  sharedPrefsService.init();
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
      ],
      child: ScreenUtilInit(
        designSize: const Size(430, 932), // Base screen size (width x height)
        minTextAdapt: true,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: '135 Degrees',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
            scaffoldBackgroundColor: AppColors.seaShell,
            // Snackbar global theme
            snackBarTheme: const SnackBarThemeData(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.zero, // Removes border radius
              ),
            ),
          ),
          // home: VerifySuccess(), //! temp route for dev, change to routes
          initialRoute: Routes.initial,
          routes: Routes.routes,
        ),
      ),
    );
  }
}
