import 'package:amtech_design/core/utils/strings.dart';
import 'package:amtech_design/custom_widgets/appbar/custom_appbar_with_center_title.dart';
import 'package:amtech_design/custom_widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import '../../core/utils/app_colors.dart';
import 'widgets/order_status_with_progress.dart';

class OrderStatusPage extends StatelessWidget {
  const OrderStatusPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbarWithCenterTitle(
        title: 'Order',
      ),
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 100.h),
            child: SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.only(left: 32.w, right: 32.w, bottom: 50.h),
                child: Column(
                  children: [
                    // * Lottie file
                    Lottie.asset(
                      LottieStrings.orderPlaced,
                    ),
                    Text(
                      "Your Order Has Been",
                      style: GoogleFonts.publicSans(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.sp,
                        color: AppColors.primaryColor,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      "Placed Successfully!",
                      style: GoogleFonts.publicSans(
                        fontWeight: FontWeight.bold,
                        fontSize: 30.sp,
                        color: AppColors.disabledColor,
                      ),
                    ),
                    SizedBox(height: 40.h),
                    // * Order status with progress indicator
                    const OrderStatusWithProgress(),
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
                  bgColor: AppColors.primaryColor,
                  onTap: () {
                    // Navigator.pop(context);
                  },
                  text: 'GO TO HOME',
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
