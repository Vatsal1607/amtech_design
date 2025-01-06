import 'package:amtech_design/routes.dart';
import 'package:amtech_design/services/local/device_info_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../core/utils/app_colors.dart';
import '../../core/utils/constants/keys.dart';
import '../../core/utils/strings.dart';
import '../../services/local/shared_preferences_service.dart';
import '../firebase/firebase_provider.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        final isLoggedIn =
            sharedPrefsService.getBool(SharedPrefsKeys.isLoggedIn);
        if (isLoggedIn != null && isLoggedIn) {
          Navigator.pushReplacementNamed(context, Routes.bottomBarPage);
        } else {
          Navigator.pushReplacementNamed(context, Routes.accountSelection);
        }
      }
      // Navigator.pushReplacementNamed(context, Routes.bottomBarPage);
    });
  }

  @override
  Widget build(BuildContext context) {
    DeviceInfoService().fetchDeviceId(context);
    FocusScope.of(context).unfocus();

    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Stack(
        children: [
          Image.asset(
            // ImageStrings.cartDoodle,
            ImageStrings.splashScreenImg,
            height: 1.sh,
            width: 1.sw,
          ),
          // Center(
          //   child: Image.asset(
          //     width: 250.w,
          //     height: 73.h,
          //     ImageStrings.appLogo,
          //   ),
          // ),
        ],
      ),
    );
  }
}
