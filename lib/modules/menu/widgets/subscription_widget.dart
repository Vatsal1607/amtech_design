import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/constant.dart';
import '../../../core/utils/constants/keys.dart';
import '../../../services/local/shared_preferences_service.dart';
import '../menu_provider.dart';

class SubscriptionWidget extends StatelessWidget {
  const SubscriptionWidget({
    super.key,
    required this.provider,
  });

  final MenuProvider provider;

  @override
  Widget build(BuildContext context) {
    String accountType =
        sharedPrefsService.getString(SharedPrefsKeys.accountType) ?? '';
    return Column(
      children: [
        SizedBox(
          height: 250.h,
          width: 425.w,
          child: CarouselSlider.builder(
            itemCount: provider.banners.length,
            options: CarouselOptions(
              autoPlay: true,
              viewportFraction: 1, // * Space between pages
              enableInfiniteScroll: false, // * Disable infinite scrolling
              onPageChanged: provider.onPageChangedsubscription,
            ),
            itemBuilder: (context, index, realIndex) {
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 20.w),
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    //! working
                  ]),
                  borderRadius: BorderRadius.circular(20.r),
                  image: DecorationImage(
                    image: AssetImage(provider.subscriptionImages[index]),
                    fit: BoxFit.fitWidth,
                  ),
                ),
              );
            },
          ),
        ),
        SizedBox(height: 10.h),
        //* Dots indicator
        Consumer<MenuProvider>(
          builder: (context, provider, child) => AnimatedSmoothIndicator(
            activeIndex: provider.subscriptionCurrentIndex,
            count: provider.banners.length,
            effect: WormEffect(
              dotHeight: 7,
              dotWidth: 7,
              spacing: 5.w,
              activeDotColor: getColorAccountType(
                accountType: accountType,
                businessColor: AppColors.primaryColor,
                personalColor: AppColors.darkGreenGrey,
              ),
              dotColor: getColorAccountType(
                accountType: accountType,
                businessColor: AppColors.primaryColor.withOpacity(0.5),
                personalColor: AppColors.darkGreenGrey.withOpacity(0.5),
              ),
            ),
          ),
        ),
        SizedBox(height: 10.h),
      ],
    );
  }
}
