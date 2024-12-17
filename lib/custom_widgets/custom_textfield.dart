import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final void Function(String)? onChanged;
  final String? errorText;
  final Color textColor;
  final Color borderColor;
  final Widget? suffixWidget;
  final EdgeInsetsGeometry? contentPadding;
  const CustomTextField({
    super.key,
    required this.hint,
    required this.prefixIcon,
    required this.controller,
    this.iconColor = AppColors.white,
    this.validator,
    this.keyboardType,
    this.inputFormatters,
    this.onChanged,
    this.errorText,
    this.textColor = AppColors.seaShell,
    this.borderColor = AppColors.seaShell,
    this.suffixWidget,
    this.contentPadding,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: AppColors.seaShell,
      controller: controller,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      style: GoogleFonts.publicSans(
        fontSize: 15.sp,
        color: textColor,
      ),
      validator: validator,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hint,
        errorText: errorText,
        hintStyle: GoogleFonts.publicSans(
          fontSize: 15.sp,
          color: textColor,
        ),
        prefixIcon: SvgIcon(
          icon: prefixIcon,
          color: iconColor,
        ),
        suffixIcon: suffixWidget,
        contentPadding: contentPadding,
        border: kTextfieldBorderStyle?.copyWith(
          borderSide: BorderSide(
            color: borderColor,
            width: 2.w,
          ),
        ),
        enabledBorder: kTextfieldBorderStyle?.copyWith(
          borderSide: BorderSide(
            color: borderColor,
            width: 2.w,
          ),
        ),
        focusedBorder: kTextfieldBorderStyle?.copyWith(
          borderSide: BorderSide(
            color: borderColor,
            width: 2,
          ),
        ),
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
