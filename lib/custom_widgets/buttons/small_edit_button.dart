import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/utils/app_colors.dart';
import '../../core/utils/constant.dart';

class SmallEditButton extends StatelessWidget {
  final String accountType;
  final VoidCallback? onTap;
  final String text;
  final double width;
  final double height;
  final Color? bgColor;
  final Color? textColor;
  final double? fontSize;
  const SmallEditButton({
    super.key,
    required this.accountType,
    this.onTap,
    this.text = 'EDIT',
    this.width = 50,
    this.height = 20,
    this.bgColor,
    this.textColor,
    this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height.h,
        width: width.w,
        decoration: BoxDecoration(
          color: bgColor ??
              getColorAccountType(
                accountType: accountType,
                businessColor: AppColors.primaryColor,
                personalColor: AppColors.darkGreenGrey,
              ),
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Center(
          child: Text(
            text,
            style: GoogleFonts.publicSans(
              fontSize: fontSize ?? 11.sp,
              color: textColor ?? AppColors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
