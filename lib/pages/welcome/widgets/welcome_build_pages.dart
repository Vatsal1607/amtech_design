import 'package:amtech_design/core/utils/strings.dart';
import 'package:amtech_design/custom_widgets/svg_icon.dart';
import 'package:amtech_design/pages/welcome/welcome_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../core/utils/app_colors.dart';
import '../../../routes.dart';

class WelcomeBuildPages extends StatelessWidget {
  final String image;
  final String title;
  final Color? titleColor;
  final String subTitle;

  const WelcomeBuildPages({
    super.key,
    required this.image,
    required this.title,
    this.titleColor,
    required this.subTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          // width: 1.sw,
          image,
        ),
        // Image.asset(GifStrings.smoke,),
        Positioned.fill(
          top: 95.h,
          left: 30.w,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title.toUpperCase(),
                style: GoogleFonts.publicSans(
                  height: 1.h,
                  fontSize: 50.sp,
                  color: titleColor ?? AppColors.lemonChiffon,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 11.h),
              Text(
                subTitle.toUpperCase(),
                style: GoogleFonts.publicSans(
                    fontSize: 15.sp, color: AppColors.white),
              ),
              Consumer<WelcomeProvider>(builder: (context, provider, child) {
                return provider.currentPage == 2
                    ? Column(
                        children: [
                          SizedBox(height: 17.h),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, Routes.accountSelection);
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 14.h, horizontal: 23.w),
                              decoration: BoxDecoration(
                                color: AppColors.irishGreen,
                                borderRadius: BorderRadius.circular(100.r),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'GET STARTED',
                                    style: GoogleFonts.publicSans(
                                      color: AppColors.white,
                                    ),
                                  ),
                                  SizedBox(width: 8.w),
                                  SvgIcon(
                                    icon: IconStrings.arrowNext,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      )
                    : const SizedBox();
              }),
            ],
          ),
        ),
      ],
    );
  }
}
