import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/strings.dart';
import '../../../custom_widgets/buttons/custom_button.dart';
import '../../../custom_widgets/svg_icon.dart';
import '../../../routes.dart';
import '../location_selection/location_selection_provider.dart';
import 'login_provider.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    // final String accountType = 'business'; // Todo set dynamic accountType
    final String accountType =
        context.read<LocationSelectionProvider>().accountType ?? '';
    final provider = Provider.of<LoginProvider>(context, listen: false);
    debugPrint('Account type is: $accountType');
    return Scaffold(
      resizeToAvoidBottomInset: false, //image did't by the keyboard
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
      body: Form(
        key: context.read<LoginProvider>().formKey,
        child: Stack(
          children: [
            Image.asset(
              width: 1.sw,
              height: 1.sh,
              ImageStrings.loginBg,
              fit: BoxFit.cover,
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
                      'Login',
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
                      'Enter your mobile number to get otp.'.toUpperCase(),
                      style: GoogleFonts.publicSans(
                        fontSize: 15.sp,
                        color: accountType != '' && accountType == 'business'
                            ? AppColors.seaShell
                            : accountType != '' && accountType == 'personal'
                                ? AppColors.seaMist
                                : AppColors.white,
                      ),
                    ),
                    SizedBox(height: 16.h),

                    /// TextField Widget for Mobile number
                    // Textfield(), // Extracted widget
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Country Code Widget
                        Container(
                          height: 52.h,
                          width: 52.w,
                          decoration: const BoxDecoration(
                            color: AppColors.white,
                            shape: BoxShape.circle,
                          ),
                          // padding:  EdgeInsets.symmetric(horizontal: 8.w),
                          margin: EdgeInsets.only(top: 2.h),
                          child: Center(
                            child: Text(
                              context.read<LoginProvider>().countryCode,
                              style: GoogleFonts.publicSans(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.bold,
                                color: accountType != '' &&
                                        accountType == 'business'
                                    ? AppColors.primaryColor
                                    : accountType != '' &&
                                            accountType == 'personal'
                                        ? AppColors.darkGreenGrey
                                        : AppColors.white,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 11.w),
                        // Mobile Number Text Field
                        Expanded(
                          child: Consumer<LoginProvider>(
                            builder: (context, provider, child) =>
                                TextFormField(
                              controller: provider.phoneController,
                              keyboardType: TextInputType.phone,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                LengthLimitingTextInputFormatter(10),
                              ],
                              validator: provider.validateMobileNumber,
                              onChanged: provider.onChangePersonalNumber,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: AppColors.white,
                                errorStyle:
                                    const TextStyle(color: AppColors.white),
                                hintText: 'Enter mobile number',
                                errorText: provider.mobileErrorText,
                                hintStyle: GoogleFonts.publicSans(
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.bold,
                                  color: accountType != '' &&
                                          accountType == 'business'
                                      ? AppColors.primaryColor.withOpacity(0.5)
                                      : accountType != '' &&
                                              accountType == 'personal'
                                          ? AppColors.darkGreenGrey
                                              .withOpacity(0.5)
                                          : AppColors.white,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(100.r),
                                ),
                                contentPadding:
                                    const EdgeInsets.symmetric(horizontal: 12),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8.h),
                    if (accountType == 'personal')
                      GestureDetector(
                        onTap: () {
                          //* Navigate to Register page
                          Navigator.pushNamed(
                            context,
                            Routes.register,
                          );
                        },
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'don\'t have an account? '.toUpperCase(),
                                style: GoogleFonts.publicSans(
                                  fontSize: 15.sp,
                                  color: AppColors.seaMist,
                                ),
                              ),
                              Text(
                                'Register Now'.toUpperCase(),
                                style: GoogleFonts.publicSans(
                                  fontSize: 15.sp,
                                  color: AppColors.seaMist,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(
                  bottom: 70.h,
                  left: 34.w,
                  right: 34.w,
                ),
                child: Consumer<LoginProvider>(
                  builder: (context, _, child) => CustomButton(
                    height: 50.h,
                    isLoading: provider.isLoading,
                    onTap: () {
                      if (provider.formKey.currentState!.validate()) {
                        debugPrint('Form is valid');
                        provider.userLogin(context, accountType); //!Api call

                        // Navigator.pushNamed(
                        //   context,
                        //   Routes.otp,
                        //   arguments: {
                        //     'mobile_number': context
                        //         .read<LoginProvider>()
                        //         .phoneController
                        //         .text,
                        //   },
                        // );
                      } else {
                        debugPrint('Form is not valid');
                      }
                    },
                    text: 'GET OTP',
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
