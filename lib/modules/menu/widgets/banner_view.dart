import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/constant.dart';
import '../../../routes.dart';
import '../menu_provider.dart';

class BannerView extends StatelessWidget {
  final String accountType;
  const BannerView({
    super.key,
    required this.accountType,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(
                context,
                Routes.productDetails,
              );
            },
            child: SizedBox(
              height: 125.h, // banner height
              width: 425.w,
              // decoration: BoxDecoration(
              //     // borderRadius: BorderRadius.circular(30.r),
              //     ),
              child: Consumer<MenuProvider>(
                builder: (context, provider, child) => CarouselSlider.builder(
                  itemCount: provider.banners.length,
                  options: CarouselOptions(
                    height: 350.h,
                    autoPlay: true,
                    viewportFraction: 1, // * Space between pages
                    enableInfiniteScroll: false, // * Disable infinite scrolling
                    onPageChanged: provider.onPageChangedCarousel,
                  ),
                  itemBuilder: (context, index, realIndex) {
                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: 20.w),
                      decoration: BoxDecoration(
                        // boxShadow: kDropShadow,
                        borderRadius: BorderRadius.circular(20.r),
                        image: DecorationImage(
                          image: AssetImage(provider.banners[index]),
                          fit: BoxFit.fill,
                        ),
                      ),
                    );
                  },
                ),
                // * old banner view
                // builder: (context, provider, child) => PageView.builder(
                //   controller: provider.pageController,
                //   itemCount: provider.banners.length,
                //   itemBuilder: (context, index) {
                //     /// New banner
                //     return Container(
                //       decoration: BoxDecoration(
                //         borderRadius: BorderRadius.circular(20.r),
                //         image: DecorationImage(
                //           image: AssetImage(provider.banners[index]),
                //           fit: BoxFit.fill,
                //         ),
                //       ),
                //     );
                //   },
                // ),
              ),
            ),
          ),
          SizedBox(height: 8.h),
          // Dots indicator
          Consumer<MenuProvider>(
            builder: (context, provider, child) => AnimatedSmoothIndicator(
              activeIndex: provider.carouselCurrentIndex,
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
        ],
      ),
    );
  }
}
