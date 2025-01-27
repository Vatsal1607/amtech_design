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
  final Color cursorColor;
  final int errorMaxLines;
  final String? prefixText;
  final int? maxLines;
  final int? minLines;
  final FocusNode? focusNode;
  final bool? enabled;
  final Widget? prefix;
  final TextCapitalization textCapitalization;
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
    this.cursorColor = AppColors.seaShell,
    this.errorMaxLines = 1,
    this.prefixText,
    this.maxLines = 1,
    this.minLines = 1,
    this.focusNode,
    this.enabled = true,
    this.prefix,
    this.textCapitalization = TextCapitalization.sentences,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: enabled,
      cursorColor: cursorColor,
      controller: controller,
      textCapitalization: textCapitalization,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      style: GoogleFonts.publicSans(
        fontSize: 15.sp,
        color: textColor,
      ),
      validator: validator,
      onChanged: onChanged,
      focusNode: focusNode,
      maxLines: maxLines,
      minLines: minLines,
      decoration: InputDecoration(
        hintText: hint,
        prefixText: prefixText,
        prefix: prefix,
        errorText: errorText,
        errorMaxLines: errorMaxLines,
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
