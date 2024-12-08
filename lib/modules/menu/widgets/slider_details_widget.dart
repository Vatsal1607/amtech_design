import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/constant.dart';
import '../../../custom_widgets/svg_icon.dart';

class SliderDetailsWidget extends StatelessWidget {
  final String icon;
  final String totalValue;
  final String filledValue;
  final String label;
  const SliderDetailsWidget({
    super.key,
    required this.accountType,
    required this.icon,
    required this.totalValue,
    required this.filledValue,
    required this.label,
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
