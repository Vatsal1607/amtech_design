import 'package:amtech_design/custom_widgets/appbar/appbar_with_back_button.dart';
import 'package:amtech_design/custom_widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/constants/keys.dart';
import '../../../core/utils/strings.dart';
import '../../../custom_widgets/buttons/custom_button.dart';
import '../../../routes.dart';
import '../../../services/local/shared_preferences_service.dart';
import 'business_dropdown.dart';
import 'business_selection_provider.dart';

class BusinessSelectionPage extends StatelessWidget {
  const BusinessSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider =
        Provider.of<BusinessSelectionProvider>(context, listen: false);
    return Scaffold(
      resizeToAvoidBottomInset: false, //image did't by the keyboard
      backgroundColor: AppColors.primaryColor,
      appBar: const AppBarWithBackButton(),
      extendBodyBehindAppBar: true, // show content of body behind appbar
      body: Stack(
        children: [
          Image.asset(
            width: 1.sw,
            height: 1.sh,
            ImageStrings.locationSelectionBg,
            // fit: BoxFit.cover,
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
                    'Choose Your Business',
                    style: GoogleFonts.publicSans(
                      fontSize: 40.sp,
                      color: AppColors.disabledColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    'SELECT YOUR company or add one.'.toUpperCase(),
                    style: GoogleFonts.publicSans(
                      fontSize: 15.sp,
                      color: AppColors.seaShell,
                    ),
                  ),
                  SizedBox(height: 16.h),

                  //* Dropdown button
                  BusinessDropdown(
                    provider: provider,
                  ),

                  SizedBox(height: 8.h),
                  GestureDetector(
                    onTap: () {
                      /// Navigator
                      Navigator.pushNamed(context, Routes.register);
                    },
                    child: Container(
                      padding: EdgeInsets.all(10.w),
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.circular(25.r),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Can\'t find your business? '.toUpperCase(),
                            style: GoogleFonts.publicSans(
                              fontSize: 14.sp,
                              color: AppColors.seaShell,
                            ),
                          ),
                          Text(
                            'Register Now'.toUpperCase(),
                            style: GoogleFonts.publicSans(
                              fontSize: 14.sp,
                              color: AppColors.disabledColor,
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
              child: CustomButton(
                height: 48.h,
                onTap: () {
                  // store data localy
                  sharedPrefsService.setString(
                    SharedPrefsKeys.company,
                    context
                            .read<BusinessSelectionProvider>()
                            .selectedBusiness
                            ?.businessName ??
                        '',
                  );
                  if (provider.selectedBusiness?.businessName != null &&
                      provider.selectedBusiness!.businessName!.isNotEmpty) {
                    Navigator.pushNamed(context, Routes.login);
                  } else {
                    customSnackBar(
                      context: context,
                      message: 'Please Select Your Business',
                      backgroundColor: AppColors.seaShell,
                      textColor: AppColors.primaryColor,
                    );
                  }
                },
                bgColor: AppColors.disabledColor,
                textColor: AppColors.primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
