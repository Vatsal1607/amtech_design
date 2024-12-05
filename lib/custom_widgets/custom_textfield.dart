import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/utils/app_colors.dart';
import '../core/utils/constant.dart';
import 'svg_icon.dart';

class CustomTextField extends StatelessWidget {
  final String hint;
  final String prefixIcon;
  final TextEditingController controller;
  final Color iconColor;
  final FormFieldValidator<String>? validator;
  const CustomTextField({
    super.key,
    required this.hint,
    required this.prefixIcon,
    required this.controller,
    this.iconColor = AppColors.white,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      style: GoogleFonts.publicSans(
        fontSize: 14.sp,
        color: AppColors.white,
      ),
      validator: validator,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: GoogleFonts.publicSans(
          fontSize: 14.sp,
          color: AppColors.white,
        ),
        prefixIcon: SvgIcon(
          icon: prefixIcon,
          color: iconColor,
        ),
        border: kTextfieldBorderStyle,
        enabledBorder: kTextfieldBorderStyle,
        focusedBorder: kTextfieldBorderStyle,
        errorBorder: kTextfieldBorderStyle?.copyWith(
          borderSide: BorderSide(
            color: AppColors.red,
            width: 2.w,
          ),
        ),
        errorStyle: const TextStyle(
          color: AppColors.red,
        ),
      ),
    );
  }
}
