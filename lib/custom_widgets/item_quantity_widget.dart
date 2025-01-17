import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/utils/app_colors.dart';
import '../core/utils/constant.dart';
import '../core/utils/strings.dart';
import 'svg_icon.dart';

class ItemQuantityWidget extends StatelessWidget {
  final int quantity;
  final VoidCallback? onIncrease;
  final VoidCallback? onDecrease;
  final Color color;
  final String accountType;
  final bool isDisabled;
  const ItemQuantityWidget({
    super.key,
    required this.quantity,
    required this.onIncrease,
    required this.onDecrease,
    this.color = AppColors.primaryColor,
    required this.accountType,
    this.isDisabled = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // * Minus button
        GestureDetector(
          onTap: onDecrease,
          child: Container(
            height: 30.h,
            width: 30.w,
            decoration: BoxDecoration(
              color: getColorAccountType(
                accountType: accountType,
                businessColor: AppColors.primaryColor,
                personalColor: AppColors.darkGreenGrey,
              ),
              shape: BoxShape.circle,
            ),
            child: SvgIcon(
              icon: IconStrings.minus,
              color: isDisabled
                  ? AppColors.white.withOpacity(.5)
                  : AppColors.white,
            ),
          ),
        ),
        SizedBox(width: 10.w),
        Text(
          '$quantity',
          style: GoogleFonts.publicSans(
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
            color: getColorAccountType(
              accountType: accountType,
              businessColor: AppColors.primaryColor,
              personalColor: AppColors.darkGreenGrey,
            ),
          ),
        ),
        SizedBox(width: 10.w),
        // * Plus button
        GestureDetector(
          onTap: onIncrease,
          child: Container(
            height: 30.h,
            width: 30.w,
            decoration: BoxDecoration(
              color: getColorAccountType(
                accountType: accountType,
                businessColor: AppColors.primaryColor,
                personalColor: AppColors.darkGreenGrey,
              ),
              shape: BoxShape.circle,
            ),
            child: SvgIcon(
              icon: IconStrings.plus,
              color: isDisabled
                  ? AppColors.white.withOpacity(.5)
                  : AppColors.white,
            ),
          ),
        ),
      ],
    );
  }
}
