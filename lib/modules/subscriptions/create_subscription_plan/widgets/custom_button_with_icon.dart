import 'package:amtech_design/core/utils/strings.dart';
import 'package:amtech_design/custom_widgets/svg_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/utils/app_colors.dart';

class CustomButtonWithIcon extends StatelessWidget {
  final String labelText;
  final VoidCallback onPressed;
  final String icon;

  const CustomButtonWithIcon({
    super.key,
    required this.labelText,
    required this.onPressed,
    this.icon = IconStrings.plus,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
        decoration: BoxDecoration(
          color: AppColors.seaShell,
          borderRadius: BorderRadius.circular(30.r),
          border: Border.all(color: Colors.transparent),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgIcon(icon: icon, color: AppColors.primaryColor),
            SizedBox(width: 5.w),
            Text(
              labelText,
              style: GoogleFonts.publicSans(
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryColor,
                  fontSize: 12.sp),
            ),
          ],
        ),
      ),
    );
  }
}
