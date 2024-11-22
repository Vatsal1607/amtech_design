import 'package:amtech_design/core/utils/constants/keys.dart';
import 'package:amtech_design/core/utils/strings.dart';
import 'package:amtech_design/custom_widgets/svg_icon.dart';
import 'package:amtech_design/main.dart';
import 'package:amtech_design/modules/auth/location_selection/location_selection_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../core/utils/app_colors.dart';
import '../../../custom_widgets/custom_button.dart';
import '../../../routes.dart';
import '../../../services/local/shared_preferences_service.dart';
import 'widgets/account_selection_button.dart';

class AccountSelectionPage extends StatelessWidget {
  const AccountSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            ImageStrings.accountSelectionBg,
            fit: BoxFit.cover,
          ),
          Positioned.fill(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(left: 34.w, right: 34.w, top: 120.h),
                child: Column(
                  children: [
                    Image.asset(
                      ImageStrings.appLogo,
                      color: AppColors.primaryColor,
                    ),
                    SizedBox(height: 200.h),
                    Text(
                      'Choose Account',
                      style: GoogleFonts.publicSans(
                        fontSize: 40.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 13.h),
                    Text(
                      'SELECT YOUR ACCOUNT TYPE',
                      style: GoogleFonts.publicSans(
                        fontSize: 15.sp,
                      ),
                    ),
                    SizedBox(height: 20.h),

                    // custom widget of Account selection button
                    AccountSelectionButton(
                      onTap: () {
                        // Update & Save accountType in local storage
                        context
                            .read<LocationSelectionProvider>()
                            .updateAccountType('business');
                        Navigator.pushNamed(context, Routes.locationSelection);
                      },
                      text: 'business account',
                      icon: IconStrings.businessAccount,
                    ),
                    SizedBox(height: 17.h),
                    AccountSelectionButton(
                      onTap: () {
                        // Update & Save accountType in local storage
                        context
                            .read<LocationSelectionProvider>()
                            .updateAccountType('personal');
                        Navigator.pushNamed(context, Routes.locationSelection);
                      },
                      text: 'personal account',
                      icon: IconStrings.personalAccount,
                      bgColor: AppColors.darkGreenGrey,
                      textColor: AppColors.seaMist,
                      iconColor: AppColors.bayLeaf,
                    ),
                    SizedBox(height: 16.h),

                    // Custom button
                    CustomButton(
                      onTap: () {
                        debugPrint('Next pressed');
                      },
                    ),
                    SizedBox(height: 12.h),
                    RichText(
                      text: TextSpan(
                          text: 'BY PROCEEDING, YOU ACCEPT OUR ',
                          style: GoogleFonts.publicSans(
                              fontSize: 10.sp, color: AppColors.black),
                          children: [
                            TextSpan(
                              text: 'T&C ',
                              style: GoogleFonts.publicSans(
                                fontWeight: FontWeight.bold,
                                fontSize: 10.sp,
                              ),
                            ),
                            TextSpan(
                              text: 'AND ',
                              style: GoogleFonts.publicSans(
                                fontSize: 10.sp,
                              ),
                            ),
                            TextSpan(
                              text: 'PRIVACY POLICY.',
                              style: GoogleFonts.publicSans(
                                fontWeight: FontWeight.bold,
                                fontSize: 10.sp,
                              ),
                            ),
                          ]),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
