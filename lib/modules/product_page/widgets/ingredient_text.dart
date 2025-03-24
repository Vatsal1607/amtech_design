import 'package:amtech_design/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class IngredientText extends StatelessWidget {
  final String text;
  const IngredientText({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          '• ', // Leading dot
          style: GoogleFonts.publicSans(
            fontSize: 18,
            color: Colors.black,
            height: 1.h,
          ),
        ),
        Text(
          text,
          style: GoogleFonts.publicSans(
            height: 1.h,
            fontSize: 14.sp,
            color: AppColors.primaryColor,
          ),
        ),
      ],
    );
  }
}
