import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/utils/app_colors.dart';

class CustomSubsButtonWithArrow extends StatelessWidget {
  final Color? bgColor;
  final Color? iconBgColor;
  final Color? iconColor;
  final String? singleText;
  final IconData? iconData;
  const CustomSubsButtonWithArrow({
    super.key,
    this.bgColor = AppColors.primaryColor,
    this.singleText,
    this.iconBgColor = Colors.white,
    this.iconData = Icons.arrow_forward_outlined,
    this.iconColor = AppColors.primaryColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.h,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(30.r),
      ),
      padding: EdgeInsets.only(left: 30.w, right: 7.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          singleText != null
              ? Text(
                  singleText!,
                  style: GoogleFonts.publicSans(
                    fontSize: 20.sp,
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'YOUR WEEKLY CONSUMPION',
                      style: GoogleFonts.publicSans(
                        fontSize: 14.sp,
                        color: AppColors.disabledColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '5 UNITS',
                      style: GoogleFonts.publicSans(
                        fontSize: 18.sp,
                        color: AppColors.seaShell,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
          Container(
            width: 50.w,
            height: 50.h,
            decoration: BoxDecoration(
              color: iconBgColor,
              shape: BoxShape.circle,
            ),
            child: Icon(
              iconData,
              color: iconColor,
            ),
          ),
        ],
      ),
    );
  }
}
