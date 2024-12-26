import 'package:amtech_design/custom_widgets/buttons/custom_button_with_arrow.dart';
import 'package:amtech_design/modules/auth/otp/widgets/otp_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/constant.dart';
import '../../../core/utils/strings.dart';
import '../../../custom_widgets/svg_icon.dart';

void otpVerifyBottomSheeet({
  required BuildContext context,
  required String accountType,
  required TextEditingController controller,
}) {
  showModalBottomSheet(
    context: context,
    // barrierColor: Colors.transparent,
    backgroundColor: getColorAccountType(
      accountType: accountType,
      businessColor: AppColors.primaryColor,
      personalColor: AppColors.darkGreenGrey,
    ),
    builder: (context) {
      return Stack(
        clipBehavior: Clip.none, // Allow visible outside the bounds
        children: [
          Positioned(
            child: Container(
              padding: EdgeInsets.only(top: 19.h, left: 32.w, right: 32.w),
              width: 1.sw,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'verify'.toUpperCase(),
                    style: GoogleFonts.publicSans(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: getColorAccountType(
                        accountType: accountType,
                        businessColor: AppColors.seaShell,
                        personalColor: AppColors.seaMist,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'OTP, Please?',
                          style: GoogleFonts.publicSans(
                            fontSize: 40.sp,
                            fontWeight: FontWeight.bold,
                            color: AppColors.disabledColor,
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              'we\'ve sent the OTP to ',
                              style: GoogleFonts.publicSans(
                                fontSize: 15.sp,
                                color: AppColors.white,
                              ),
                            ),
                            Text(
                              '+91 12345 67890',
                              style: GoogleFonts.publicSans(
                                fontSize: 15.sp,
                                fontWeight: FontWeight.bold,
                                color: AppColors.white,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8.h),

                        // *
                        OtpFields(
                          controller: controller,
                        ),

                        RichText(
                          text: TextSpan(
                            text: 'resend otp in '.toUpperCase(),
                            style: GoogleFonts.publicSans(
                              fontSize: 10.sp,
                            ),
                            children: [
                              TextSpan(
                                text: '00:30',
                                style: GoogleFonts.publicSans(
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: 20.h),
                        CustomButtonWithArrow(
                          isMargin: false,
                          accountType: accountType,
                          onTap: () {
                            debugPrint('Pressed ');
                          },
                          text: 'VERIFY',
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 40.h),
                ],
              ),
            ),
          ),
          Positioned(
            top: -40,
            right: 0,
            left: 0,
            child: IgnorePointer(
              ignoring: true,
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  debugPrint('Close pressed');
                },
                child: Container(
                  height: 30.h,
                  width: 30.w,
                  decoration: const BoxDecoration(
                    color: AppColors.red,
                    shape: BoxShape.circle,
                  ),
                  child: const SvgIcon(
                    icon: IconStrings.close,
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    },
  );
}
