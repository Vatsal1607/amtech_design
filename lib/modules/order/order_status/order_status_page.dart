import 'package:amtech_design/core/utils/constant.dart';
import 'package:amtech_design/core/utils/strings.dart';
import 'package:amtech_design/custom_widgets/appbar/custom_appbar_with_center_title.dart';
import 'package:amtech_design/custom_widgets/buttons/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import '../../../core/utils/app_colors.dart';
import '../../../routes.dart';
import 'widgets/order_status_with_progress.dart';

class OrderStatusPage extends StatelessWidget {
  const OrderStatusPage({super.key});

  @override
  Widget build(BuildContext context) {
    String accountType = 'business'; // Todo imp set dynamic
    // sharedPrefsService.getString(SharedPrefsKeys.accountType) ?? '';
    return Scaffold(
      backgroundColor: getColorAccountType(
        accountType: accountType,
        businessColor: AppColors.seaShell,
        personalColor: AppColors.seaMist,
      ),
      appBar: CustomAppbarWithCenterTitle(
        accountType: accountType,
        title: 'Order',
      ),
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 80.h),
            child: SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.only(left: 32.w, right: 32.w, bottom: 50.h),
                child: Column(
                  children: [
                    // * Lottie file
                    SizedBox(
                      height: 340.h,
                      child: Lottie.asset(
                        accountType == 'business'
                            ? LottieStrings.orderPlaced
                            : LottieStrings.orderPlacedPersonal,
                      ),
                    ),
                    Text(
                      "Your Order Has Been",
                      style: GoogleFonts.publicSans(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.sp,
                        color: getColorAccountType(
                          accountType: accountType,
                          businessColor: AppColors.primaryColor,
                          personalColor: AppColors.darkGreenGrey,
                        ),
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      "Placed Successfully!",
                      style: GoogleFonts.publicSans(
                        fontWeight: FontWeight.bold,
                        fontSize: 30.sp,
                        color: getColorAccountType(
                          accountType: accountType,
                          businessColor: AppColors.disabledColor,
                          personalColor: AppColors.bayLeaf,
                        ),
                      ),
                    ),
                    SizedBox(height: 40.h),
                    // * Order status with progress indicator
                    OrderStatusWithProgressWidget(
                      accountType: accountType,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(left: 32.w, right: 32.w, bottom: 48.h),
                child: CustomButton(
                  height: 55.h,
                  bgColor: getColorAccountType(
                    accountType: accountType,
                    businessColor: AppColors.primaryColor,
                    personalColor: AppColors.darkGreenGrey,
                  ),
                  onTap: () {
                    Navigator.popUntil(
                        context, ModalRoute.withName(Routes.bottomBarPage));
                  },
                  text: 'GO TO HOME',
                  textColor: getColorAccountType(
                    accountType: accountType,
                    businessColor: AppColors.seaShell,
                    personalColor: AppColors.seaMist,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
