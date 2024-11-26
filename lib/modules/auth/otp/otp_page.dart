import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/strings.dart';
import '../../../custom_widgets/custom_button.dart';
import '../../../custom_widgets/svg_icon.dart';
import '../../../routes.dart';
import '../location_selection/location_selection_provider.dart';
import 'widgets/otp_fields.dart';

class OtpPage extends StatelessWidget {
  const OtpPage({super.key});

  @override
  Widget build(BuildContext context) {
    final String accountType =
        context.read<LocationSelectionProvider>().accountType ?? '';
    final arguments =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;

    return Scaffold(
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
                top: 150.0,
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
                    'we\'ve sent the otp to +91 ${arguments['mobile_number']}'
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
                  OtpFields(),

                  SizedBox(height: 18.h),
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
                  CustomButton(
                    height: 48.h,
                    onTap: () {
                      debugPrint('Verify pressed from OTP page');
                      Navigator.pushNamed(context, Routes.bottomBarPage);
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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
