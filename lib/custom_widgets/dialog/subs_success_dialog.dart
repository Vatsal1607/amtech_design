import 'package:amtech_design/core/utils/constants/keys.dart';
import 'package:amtech_design/core/utils/strings.dart';
import 'package:amtech_design/services/local/shared_preferences_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

void showSubscriptionSuccessDialog(BuildContext context) {
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        final String accountType =
            sharedPrefsService.getString(SharedPrefsKeys.accountType) ?? '';
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
          backgroundColor: Colors.white,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Lottie.asset(
                accountType == 'business'
                    ? LottieStrings.orderPlaced
                    : LottieStrings.orderPlacedPersonal,
                width: 150.w,
                height: 150.h,
              ),
              Text(
                'Subscription Successful!',
                style: GoogleFonts.publicSans(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.green[700],
                ),
              ),
              SizedBox(height: 10.h),
              Text(
                "Thank you for your love and trust! 💚 Your payment was successful, and your subscription is now active. Let the journey begin!",
                textAlign: TextAlign.center,
                style: GoogleFonts.publicSans(fontSize: 14.sp),
              ),
              SizedBox(height: 10.h),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context); // Close dialog
                  // Navigator.pop(context); // Go back to home or previous screen
                },
                child: const Text(
                  'Continue',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              )
            ],
          ),
        );
      });
}
