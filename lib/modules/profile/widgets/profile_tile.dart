import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/constant.dart';
import '../../../core/utils/strings.dart';
import '../../../custom_widgets/svg_icon.dart';

class ProfileTile extends StatelessWidget {
  final String title;
  final String icon;

  const ProfileTile({
    super.key,required this.title,required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 21.w, vertical: 14.h),
      decoration: BoxDecoration(
        boxShadow: kDropShadow,
        borderRadius: BorderRadius.circular(30.r),
        color: AppColors.primaryColor,
      ),
      child: Row(
        children: [
          SvgIcon(icon: icon),
          SizedBox(width: 10.h),
          Text(
            title,
            style: GoogleFonts.publicSans(
              fontSize: 15.sp,
              fontWeight: FontWeight.w700,
              color: AppColors.seaShell,
            ),
          )
        ],
      ),
    );
  }
}
