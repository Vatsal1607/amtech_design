import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/constant.dart';

class CenterTitleWithDivider extends StatelessWidget {
  final String accountType;
  final String title;
  final double fontSize;
  const CenterTitleWithDivider({
    super.key,
    required this.accountType,
    required this.title,
    this.fontSize = 24,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Divider(
            color: getColorAccountType(
              accountType: accountType,
              businessColor: AppColors.primaryColor.withOpacity(.5),
              personalColor: AppColors.darkGreenGrey.withOpacity(.5),
            ),
            thickness: 2,
            endIndent: 8,
          ),
        ),
        Text(
          title,
          style: GoogleFonts.publicSans(
            fontSize: fontSize.sp,
            fontWeight: FontWeight.bold,
            color: getColorAccountType(
              accountType: accountType,
              businessColor: AppColors.primaryColor,
              personalColor: AppColors.darkGreenGrey,
            ),
          ),
        ),
        Expanded(
          child: Divider(
            color: getColorAccountType(
              accountType: accountType,
              businessColor: AppColors.primaryColor.withOpacity(.5),
              personalColor: AppColors.darkGreenGrey.withOpacity(.5),
            ),
            thickness: 2,
            indent: 8,
          ),
        ),
      ],
    );
  }
}
