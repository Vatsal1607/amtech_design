import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/utils/app_colors.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Color bgColor;
  final Color textColor;
  final VoidCallback onTap;
  final double? height;
  final double? width;
  final bool isLoading;
  const CustomButton({
    super.key,
    this.text = 'NEXT',
    this.bgColor = AppColors.black,
    this.textColor = AppColors.seaShell,
    required this.onTap,
    this.height,
    this.width,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        padding: EdgeInsets.only(
          top: 4.h,
          bottom: 6.h,
        ),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(100.r),
        ),
        child: Center(
          child: isLoading
              ? const CircularProgressIndicator.adaptive(
                  backgroundColor: AppColors.seaShell,
                )
              : Text(
                  text.toUpperCase(),
                  style: GoogleFonts.publicSans(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
        ),
      ),
    );
  }
}
