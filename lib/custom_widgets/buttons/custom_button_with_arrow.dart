import 'package:amtech_design/custom_widgets/loader/custom_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/utils/app_colors.dart';
import '../../core/utils/constant.dart';
import '../../core/utils/strings.dart';
import '../svg_icon.dart';

class CustomButtonWithArrow extends StatelessWidget {
  final String accountType;
  final VoidCallback onTap;
  final bool isMargin;
  final String? text;
  final String? totalQty;
  final bool isLoading;
  const CustomButtonWithArrow({
    super.key,
    required this.accountType,
    required this.onTap,
    this.isMargin = true,
    this.text,
    this.totalQty,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 55.h,
        margin: isMargin ? EdgeInsets.symmetric(horizontal: 32.w) : null,
        padding: EdgeInsets.symmetric(horizontal: 22.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40.r),
          color: AppColors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            text != null
                ? Text(
                    text!,
                    style: GoogleFonts.publicSans(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: getColorAccountType(
                        accountType: accountType,
                        businessColor: AppColors.primaryColor,
                        personalColor: AppColors.darkGreenGrey,
                      ),
                    ),
                  )
                : Row(
                    children: [
                      Text(
                        totalQty == '1'
                            ? '$totalQty item'.toUpperCase()
                            : '$totalQty items'.toUpperCase(),
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
                      Text(
                        'added to cart'.toUpperCase(),
                        style: GoogleFonts.publicSans(
                          fontSize: 16.sp,
                          color: getColorAccountType(
                            accountType: accountType,
                            businessColor: AppColors.primaryColor,
                            personalColor: AppColors.darkGreenGrey,
                          ),
                        ),
                      ),
                    ],
                  ),
            Container(
              height: 30.h,
              width: 45.w,
              decoration: BoxDecoration(
                color: getColorAccountType(
                  accountType: accountType,
                  businessColor: AppColors.primaryColor,
                  personalColor: AppColors.darkGreenGrey,
                ),
                borderRadius: BorderRadius.circular(100.r),
              ),
              child: isLoading
                  ? CustomLoader()
                  : const SvgIcon(
                      icon: IconStrings.arrowNext,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
