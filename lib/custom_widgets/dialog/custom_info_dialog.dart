import 'package:amtech_design/core/utils/constant.dart';
import 'package:amtech_design/custom_widgets/buttons/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../core/utils/app_colors.dart';

void showCustomInfoDialog({
  required BuildContext context,
  required String accountType,
  String title = 'Service Not Available',
  required String message,
  String buttonText = 'CHANGE LOCATION',
  VoidCallback? onTap,
}) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return WillPopScope(
        onWillPop: () async => false,
        child: AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.r),
          ),
          contentPadding: EdgeInsets.all(20.r),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: GoogleFonts.publicSans(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.sp,
                    color: getColorAccountType(
                      accountType: accountType,
                      businessColor: AppColors.primaryColor,
                      personalColor: AppColors.darkGreenGrey,
                    )),
              ),
              SizedBox(height: 10.h),
              Text(
                message,
                textAlign: TextAlign.center,
                style: GoogleFonts.publicSans(
                    fontSize: 14.sp,
                    color: getColorAccountType(
                      accountType: accountType,
                      businessColor: AppColors.primaryColor,
                      personalColor: AppColors.darkGreenGrey,
                    )),
              ),
              SizedBox(height: 20.h),
              CustomButton(
                height: 48.h,
                onTap: onTap ??
                    () {
                      Navigator.pop(context);
                    },
                text: buttonText,
                textColor: getColorAccountType(
                  accountType: accountType,
                  businessColor: AppColors.seaShell,
                  personalColor: AppColors.seaMist,
                ),
                bgColor: getColorAccountType(
                  accountType: accountType,
                  businessColor: AppColors.primaryColor,
                  personalColor: AppColors.darkGreenGrey,
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
