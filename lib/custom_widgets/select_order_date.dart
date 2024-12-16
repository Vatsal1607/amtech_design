import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/utils/app_colors.dart';

class SelectOrderDateWidget extends StatelessWidget {
  const SelectOrderDateWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Select order Date:'.toUpperCase(),
          style: GoogleFonts.publicSans(
            fontSize: 14.sp,
            color: AppColors.primaryColor,
          ),
        ),
        SizedBox(width: 20.w),
        Container(
          height: 48.h,
          width: 185.w,
          decoration: BoxDecoration(
            color: AppColors.primaryColor,
            borderRadius: BorderRadius.circular(100.r),
          ),
          child: Center(
            child: Text(
              '9/12/2024',
              style: GoogleFonts.publicSans(
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.seaShell,
              ),
            ),
          ),
        )
      ],
    );
  }
}
