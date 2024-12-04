import 'package:flutter/material.dart';

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
  return BoxShadow(
    color: Colors.black26,
    offset: Offset(0, 4),
    blurRadius: 6,
  );
}
