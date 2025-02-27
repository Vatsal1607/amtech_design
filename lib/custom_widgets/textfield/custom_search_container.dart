import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/utils/app_colors.dart';
import '../../core/utils/constant.dart';
import '../../core/utils/strings.dart';
import '../svg_icon.dart';

class CustomSearchContainer extends StatelessWidget {
  final String accountType;
  final TextEditingController controller;
  final Color? fillColor;
  final Color? borderColor;
  final Color iconColor;
  final double borderWidth;
  final String hint;
  final bool readOnly;
  final VoidCallback? onTap;

  const CustomSearchContainer({
    super.key,
    required this.accountType,
    required this.controller,
    this.fillColor,
    this.borderColor,
    this.iconColor = AppColors.seaShell,
    this.borderWidth = 1.0,
    this.hint = 'Search for Tea, Coffee or Snacks',
    this.readOnly = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: readOnly ? onTap : null,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: fillColor ??
              getColorAccountType(
                accountType: accountType,
                businessColor: AppColors.primaryColor.withOpacity(0.8),
                personalColor: AppColors.darkGreenGrey.withOpacity(0.8),
              ),
          borderRadius: BorderRadius.circular(100.0),
          border: Border.all(
            color: borderColor ?? Colors.transparent,
            width: borderWidth,
          ),
        ),
        child: Row(
          children: [
            SvgIcon(
              icon: IconStrings.search,
              color: iconColor,
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: Text(
                controller.text.isEmpty ? hint : controller.text,
                style: GoogleFonts.publicSans(
                  color: getColorAccountType(
                    accountType: accountType,
                    businessColor: AppColors.disabledColor,
                    personalColor: AppColors.white,
                  ),
                  fontSize: 14.sp,
                  fontWeight: controller.text.isEmpty
                      ? FontWeight.bold
                      : FontWeight.normal,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
