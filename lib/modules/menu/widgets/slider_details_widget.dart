import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/constant.dart';
import '../../../core/utils/strings.dart';
import '../../../custom_widgets/svg_icon.dart';

class SliderDetailsWidget extends StatelessWidget {
  final String icon;
  final String totalValue;
  final String filledValue;
  final String label;
  final bool isShowRecharge;
  const SliderDetailsWidget({
    super.key,
    required this.accountType,
    required this.icon,
    required this.totalValue,
    required this.filledValue,
    required this.label,
    this.isShowRecharge = false,
  });

  final String accountType;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          RichText(
            text: TextSpan(
              text: '$filledValue / ',
              style: GoogleFonts.publicSans(
                color: getColorAccountType(
                  accountType: accountType,
                  businessColor: AppColors.primaryColor,
                  personalColor: AppColors.darkGreenGrey,
                ),
                fontWeight: FontWeight.bold,
                fontSize: 15.sp,
              ),
              children: <TextSpan>[
                TextSpan(
                  text: '$totalValue ',
                  style: GoogleFonts.publicSans(
                    color: getColorAccountType(
                      accountType: accountType,
                      businessColor: AppColors.primaryColor,
                      personalColor: AppColors.darkGreenGrey,
                    ),
                    fontSize: 15.sp,
                  ),
                ),
                TextSpan(
                  text: label.toUpperCase(),
                  style: GoogleFonts.publicSans(
                    color: getColorAccountType(
                      accountType: accountType,
                      businessColor: AppColors.primaryColor,
                      personalColor: AppColors.darkGreenGrey,
                    ),
                    fontSize: 10.sp,
                  ),
                )
              ],
            ),
          ),
          if (isShowRecharge)
            Container(
              height: 35.h,
              width: 100.w,
              padding: EdgeInsets.all(3.w),
              decoration: BoxDecoration(
                // boxShadow: kDropShadow,
                color: AppColors.lightGreen,
                borderRadius: BorderRadius.circular(100.r),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgIcon(
                    icon: IconStrings.rupee,
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  Text(
                    'recharge'.toUpperCase(),
                    style: GoogleFonts.publicSans(
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w700,
                      color: AppColors.seaShell,
                    ),
                  ),
                ],
              ),
            ),
          if (!isShowRecharge)
            SvgIcon(
              icon: icon,
              color: getColorAccountType(
                accountType: accountType,
                businessColor: AppColors.black,
                personalColor: AppColors.darkGreenGrey,
              ),
            ),
        ],
      ),
    );
  }
}
