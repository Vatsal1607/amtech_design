import 'package:amtech_design/custom_widgets/buttons/custom_button_with_arrow.dart';
import 'package:amtech_design/modules/auth/otp/widgets/otp_fields.dart';
import 'package:amtech_design/modules/authorized_emp/authorized_emp_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/constant.dart';
import '../../../custom_widgets/buttons/custom_bottomsheet_close_button.dart';

void otpVerifyBottomSheeet({
  required BuildContext context,
  required String accountType,
  required TextEditingController otpController,
  required TextEditingController authorizeMobileController,
}) {
  // Ensure controller is reinitialized when showing BottomSheet
  otpController = TextEditingController(); // ! Reinitialize here
  showModalBottomSheet(
    context: context,
    isDismissible: false,
    isScrollControlled: true, // Expand fully when keyboard is open
    backgroundColor: getColorAccountType(
      accountType: accountType,
      businessColor: AppColors.primaryColor,
      personalColor: AppColors.darkGreenGrey,
    ),
    builder: (context) {
      final authEmpProvider =
          Provider.of<AuthorizedEmpProvider>(context, listen: false);
      return Stack(
        clipBehavior: Clip.none, // Allow visible outside the bounds
        children: [
          Positioned(
            child: Container(
              padding: EdgeInsets.only(
                top: 19.h,
                left: 32.w,
                right: 32.w,
                // Adjust bottomsheet while keyboard open
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
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
                              'We\'ve sent the OTP to ',
                              style: GoogleFonts.publicSans(
                                fontSize: 15.sp,
                                color: AppColors.white,
                              ),
                            ),
                            Text(
                              '+91 ${authorizeMobileController.text}',
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
                          controller: otpController,
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
                            // * API call
                            if (otpController.text.isNotEmpty) {
                              authEmpProvider.verifyOtp(
                                context: context,
                                otpController: otpController,
                                mobile: authorizeMobileController.text,
                              );
                            }
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
          const Positioned(
            top: -40,
            right: 0,
            left: 0,
            child: CustomBottomsheetCloseButton(),
          ),
        ],
      );
    },
  );
}
