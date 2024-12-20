import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/utils/app_colors.dart';

class CustomConfirmDialog extends StatelessWidget {
  final String title;
  final String subTitle;
  final VoidCallback? onTapCancel;
  final VoidCallback? onTapYes;
  const CustomConfirmDialog({
    super.key,
    required this.title,
    required this.subTitle,
    this.onTapCancel,
    this.onTapYes,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: EdgeInsets.all(20.w),
        width: 330.w,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30.r),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // * Title
            Text(
              title,
              style: GoogleFonts.publicSans(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryColor,
              ),
            ),
            SizedBox(height: 23.h),
            // * Subtitle
            Text(
              subTitle,
              textAlign: TextAlign.center,
              style: GoogleFonts.publicSans(
                fontSize: 14.sp,
                color: AppColors.primaryColor,
              ),
            ),
            SizedBox(height: 25.h),
            // * Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // * Yes, Remove Button
                Expanded(
                  child: GestureDetector(
                    onTap: onTapYes,
                    child: Container(
                      height: 48.h,
                      decoration: BoxDecoration(
                        color: AppColors.red,
                        borderRadius: BorderRadius.circular(30.r),
                      ),
                      child: Center(
                        child: Text(
                          "YES, REMOVE",
                          style: GoogleFonts.publicSans(
                            fontSize: 14.sp,
                            color: AppColors.seaShell,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10.w),
                // * Cancel Button
                Expanded(
                  child: GestureDetector(
                    onTap: onTapCancel,
                    child: Container(
                      height: 48.h,
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.circular(30.r),
                      ),
                      child: Center(
                        child: Text(
                          "CANCEL",
                          style: GoogleFonts.publicSans(
                            fontSize: 14.sp,
                            color: AppColors.seaShell,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
