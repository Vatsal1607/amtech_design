import 'package:amtech_design/core/utils/constant.dart';
import 'package:amtech_design/custom_widgets/loader/custom_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/utils/app_colors.dart';

// ! Note: to show, Call this in showDialog's builder () =>
class CustomConfirmDialog extends StatelessWidget {
  final String title;
  final String subTitle;
  final VoidCallback? onTapCancel;
  final VoidCallback? onTapYes;
  final String accountType;
  final String yesBtnText;
  final bool isLoading;

  const CustomConfirmDialog({
    super.key,
    required this.title,
    required this.subTitle,
    this.onTapCancel,
    this.onTapYes,
    required this.accountType,
    this.yesBtnText = 'YES, REMOVE',
    this.isLoading = false,
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
                color: getColorAccountType(
                  accountType: accountType,
                  businessColor: AppColors.primaryColor,
                  personalColor: AppColors.darkGreenGrey,
                ),
              ),
            ),
            SizedBox(height: 23.h),
            // * Subtitle
            Text(
              subTitle,
              textAlign: TextAlign.center,
              style: GoogleFonts.publicSans(
                fontSize: 14.sp,
                color: getColorAccountType(
                  accountType: accountType,
                  businessColor: AppColors.primaryColor,
                  personalColor: AppColors.darkGreenGrey,
                ),
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
                        child: isLoading
                            ? const CustomLoader(color: AppColors.primaryColor)
                            : Text(
                                yesBtnText,
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
                    onTap: onTapCancel ??
                        () {
                          Navigator.pop(context);
                        },
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
