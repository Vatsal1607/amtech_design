import 'package:amtech_design/core/utils/constant.dart';
import 'package:amtech_design/core/utils/strings.dart';
import 'package:amtech_design/custom_widgets/svg_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/constants/keys.dart';
import '../../../../services/local/shared_preferences_service.dart';

class CustomButtonWithIcon extends StatelessWidget {
  final String labelText;
  final VoidCallback onPressed;
  final String icon;
  final double? height;
  final double? width;
  final bool isWidthBetween;
  final double fontSize;
  const CustomButtonWithIcon({
    super.key,
    required this.labelText,
    required this.onPressed,
    this.icon = IconStrings.plus,
    this.height,
    this.width,
    this.isWidthBetween = true,
    this.fontSize = 12,
  });

  @override
  Widget build(BuildContext context) {
    final String accountType =
        sharedPrefsService.getString(SharedPrefsKeys.accountType) ?? '';
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: height,
        width: width,
        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
        decoration: BoxDecoration(
          color: getColorAccountType(
            accountType: accountType,
            businessColor: AppColors.seaShell,
            personalColor: AppColors.seaMist,
          ),
          borderRadius: BorderRadius.circular(30.r),
          border: Border.all(color: Colors.transparent),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgIcon(
              icon: icon,
              color: getColorAccountType(
                accountType: accountType,
                businessColor: AppColors.primaryColor,
                personalColor: AppColors.darkGreenGrey,
              ),
            ),
            if (isWidthBetween) SizedBox(width: 5.w),
            Text(
              labelText,
              style: GoogleFonts.publicSans(
                fontWeight: FontWeight.bold,
                color: getColorAccountType(
                  accountType: accountType,
                  businessColor: AppColors.primaryColor,
                  personalColor: AppColors.darkGreenGrey,
                ),
                fontSize: fontSize.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
