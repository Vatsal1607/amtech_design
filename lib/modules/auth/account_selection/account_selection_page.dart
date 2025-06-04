import 'package:amtech_design/core/utils/strings.dart';
import 'package:amtech_design/modules/auth/location_selection/location_selection_provider.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../core/utils/app_colors.dart';
import '../../../routes.dart';
import '../../../services/local/device_info_service.dart';
import '../../notification/notification_service.dart';
import 'widgets/account_selection_button.dart';

class AccountSelectionPage extends StatefulWidget {
  const AccountSelectionPage({super.key});

  @override
  State<AccountSelectionPage> createState() => _AccountSelectionPageState();
}

class _AccountSelectionPageState extends State<AccountSelectionPage> {
  @override
  void initState() {
    super.initState();
    _initNotifications();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      DeviceInfoService().fetchDeviceId(context);
    });
  }

  Future<void> _initNotifications() async {
    await NotificationService.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            height: 1.sh,
            width: 1.sw,
            ImageStrings.accountSelectionBg,
            fit: BoxFit.cover,
          ),
          Positioned(
            top: 75.h,
            right: 34.w,
            //* Skip button
            child: GestureDetector(
              onTap: () {
                // Navigator.pushNamed(context, Routes.bottomBarPage);
                Navigator.of(context, rootNavigator: true)
                    .pushNamed(Routes.bottomBarPage);
              },
              child: Padding(
                padding: EdgeInsets.all(5.w),
                child: Text(
                  'SKIP >',
                  style: GoogleFonts.publicSans(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: Padding(
              padding: EdgeInsets.only(left: 34.w, right: 34.w, top: 130.h),
              child: Column(
                children: [
                  Image.asset(
                    ImageStrings.appLogo,
                    color: AppColors.primaryColor,
                  ),
                ],
              ),
            ),
          ),
          Positioned.fill(
            bottom: 90.h,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 34.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
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
                      // * Update & Save accountType in local storage // Todo
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
                  SizedBox(height: 17.h),
                  AccountSelectionButton(
                    onTap: () {
                      // * Update & Save accountType in local storage // Todo
                      context
                          .read<LocationSelectionProvider>()
                          .updateAccountType('business');
                      Navigator.pushNamed(context, Routes.locationSelection);
                    },
                    text: 'business account',
                    icon: IconStrings.businessAccount,
                  ),
                  SizedBox(height: 16.h),

                  RichText(
                    text: TextSpan(
                      text: 'BY PROCEEDING, YOU ACCEPT OUR ',
                      style: GoogleFonts.publicSans(
                          fontSize: 10.sp, color: AppColors.black),
                      children: [
                        TextSpan(
                          text: 'T&C ',
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.pushNamed(context, Routes.tAndC);
                            },
                          style: GoogleFonts.publicSans(
                            fontWeight: FontWeight.bold,
                            fontSize: 12.sp,
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
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.pushNamed(
                                  context, Routes.privacyPolicy);
                            },
                          style: GoogleFonts.publicSans(
                            fontWeight: FontWeight.bold,
                            fontSize: 12.sp,
                          ),
                        ),
                      ],
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
