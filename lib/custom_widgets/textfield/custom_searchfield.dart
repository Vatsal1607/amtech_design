import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/utils/app_colors.dart';
import '../../core/utils/constant.dart';
import '../../core/utils/strings.dart';
import '../svg_icon.dart';

class CustomSearchField<T extends ChangeNotifier> extends StatelessWidget {
  final T provider;
  final String accountType;
  final TextEditingController controller;
  final Color? fillColor;
  final Color? borderColor;
  final Color iconColor;
  final double borderWidth;
  final String hint;
  final TextAlignVertical? textAlignVertical;
  final bool readOnly;
  const CustomSearchField({
    super.key,
    required this.provider,
    required this.accountType,
    required this.controller,
    this.fillColor,
    this.borderColor,
    this.iconColor = AppColors.seaShell,
    this.borderWidth = 1.0,
    this.hint = 'Search for Tea, Coffee or Snacks',
    this.textAlignVertical = TextAlignVertical.center,
    this.readOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: readOnly,
      controller: controller,
      textCapitalization: TextCapitalization.sentences,
      textAlignVertical: textAlignVertical,
      style: GoogleFonts.publicSans(
        color: getColorAccountType(
          accountType: accountType,
          businessColor: AppColors.disabledColor,
          personalColor: AppColors.white,
        ),
        fontSize: 14.sp,
      ),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: GoogleFonts.publicSans(
          fontWeight: FontWeight.bold,
          color: getColorAccountType(
            accountType: accountType,
            businessColor: AppColors.disabledColor,
            personalColor: AppColors.white,
          ),
          fontSize: 14.sp,
        ),

        border: textFieldBorderStyle.copyWith(
          borderSide: BorderSide(
            color: borderColor ?? Colors.transparent,
            width: borderWidth,
          ),
        ),
        enabledBorder: textFieldBorderStyle.copyWith(
          borderSide: BorderSide(
            color: borderColor ?? Colors.transparent,
            width: borderWidth,
          ),
        ),
        focusedBorder: textFieldBorderStyle.copyWith(
          borderSide: BorderSide(
            color: borderColor ?? Colors.transparent,
            width: borderWidth,
          ),
        ),
        filled: true, //* To add a background color
        fillColor: fillColor ??
            getColorAccountType(
              accountType: accountType,
              businessColor: AppColors.primaryColor.withOpacity(0.8),
              personalColor: AppColors.darkGreenGrey.withOpacity(0.8),
            ),
        prefixIcon: SvgIcon(
          icon: IconStrings.search,
          color: iconColor,
        ),
      ),
    );
  }
}
