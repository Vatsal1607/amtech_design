import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/constant.dart';
import '../../../custom_widgets/svg_icon.dart';

class ProfileTile extends StatelessWidget {
  final String title;
  final String icon;
  final Color iconColor;
  final Color? bgColor;
  final VoidCallback? onTap;
  const ProfileTile({
    super.key,
    required this.title,
    required this.icon,
    this.iconColor = AppColors.seaShell,
    this.bgColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 21.w, vertical: 14.h),
        decoration: bgColor != null
            ? BoxDecoration(
                boxShadow: kDropShadow,
                borderRadius: BorderRadius.circular(30.r),
                color: AppColors.primaryColor,
              )
            : const BoxDecoration(color: Colors.transparent),
        child: Row(
          children: [
            SvgIcon(
              icon: icon,
              color: bgColor != null ? iconColor : AppColors.disabledColor,
            ),
            SizedBox(width: 10.h),
            Text(
              title,
              style: bgColor != null
                  ? GoogleFonts.publicSans(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w700,
                      color: AppColors.seaShell,
                    )
                  : GoogleFonts.publicSans(
                      fontSize: 15.sp,
                      color: AppColors.primaryColor,
                    ),
            )
          ],
        ),
      ),
    );
  }
}
