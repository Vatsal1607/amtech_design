import 'package:amtech_design/core/utils/strings.dart';
import 'package:amtech_design/custom_widgets/svg_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/utils/app_colors.dart';

void customSnackBar({
  required BuildContext context,
  required String message,
  Color backgroundColor = Colors.black,
  Color textColor = Colors.white,
  IconData? icon,
  Duration duration = const Duration(seconds: 4),
}) {
  final snackBar = SnackBar(
    behavior: SnackBarBehavior.floating,
    backgroundColor: backgroundColor,
    duration: duration,
    margin: EdgeInsets.only(left: 32.w, right: 32.w, bottom: 100.h),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12.r),
    ),
    content: Row(
      children: [
        if (icon != null) ...[
          Icon(icon, color: textColor),
          SizedBox(width: 8.w),
        ],
        Expanded(
          child: Text(
            message,
            style: TextStyle(color: textColor),
          ),
        ),
      ],
    ),
  );

  ScaffoldMessenger.of(context)
    ..clearSnackBars()
    ..showSnackBar(snackBar);
}

// * Cart snackbar
void showCartSnackbar({
  required BuildContext context,
  required String message,
  required String items,
}) {
  final snackBar =
      cartSnackbarWidget(message: message, items: items, context: context);

  ScaffoldMessenger.of(context)
    ..clearSnackBars() // Clear any previous Snackbar to avoid stacking
    ..showSnackBar(snackBar);
}

//* extracted method of snackbar
SnackBar cartSnackbarWidget({
  required String message,
  required String items,
  required BuildContext context,
}) {
  return SnackBar(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(35.r),
    ),
    margin: EdgeInsets.only(
      bottom: 5.h,
      left: 22.h,
      right: 22.h,
    ),
    content: Stack(
      children: [
        Padding(
          padding: EdgeInsets.only(left: 10.w),
          child: Column(
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
                      padding:
                          EdgeInsets.symmetric(vertical: 6.h, horizontal: 15.w),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(100.r),
                      ),
                      child: const SvgIcon(
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
                    text: '$items '.toUpperCase(),
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
        ),
        Positioned(
          top: 0,
          right: 0,
          bottom: 0,
          child: GestureDetector(
            onTap: () {
              ScaffoldMessenger.of(context).clearSnackBars();
            },
            child: Container(
              height: 20.h,
              width: 20.w,
              decoration: const BoxDecoration(
                color: AppColors.red,
                shape: BoxShape.circle,
              ),
              child: const SvgIcon(
                icon: IconStrings.close,
              ),
            ),
          ),
        ),
      ],
    ),
    backgroundColor: AppColors.primaryColor,
    behavior: SnackBarBehavior.floating,
    duration: Duration.zero,
  );
}
