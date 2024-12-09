import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app_colors.dart';

InputBorder textFieldBorderStyle = OutlineInputBorder(
  borderRadius: BorderRadius.circular(100.0), // Set corner radius
  borderSide:
      const BorderSide(color: Colors.transparent), // Optional: no border color
);

// Condition of get color according to accountType
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
