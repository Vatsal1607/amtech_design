import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/constant.dart';
import '../../../core/utils/constants/keys.dart';
import '../../../core/utils/strings.dart';
import '../../../custom_widgets/custom_confirm_dialog.dart';
import '../../../custom_widgets/svg_icon.dart';
import '../../../routes.dart';
import '../../../services/local/shared_preferences_service.dart';

class ProgressDetailsWidget extends StatelessWidget {
  final String icon;
  final String totalValue;
  final String filledValue;
  final String label;
  final bool isShowRecharge;
  const ProgressDetailsWidget({
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
      padding: EdgeInsets.only(left: 20.w, right: 23.w),
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
            GestureDetector(
              onTap: () {
                bool isLoggedIn =
                    sharedPrefsService.getBool(SharedPrefsKeys.isLoggedIn) ??
                        false;
                if (isLoggedIn == true) {
                  Navigator.pushNamed(context, Routes.recharge);
                } else {
                  showDialog(
                    context: context,
                    builder: (context) => CustomConfirmDialog(
                      title: 'Login Required',
                      subTitle: 'Please log in to use this feature.',
                      accountType: accountType,
                      yesBtnText: 'Login',
                      onTapYes: () {
                        Navigator.pop(context);
                        Navigator.pushNamed(context, Routes.accountSelection);
                      },
                    ),
                  );
                }
              },
              child: Container(
                height: 26.h,
                width: 64.w,
                padding: EdgeInsets.all(7.w),
                decoration: BoxDecoration(
                  color: AppColors.black,
                  borderRadius: BorderRadius.circular(100.r),
                ),
                child: Image.asset(
                  height: 12.h,
                  width: 50.w,
                  ImageStrings.perksLogoWhite,
                  fit: BoxFit.scaleDown,
                ),
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
