import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../custom_widgets/svg_icon.dart';

class AccountSelectionButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final Color? bgColor;
  final String icon;
  final Color? textColor;
  final Color iconColor;
  const AccountSelectionButton({
    super.key,
    required this.text,
    required this.onTap,
    this.bgColor = AppColors.primaryColor,
    required this.icon,
    this.textColor = AppColors.seaShell,
    this.iconColor = AppColors.disabledColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: 29.h,
          horizontal: 34.w,
        ),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(100.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SvgIcon(
              icon: icon,
              color: iconColor,
            ),
            Text(
              text.toUpperCase(),
              style: GoogleFonts.publicSans(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
