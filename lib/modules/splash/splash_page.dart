import 'package:amtech_design/routes.dart';
import 'package:amtech_design/services/local/device_info_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import '../../core/utils/app_colors.dart';
import '../../core/utils/constants/keys.dart';
import '../../core/utils/strings.dart';
import '../../services/local/shared_preferences_service.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        final isLoggedIn =
            sharedPrefsService.getBool(SharedPrefsKeys.isLoggedIn);
        if (isLoggedIn != null && isLoggedIn) {
          Navigator.pushReplacementNamed(context, Routes.bottomBarPage);
        } else {
          Navigator.pushReplacementNamed(context, Routes.accountSelection);
        }
      }
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
            ImageStrings.splashDoodle,
            height: 1.sh,
            width: 1.sw,
            fit: BoxFit.cover,
          ),
          Positioned.fill(
            child: Lottie.asset(
              LottieStrings.splashLottie,
              repeat: false,
            ),
          ),
        ],
      ),
    );
  }
}
