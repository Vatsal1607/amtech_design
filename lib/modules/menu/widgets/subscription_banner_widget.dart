import 'dart:async';
import 'dart:developer';
import 'package:amtech_design/core/utils/constants/keys.dart';
import 'package:amtech_design/custom_widgets/custom_confirm_dialog.dart';
import 'package:amtech_design/custom_widgets/snackbar.dart';
import 'package:amtech_design/custom_widgets/svg_icon.dart';
import 'package:amtech_design/services/local/shared_preferences_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/strings.dart';
import '../../../routes.dart';

class SubscriptionBannerWidget extends StatefulWidget {
  final String accountType;
  const SubscriptionBannerWidget({super.key, required this.accountType});

  @override
  State<SubscriptionBannerWidget> createState() =>
      _SubscriptionBannerWidgetState();
}

class _SubscriptionBannerWidgetState extends State<SubscriptionBannerWidget> {
  bool _showFirstImage = true;

  @override
  void initState() {
    // Timer to switch images every 3 seconds
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Timer.periodic(const Duration(seconds: 3), (timer) {
        if (mounted) {
          setState(() {
            _showFirstImage = !_showFirstImage;
          });
        }
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120.h,
      margin: EdgeInsets.symmetric(
        horizontal: 20.w,
      ),
      decoration: BoxDecoration(
        color: AppColors.primaryColor, // Dark blue background
        borderRadius: BorderRadius.circular(30.r),
        image: const DecorationImage(
          image: AssetImage(
            ImageStrings.subscriptionBannerDoodle,
          ),
        ),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Juice Image
          Positioned(
            left: 0,
            bottom: 0,
            top: -20,
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 500), // Smooth transition
              transitionBuilder: (Widget child, Animation<double> animation) {
                return FadeTransition(opacity: animation, child: child);
              },
              child: _showFirstImage
                  ? Image.asset(
                      ImageStrings.subscriptionBanner1,
                      key: const ValueKey(1),
                      height: 150.h,
                      fit: BoxFit.cover,
                    )
                  : Image.asset(
                      ImageStrings.subscriptionBanner2,
                      key: const ValueKey(2),
                      height: 150.h,
                      fit: BoxFit.cover,
                    ),
            ),
          ),

          // Text Content
          Positioned(
            right: 25.w,
            top: 10.h,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Grab More, Pay Less!",
                  style: GoogleFonts.poppins(
                    fontSize: 12.sp,
                    color: AppColors.seaShell,
                  ),
                ),
                Text(
                  "Enjoy Your Favorites",
                  style: GoogleFonts.poppins(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.disabledColor,
                  ),
                ),
                Text(
                  "With A Subscription Plans.",
                  style: GoogleFonts.poppins(
                    fontSize: 12.sp,
                    color: AppColors.seaShell,
                  ),
                ),
              ],
            ),
          ),

          // Subscription Button
          Positioned(
            bottom: 15.h,
            right: 20.w,
            child: GestureDetector(
              onTap: () {
                final isLoggedIn =
                    sharedPrefsService.getBool(SharedPrefsKeys.isLoggedIn);
                if (isLoggedIn == true) {
                  Navigator.pushNamed(context, Routes.createSubscriptionPlan);
                } else {
                  showDialog(
                    context: context,
                    builder: (context) => CustomConfirmDialog(
                      title: 'Login Required',
                      subTitle: 'Please log in to use this feature.',
                      accountType: widget.accountType,
                      yesBtnText: 'Login',
                      onTapYes: () {
                        Navigator.pop(context);
                        Navigator.pushNamed(context, Routes.accountSelection);
                      },
                    ),
                  );
                }
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFFFED74B), // Light Gold
                      Color(0xFFEFBF2F), // Gold
                      Color(0xFFDAA71A), // Deep Gold
                      Color(0xFFE7C742), // Yellow Gold
                      Color(0xFFFDF579), // Lightest Gold
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(30.r),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SvgIcon(
                      icon: IconStrings.subscriptionCrown,
                      color: AppColors.primaryColor,
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      "GET A SUBSCRIPTION",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                        fontSize: 12.sp,
                        color: AppColors.primaryColor,
                      ),
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
