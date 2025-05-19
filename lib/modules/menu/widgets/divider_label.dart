import 'package:amtech_design/core/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/utils/app_colors.dart';

class DividerLabel extends StatelessWidget {
  final String label;
  final String accountType;
  final bool isHealthFirst;
  const DividerLabel({
    super.key,
    required this.label,
    required this.accountType,
    this.isHealthFirst = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Divider(
            indent: 20.w,
            thickness: 2,
            color: isHealthFirst
                ? AppColors.deepGreen.withOpacity(.3)
                : getColorAccountType(
                    accountType: accountType,
                    businessColor: AppColors.primaryColor.withOpacity(0.3),
                    personalColor: AppColors.darkGreenGrey.withOpacity(0.3),
                  ),
          ),
        ),
        SizedBox(width: 7.w),
        Text(
          label.toUpperCase(),
          style: GoogleFonts.publicSans(
            fontSize: 13.sp,
            fontWeight: FontWeight.bold,
            color: isHealthFirst
                ? AppColors.deepGreen.withOpacity(.5)
                : getColorAccountType(
                    accountType: accountType,
                    businessColor: AppColors.primaryColor.withOpacity(0.5),
                    personalColor: AppColors.darkGreenGrey.withOpacity(0.5),
                  ),
          ),
        ),
        const SizedBox(width: 7),
        Expanded(
          child: Divider(
            thickness: 2,
            endIndent: 20.w,
            color: isHealthFirst
                ? AppColors.deepGreen.withOpacity(.3)
                : getColorAccountType(
                    accountType: accountType,
                    businessColor: AppColors.primaryColor.withOpacity(0.3),
                    personalColor: AppColors.darkGreenGrey.withOpacity(0.3),
                  ),
          ),
        ),
      ],
    );
  }
}
