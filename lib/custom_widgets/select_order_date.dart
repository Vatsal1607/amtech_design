import 'package:amtech_design/core/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/utils/app_colors.dart';

class SelectOrderDateWidget extends StatelessWidget {
  final String accountType;
  // final String text;
  final String selectedDate;
  final VoidCallback? onTap;
  const SelectOrderDateWidget({
    super.key,
    required this.accountType,
    // required this.text,
    required this.selectedDate,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 40.h,
        // width: 185.w,
        decoration: BoxDecoration(
          color: getColorAccountType(
            accountType: accountType,
            businessColor: AppColors.primaryColor,
            personalColor: AppColors.darkGreenGrey,
          ),
          borderRadius: BorderRadius.circular(100.r),
        ),
        child: Center(
          child: Text(
            // '9/12/2024',
            selectedDate,
            style: GoogleFonts.publicSans(
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
              // color: AppColors.seaShell,
              color: getColorAccountType(
                accountType: accountType,
                businessColor: AppColors.seaShell,
                personalColor: AppColors.seaMist,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// OLD UI start date Row
/// Row(
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      // children: [
        // Text(
        //   text.toUpperCase(),
        //   style: GoogleFonts.publicSans(
        //     fontSize: 14.sp,
        //     color: getColorAccountType(
        //       accountType: accountType,
        //       businessColor: AppColors.primaryColor,
        //       personalColor: AppColors.darkGreenGrey,
        //     ),
        //   ),
        // ),
        // SizedBox(width: 20.w),