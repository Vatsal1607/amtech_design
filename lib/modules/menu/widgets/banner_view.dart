import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/constant.dart';
import '../../../routes.dart';
import '../../product_page/product_details_page.dart';
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
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(
                context,
                Routes.productDetails,
              );
            },
            child: Container(
              height: 122.h, // banner height
              // width: 328.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.r),
                // boxShadow: [
                //   bottomShadow(),
                // ],
              ),
              child: SizedBox(
                height: 120.h,
                // * Pageview
                child: Consumer<MenuProvider>(
                  builder: (context, provider, child) => PageView.builder(
                    controller: provider.pageController,
                    itemCount: provider.banners.length,
                    itemBuilder: (context, index) {
                      /// New banner
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30.r),
                          image: DecorationImage(
                            image: AssetImage(provider.banners[index]),
                            fit: BoxFit.fill,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          // Dots indicator
          Consumer<MenuProvider>(
            builder: (context, provider, child) => SmoothPageIndicator(
              controller: provider.pageController,
              count: provider.banners.length,
              effect: WormEffect(
                dotHeight: 7,
                dotWidth: 7,
                activeDotColor: getColorAccountType(
                  accountType: accountType,
                  businessColor: AppColors.primaryColor,
                  personalColor: AppColors.darkGreenGrey,
                ),
                dotColor: getColorAccountType(
                    accountType: accountType,
                    businessColor: AppColors.primaryColor.withOpacity(0.5),
                    personalColor: AppColors.darkGreenGrey.withOpacity(0.5)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
