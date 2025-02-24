import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

InputBorder textFieldBorderStyle = OutlineInputBorder(
  borderRadius: BorderRadius.circular(100.0), // Set corner radius
  borderSide: BorderSide(color: Colors.transparent, width: 1.w),
);

// * Condition of get color according to accountType
Color getColorAccountType({
  required String accountType,
  required Color businessColor,
  required Color personalColor,
}) {
  return accountType != '' && accountType == 'business'
      ? businessColor
      : accountType != '' && accountType == 'personal'
          ? personalColor
          : AppColors.white; // NOTE: default color (while type not found)
}

// default bottom shadow of content
BoxShadow bottomShadow() {
  return const BoxShadow(
    color: Colors.black26,
    offset: Offset(0, 4),
    blurRadius: 6,
  );
}

// textfield border style
InputBorder? kTextfieldBorderStyle = OutlineInputBorder(
  borderRadius: BorderRadius.circular(100.r),
  borderSide: BorderSide(
    color: AppColors.seaShell,
    width: 2.w,
  ),
);

InputBorder? kSearchDropDownBorder = OutlineInputBorder(
  borderRadius: BorderRadius.circular(100.r),
  borderSide: const BorderSide(
    width: 2,
    color: AppColors.seaShell,
    style: BorderStyle.solid,
  ),
);

InputBorder? kDropdownBorderStyle = OutlineInputBorder(
  borderRadius: BorderRadius.circular(100.r),
  borderSide: const BorderSide(color: AppColors.seaShell, width: 2),
);

List<BoxShadow>? kDropShadow = [
  const BoxShadow(
    color: Color(0x40000000), // #00000040 in ARGB format
    blurRadius: 4.0,
    offset: Offset(0, 4), // x: 0, y: 4
  ),
];

// Capitalized first word:
String capitalizeEachWord(String text) {
  return text
      .split(' ') // Split the text by spaces
      .map((word) => word.isNotEmpty
          ? '${word[0].toUpperCase()}${word.substring(1).toLowerCase()}'
          : '') // Capitalize the first letter
      .join(' '); // Join the words back together
}

TextStyle? kRechargeTableHeaderStyle = GoogleFonts.publicSans(
  fontSize: 12.sp,
  fontWeight: FontWeight.bold,
  color: AppColors.primaryColor,
);

TextStyle? kRechargeTableValueStyle = GoogleFonts.publicSans(
  fontSize: 16.sp,
  fontWeight: FontWeight.bold,
  color: AppColors.primaryColor,
);
