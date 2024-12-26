import 'package:amtech_design/core/utils/constant.dart';
import 'package:amtech_design/custom_widgets/svg_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/utils/app_colors.dart';
import '../core/utils/strings.dart';
import '../routes.dart';
import 'buttons/custom_button_with_arrow.dart';
import 'product_size_widget.dart';

void showSizeModalBottomSheet({
  required BuildContext context,
  required String accountType,
}) {
  showModalBottomSheet(
    context: context,
    backgroundColor: getColorAccountType(
      accountType: accountType,
      businessColor: AppColors.primaryColor,
      personalColor: AppColors.darkGreenGrey,
    ),
    // isScrollControlled: true,
    builder: (context) {
      return Stack(
        clipBehavior: Clip.none, // Allow visible outside the bounds
        children: [
          Positioned(
            child: Container(
              padding: EdgeInsets.only(top: 19.h),
              height: 380.h,
              width: 1.sw,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'select size'.toUpperCase(),
                    style: GoogleFonts.publicSans(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: getColorAccountType(
                        accountType: accountType,
                        businessColor: AppColors.seaShell,
                        personalColor: AppColors.seaMist,
                      ),
                    ),
                  ),
                  SizedBox(height: 17.h),
                  ProductSizeWidget(
                    accountType: accountType,
                    size: 'regular',
                  ),
                  SizedBox(height: 9.h),
                  ProductSizeWidget(
                    accountType: accountType,
                    size: 'medium',
                  ),
                  SizedBox(height: 9.h),
                  ProductSizeWidget(
                    accountType: accountType,
                    size: 'large',
                  ),
                  SizedBox(height: 9.h),

                  // * Added to cart button
                  CustomButtonWithArrow(
                    onTap: () {
                      Navigator.pushNamed(context, Routes.cart);
                    },
                    accountType: accountType,
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: -40,
            right: 0,
            left: 0,
            child: IgnorePointer(
              ignoring: true,
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  debugPrint('Close pressed');
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
            ),
          ),
        ],
      );
    },
  );
}
