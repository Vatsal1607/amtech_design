import 'package:amtech_design/core/utils/strings.dart';
import 'package:amtech_design/custom_widgets/custom_confirm_dialog.dart';
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
  bool? isTop,
}) {
  final snackBar = SnackBar(
    behavior: SnackBarBehavior.floating,
    backgroundColor: backgroundColor,
    duration: duration,
    margin: EdgeInsets.only(
      left: 32.w,
      right: 32.w,
      bottom: isTop == null ? 100.h : 1.sh * 8,
    ),
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
            style: GoogleFonts.publicSans(color: textColor),
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
  String accountType = 'business',
}) {
  return SnackBar(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(35.r),
    ),
    margin: EdgeInsets.only(
      bottom: 8.h,
      left: 22.h,
      right: 22.h,
    ),
    content: Stack(
      children: [
        Padding(
          padding: EdgeInsets.only(left: 10.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                  // SizedBox(width: 11.h),
                ],
              ),
              Container(color: Colors.amber, child: SizedBox(height: 6.h)),
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
                        text: '& MORE',
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
          child: Row(
            children: [
              //* Arrow icon
              GestureDetector(
                onTap: () {
                  debugPrint('Navigate to cart page');
                },
                child: Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 9.h, horizontal: 15.w),
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
              SizedBox(width: 12.w),
              GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => CustomConfirmDialog(
                      title: 'Confirmation',
                      subTitle: 'Are You Sure Want To Empty Cart?',
                      accountType: accountType,
                      onTapYes: () {
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).clearSnackBars();
                      },
                      onTapCancel: () {
                        Navigator.pop(context);
                      },
                    ),
                  );
                },
                child: Container(
                  height: 30.h,
                  width: 30.w,
                  decoration: const BoxDecoration(
                    color: AppColors.red,
                    shape: BoxShape.circle,
                  ),
                  child: const SvgIcon(
                    icon: IconStrings.close,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
    backgroundColor: AppColors.primaryColor,
    behavior: SnackBarBehavior.floating,
    duration: const Duration(days: 1),
  );
}
