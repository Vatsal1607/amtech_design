import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/constant.dart';
import '../../../core/utils/strings.dart';
import '../../../custom_widgets/svg_icon.dart';
import '../../../routes.dart';

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
          //* Perks example widget
          //! PERKS button with an image
          // SizedBox(
          //   height: 26.h,
          //   width: 64.w,
          //   child: Container(
          //     padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
          //     decoration: BoxDecoration(
          //       color: Colors.black,
          //       borderRadius: BorderRadius.circular(20.r),
          //     ),
          //     child: Row(
          //       mainAxisSize: MainAxisSize.min,
          //       children: [
          //         Image.network(
          //           'https://images.unsplash.com/photo-1604440976150-c12352c982ce?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8cGVya3MlMjB0ZXh0fGVufDB8fDB8fHww',
          //           height: 20.h,
          //           width: 20.w,
          //         ),
          //         SizedBox(width: 5.w),
          //         const Text(
          //           "Perks",
          //           style: TextStyle(
          //             color: Colors.white,
          //             fontWeight: FontWeight.bold,
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
          if (isShowRecharge)
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, Routes.recharge);
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
                //* Old Recharge text & icon
                // child: Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     const SvgIcon(
                //       icon: IconStrings.rupeeGreen,
                //       color: AppColors.lightGreen,
                //     ),
                //     SizedBox(
                //       width: 5.w,
                //     ),
                //     Text(
                //       'recharge'.toUpperCase(),
                //       style: GoogleFonts.publicSans(
                //         fontSize: 10.sp,
                //         fontWeight: FontWeight.w700,
                //         color: AppColors.seaShell,
                //       ),
                //     ),
                //   ],
                // ),
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
