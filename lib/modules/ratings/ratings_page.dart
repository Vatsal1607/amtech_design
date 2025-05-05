import 'dart:ui';
import 'package:amtech_design/core/utils/constant.dart';
import 'package:amtech_design/custom_widgets/buttons/custom_button.dart';
import 'package:amtech_design/custom_widgets/svg_icon.dart';
import 'package:amtech_design/modules/ratings/ratings_provider.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../core/utils/app_colors.dart';
import '../../core/utils/constants/keys.dart';
import '../../core/utils/strings.dart';
import '../../services/local/shared_preferences_service.dart';

// * Dialog
class RatingsPage extends StatelessWidget {
  const RatingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    String accountType =
        sharedPrefsService.getString(SharedPrefsKeys.accountType) ?? '';
    final provider = Provider.of<RatingsProvider>(context);
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.zero,
      child: Stack(
        children: [
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 12.0, sigmaY: 12.0),
            child: Container(
              height: 1.sh,
              width: 1.sw,
              color: getColorAccountType(
                accountType: accountType,
                businessColor: AppColors.seaShell.withOpacity(0.3),
                personalColor: AppColors.seaMist.withOpacity(0.3),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 70.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 32.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Rate Our Items',
                        style: GoogleFonts.publicSans(
                          fontSize: 24.sp,
                          fontWeight: FontWeight.bold,
                          color: getColorAccountType(
                            accountType: accountType,
                            businessColor: AppColors.seaShell,
                            personalColor: AppColors.seaMist,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          height: 48.h,
                          width: 48.h,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: getColorAccountType(
                              accountType: accountType,
                              businessColor: AppColors.seaShell.withOpacity(.5),
                              personalColor: AppColors.seaMist.withOpacity(.5),
                            ),
                          ),
                          child: SvgIcon(
                            icon: IconStrings.close,
                            color: getColorAccountType(
                              accountType: accountType,
                              businessColor: AppColors.seaShell,
                              personalColor: AppColors.seaMist,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Column(
                  children: [
                    Consumer<RatingsProvider>(
                      builder: (context, _, child) => CarouselSlider.builder(
                        itemCount: provider.items.length,
                        options: CarouselOptions(
                          height: 350.h,
                          autoPlay: false,
                          enableInfiniteScroll:
                              false, // * Disable infinite scrolling
                          onPageChanged: provider.onPageChanged,
                        ),
                        itemBuilder: (context, index, realIndex) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(30.r),
                                child: Stack(
                                  children: [
                                    // * Image
                                    Container(
                                      height: 300.h,
                                      width: 300.w,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(30.r),
                                        image: DecorationImage(
                                          image: AssetImage(
                                            provider.items[index]['image'],
                                          ),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    // * Foreground content with gradient background
                                    Positioned(
                                      bottom: 0,
                                      left: 0,
                                      right: 0,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            colors: accountType == 'business'
                                                ? [
                                                    AppColors.primaryColor
                                                        .withOpacity(0.0),
                                                    AppColors.primaryColor
                                                        .withOpacity(0.7),
                                                    AppColors.primaryColor,
                                                  ]
                                                : [
                                                    AppColors.darkGreenGrey
                                                        .withOpacity(0.0),
                                                    AppColors.darkGreenGrey
                                                        .withOpacity(0.7),
                                                    AppColors.darkGreenGrey,
                                                  ],
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(16.r),
                                        ),
                                        padding: EdgeInsets.all(16.r),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              'Masala Tea',
                                              style: GoogleFonts.publicSans(
                                                color: AppColors.white,
                                                fontSize: 20.sp,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            SizedBox(height: 10.h),
                                            // * Star Rating
                                            RatingBar.builder(
                                              initialRating:
                                                  provider.currentRating,
                                              minRating: 1,
                                              direction: Axis.horizontal,
                                              // allowHalfRating: true,
                                              itemCount: 5,
                                              itemSize: 25.w,
                                              itemPadding: EdgeInsets.symmetric(
                                                horizontal: 2.w,
                                              ),
                                              itemBuilder: (context, _) {
                                                // Determine if the star should be filled or outlined
                                                final isFilled = index <
                                                    provider.currentRating;

                                                return SvgIcon(
                                                  icon: isFilled
                                                      ? IconStrings.ratedStar
                                                      : IconStrings.unratedStar,
                                                  color: isFilled
                                                      ? AppColors.lightGreen
                                                      : AppColors.lightGreen
                                                          .withOpacity(0.5),
                                                );
                                              },

                                              onRatingUpdate:
                                                  provider.onRatingUpdate,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                    // * indicator
                    Consumer<RatingsProvider>(
                      builder: (context, _, child) => Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: provider.items.map((item) {
                          int index = provider.items.indexOf(item);
                          return Container(
                            width: 8.w,
                            height: 8.h,
                            margin: EdgeInsets.symmetric(horizontal: 2.w),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: provider.currentIndex == index
                                  ? AppColors.seaShell
                                  : AppColors.seaShell.withOpacity(.5),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 32.w),
                  child: CustomButton(
                    bgColor: getColorAccountType(
                      accountType: accountType,
                      businessColor: AppColors.seaShell.withOpacity(.5),
                      personalColor: AppColors.seaMist.withOpacity(.5),
                    ),
                    onTap: () {},
                    height: 55.h,
                    text: 'SUBMIT',
                    textColor: getColorAccountType(
                      accountType: accountType,
                      businessColor: AppColors.seaShell,
                      personalColor: AppColors.seaMist,
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
