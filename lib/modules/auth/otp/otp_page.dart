import 'package:amtech_design/modules/auth/login/login_provider.dart';
import 'package:amtech_design/modules/auth/otp/otp_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/constants/keys.dart';
import '../../../core/utils/strings.dart';
import '../../../custom_widgets/buttons/custom_button.dart';
import '../../../custom_widgets/svg_icon.dart';
import '../../../services/local/shared_preferences_service.dart';
import 'widgets/otp_fields.dart';

class OtpPage extends StatelessWidget {
  const OtpPage({super.key});

  @override
  Widget build(BuildContext context) {
    final String accountType =
        sharedPrefsService.getString(SharedPrefsKeys.accountType) ?? '';
    final arguments =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>? ??
            {};
    final provider = Provider.of<OtpProvider>(context, listen: false);
    final loginProvider = Provider.of<LoginProvider>(context, listen: false);
    return Scaffold(
      resizeToAvoidBottomInset: false, //image did't move by the keyboard
      backgroundColor: accountType != '' && accountType == 'business'
          ? AppColors.primaryColor
          : accountType != '' && accountType == 'personal'
              ? AppColors.darkGreenGrey
              : AppColors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: SvgIcon(
            icon: IconStrings.arrowBack,
          ),
        ),
        centerTitle: false,
        titleSpacing: 0, // Removes extra space
        title: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Text(
            'back'.toUpperCase(),
            style: const TextStyle(
              color: AppColors.white,
            ),
          ),
        ),
      ),
      extendBodyBehindAppBar: true, // show content of body behind appbar
      body: Stack(
        children: [
          Image.asset(
            width: 1.sw,
            height: 1.sh,
            ImageStrings.loginBg,
            // fit: BoxFit.cover,
          ),
          Positioned.fill(
            child: Padding(
              padding: EdgeInsets.only(
                top: 130.0,
                left: 34.w,
                right: 34.w,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'OTP, Please?',
                    style: GoogleFonts.publicSans(
                      fontSize: 40.sp,
                      color: accountType != '' && accountType == 'business'
                          ? AppColors.disabledColor
                          : accountType != '' && accountType == 'personal'
                              ? AppColors.seaMist
                              : AppColors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    'we\'ve sent the otp to +91 ${arguments['mobile']}'
                        .toUpperCase(),
                    style: GoogleFonts.publicSans(
                      fontSize: 15.sp,
                      color: accountType != '' && accountType == 'business'
                          ? AppColors.seaShell
                          : accountType != '' && accountType == 'personal'
                              ? AppColors.white
                              : AppColors.white,
                    ),
                  ),
                  SizedBox(height: 16.h),

                  // OTP fields
                  OtpFields(
                    controller: provider.otpController,
                  ),

                  Consumer<OtpProvider>(
                    builder: (context, _, child) =>
                        provider.remainingSeconds == 0
                            ? GestureDetector(
                                onTap: () {
                                  context
                                      .read<LoginProvider>()
                                      .sendOtp(
                                        mobile: arguments['mobile'],
                                        context: context,
                                        accountType: accountType,
                                      )
                                      .then((isSuccess) {
                                    if (isSuccess != null && isSuccess) {
                                      provider.startTimer();
                                    }
                                  });
                                },
                                child: Text(
                                  'RESEND OTP',
                                  style: GoogleFonts.publicSans(
                                    fontSize: 10.sp,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.seaShell,
                                  ),
                                ),
                              )
                            : RichText(
                                text: TextSpan(
                                  text: 'resend otp in '.toUpperCase(),
                                  style: GoogleFonts.publicSans(
                                    fontSize: 10.sp,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: '00:${provider.remainingSeconds}',
                                      style: GoogleFonts.publicSans(
                                        fontSize: 10.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                  ),
                  SizedBox(height: 20.h),
                  Consumer<OtpProvider>(
                    builder: (context, provider, child) => CustomButton(
                      height: 48.h,
                      isLoading: provider.isLoading,
                      onTap: () {
                        if (provider.otpController.text.isNotEmpty) {
                          provider.verifyOtp(
                            context: context,
                            accountType: accountType,
                            mobile: arguments['mobile'],
                            // If number exist in secondary access
                            secondaryContact:
                                loginProvider.validateContactInSecondaryAccess(
                                        int.parse('91${arguments['mobile']}'))
                                    ? arguments['mobile']
                                    : null,
                          );
                        }
                      },
                      text: 'VERIFY',
                      bgColor: accountType != '' && accountType == 'business'
                          ? AppColors.disabledColor
                          : accountType != '' && accountType == 'personal'
                              ? AppColors.seaMist
                              : AppColors.white,
                      textColor: accountType != '' && accountType == 'business'
                          ? AppColors.primaryColor
                          : accountType != '' && accountType == 'personal'
                              ? AppColors.darkGreenGrey
                              : AppColors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
