import 'package:amtech_design/core/utils/constant.dart';
import 'package:amtech_design/core/utils/constants/keys.dart';
import 'package:amtech_design/services/local/shared_preferences_service.dart';
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
import 'login_provider.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final String accountType =
        sharedPrefsService.getString(SharedPrefsKeys.accountType) ?? '';
    final provider = Provider.of<LoginProvider>(context, listen: false);
    // final firebaseProvider =
    //     Provider.of<FirebaseProvider>(context, listen: false);
    // debugPrint('FCM token is: ${firebaseProvider.fcmToken}');
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
          child: const SvgIcon(
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
                  top: 130.h,
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
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // * Country Code Widget
                        Container(
                          height: 48.h,
                          width: 48.w,
                          decoration: const BoxDecoration(
                            color: AppColors.white,
                            shape: BoxShape.circle,
                          ),
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
                        //* Mobile Number Text Field
                        Expanded(
                          child: Consumer<LoginProvider>(
                            builder: (context, provider, child) =>
                                // * FocusScope.of(context).unfocus();
                                TextFormField(
                              controller: provider.phoneController,
                              focusNode: provider.mobilenumberFocusNode,
                              keyboardType: TextInputType.number,
                              textInputAction: TextInputAction.done,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                LengthLimitingTextInputFormatter(10),
                              ],
                              validator: provider.validateMobileNumber,
                              onChanged: provider.onChangeMobileNumber,
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
                    if (accountType ==
                        'personal') // condition: visible for only personal accountType
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
                                  fontSize: 14.sp,
                                  color: getColorAccountType(
                                    accountType: accountType,
                                    businessColor: AppColors.seaShell,
                                    personalColor: AppColors.seaMist,
                                  ),
                                ),
                              ),
                              Text(
                                'Register Now'.toUpperCase(),
                                style: GoogleFonts.publicSans(
                                  fontSize: 14.sp,
                                  color: getColorAccountType(
                                    accountType: accountType,
                                    businessColor: AppColors.seaShell,
                                    personalColor: AppColors.seaMist,
                                  ),
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
