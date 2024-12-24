import 'package:amtech_design/core/utils/constant.dart';
import 'package:amtech_design/custom_widgets/svg_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/strings.dart';

class ReorderCardWidget extends StatelessWidget {
  final String accountType;
  const ReorderCardWidget({
    super.key,
    required this.accountType,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 145.h,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: getColorAccountType(
          accountType: accountType,
          businessColor: AppColors.primaryColor,
          personalColor: AppColors.darkGreenGrey,
        ),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '9/12/2024 05:55PM',
                style: GoogleFonts.publicSans(
                  color: getColorAccountType(
                    accountType: accountType,
                    businessColor: AppColors.seaShell,
                    personalColor: AppColors.seaMist,
                  ),
                  fontSize: 12.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '₹155.00',
                style: GoogleFonts.publicSans(
                  color: getColorAccountType(
                    accountType: accountType,
                    businessColor: AppColors.seaShell,
                    personalColor: AppColors.seaMist,
                  ),
                  fontSize: 12.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Divider(
            color: getColorAccountType(
              accountType: accountType,
              businessColor: AppColors.seaShell.withOpacity(.5),
              personalColor: AppColors.seaMist.withOpacity(.5),
            ),
            thickness: 1,
          ),
          SizedBox(height: 8.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '1× Masala Tea',
                    style: GoogleFonts.publicSans(
                      color: getColorAccountType(
                        accountType: accountType,
                        businessColor: AppColors.seaShell,
                        personalColor: AppColors.seaMist,
                      ),
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 1.h),
                  Text(
                    '2× Hot Coffee',
                    style: GoogleFonts.publicSans(
                      color: getColorAccountType(
                        accountType: accountType,
                        businessColor: AppColors.seaShell,
                        personalColor: AppColors.seaMist,
                      ),
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 1.h),
                  Text(
                    '& MORE',
                    style: GoogleFonts.publicSans(
                      color: getColorAccountType(
                        accountType: accountType,
                        businessColor: AppColors.seaShell.withOpacity(.5),
                        personalColor: AppColors.seaMist.withOpacity(.5),
                      ),
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              // * Reorder Button
              Container(
                height: 30.h,
                width: 100.w,
                decoration: BoxDecoration(
                  color: getColorAccountType(
                    accountType: accountType,
                    businessColor: AppColors.seaShell,
                    personalColor: AppColors.seaMist,
                  ),
                  borderRadius: BorderRadius.circular(30.r),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgIcon(
                      icon: IconStrings.reorderBtn,
                      color: getColorAccountType(
                        accountType: accountType,
                        businessColor: AppColors.primaryColor,
                        personalColor: AppColors.darkGreenGrey,
                      ),
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      'REORDER',
                      style: GoogleFonts.publicSans(
                        fontWeight: FontWeight.bold,
                        fontSize: 12.sp,
                        color: getColorAccountType(
                          accountType: accountType,
                          businessColor: AppColors.primaryColor,
                          personalColor: AppColors.darkGreenGrey,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
