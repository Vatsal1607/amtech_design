import 'package:amtech_design/core/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/utils/app_colors.dart';

class DividerLabel extends StatelessWidget {
  final String label;
  final String accountType;
  const DividerLabel({
    super.key,
    required this.label,
    required this.accountType,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Divider(
            indent: 20.w,
            thickness: 2,
            color: getColorAccountType(
              accountType: accountType,
              businessColor: AppColors.primaryColor.withOpacity(0.25),
              personalColor: AppColors.darkGreenGrey.withOpacity(0.25),
            ),
          ),
        ),
        const SizedBox(width: 7),
        Text(
          label.toUpperCase(),
          style: GoogleFonts.publicSans(
            fontSize: 10.0,
            fontWeight: FontWeight.bold,
            color: getColorAccountType(
              accountType: accountType,
              businessColor: AppColors.primaryColor.withOpacity(0.25),
              personalColor: AppColors.darkGreenGrey.withOpacity(0.25),
            ),
          ),
        ),
        const SizedBox(width: 7),
        Expanded(
          child: Divider(
            thickness: 2,
            endIndent: 20.w,
            color: getColorAccountType(
              accountType: accountType,
              businessColor: AppColors.primaryColor.withOpacity(0.25),
              personalColor: AppColors.darkGreenGrey.withOpacity(0.25),
            ),
          ),
        ),
      ],
    );
  }
}
