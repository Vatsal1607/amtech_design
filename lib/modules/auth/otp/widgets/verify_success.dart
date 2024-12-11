import 'package:amtech_design/core/utils/constant.dart';
import 'package:amtech_design/core/utils/strings.dart';
import 'package:amtech_design/custom_widgets/svg_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/constants/shared_prefs_keys.dart';
import '../../../../routes.dart';
import '../../../../services/local/shared_preferences_service.dart';

class VerifySuccess extends StatefulWidget {
  const VerifySuccess({super.key});

  @override
  State<VerifySuccess> createState() => _VerifySuccessState();
}

class _VerifySuccessState extends State<VerifySuccess> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        Navigator.pushReplacementNamed(context, Routes.bottomBarPage);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String accountType =
        sharedPrefsService.getString(SharedPrefsKeys.accountType) ?? '';
    return Scaffold(
      backgroundColor: getColorAccountType(
        accountType: accountType,
        businessColor: AppColors.primaryColor,
        personalColor: AppColors.darkGreenGrey,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgIcon(
              icon: IconStrings.otpVerified,
              color: getColorAccountType(
                accountType: accountType,
                businessColor: AppColors.disabledColor,
                personalColor: AppColors.bayLeaf,
              ),
            ),
            SizedBox(height: 10.h),
            SizedBox(
              width: 270.w,
              height: 120.h,
              child: Text(
                'Verified Successfully!',
                textAlign: TextAlign.center,
                style: GoogleFonts.publicSans(
                  fontSize: 40.sp,
                  color: AppColors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
