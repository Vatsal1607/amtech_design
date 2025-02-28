import 'package:amtech_design/core/utils/constant.dart';
import 'package:amtech_design/custom_widgets/buttons/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../core/utils/app_colors.dart';

void showNotServiceableDialog({
  required BuildContext context,
  required String accountType,
}) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.r),
        ),
        contentPadding: EdgeInsets.all(20.r),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "NOT SERVICEABLE!",
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
              "Sorry, We Are Currently Not Available To Your Selected Location.",
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
              onTap: () {
                Navigator.pop(context);
              },
              text: "CHANGE LOCATION",
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
      );
    },
  );
}
