import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/utils/app_colors.dart';

class CustomSubsButtonWithArrow extends StatelessWidget {
  const CustomSubsButtonWithArrow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.h,
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.circular(30.r),
      ),
      padding: EdgeInsets.only(left: 30.w, right: 7.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
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
            width: 40.w,
            height: 40.h,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.arrow_forward,
              color: AppColors.primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
