import 'package:amtech_design/core/utils/strings.dart';
import 'package:amtech_design/custom_widgets/svg_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/utils/app_colors.dart';

void showSnackbar(BuildContext context, String message) {
  final snackBar = SnackBar(
    margin: EdgeInsets.zero,
    content: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              message,
              style: GoogleFonts.publicSans(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.white,
              ),
            ),
            SizedBox(width: 11.h),
            GestureDetector(
              onTap: () {
                debugPrint('Navigate to cart page');
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 15.w),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(100.r),
                ),
                child: SvgIcon(
                  icon: IconStrings.arrowNext,
                  color: AppColors.primaryColor,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 10.h),
        RichText(
          text: TextSpan(
              text: '{Item name} '.toUpperCase(),
              style: GoogleFonts.publicSans(
                fontSize: 10.sp,
                color: AppColors.disabledColor,
                fontWeight: FontWeight.bold,
              ),
              children: [
                TextSpan(
                  text: '& more',
                  style: GoogleFonts.publicSans(),
                ),
              ]),
        ),
      ],
    ),
    backgroundColor: AppColors.primaryColor,
    behavior: SnackBarBehavior.floating,
    duration: const Duration(days: 1),
    // margin: const EdgeInsets.all(16), // remove margin in fixed behaviour
    // shape: RoundedRectangleBorder(
    //   borderRadius: BorderRadius.circular(8),
    // ),
    // action: SnackBarAction(
    //   label: 'UNDO',
    //   textColor: Colors.blueAccent,
    //   onPressed: () {
    //     // Action when "UNDO" is pressed
    //     ScaffoldMessenger.of(context).hideCurrentSnackBar();
    //   },
    // ),
  );

  ScaffoldMessenger.of(context)
    ..clearSnackBars() // Clear any previous Snackbar to avoid stacking
    ..showSnackBar(snackBar);
}
