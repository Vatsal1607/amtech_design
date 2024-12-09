import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../core/utils/app_colors.dart';
import 'welcome_provider.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // PageView for sliding between pages
          Consumer<WelcomeProvider>(
            builder: (context, provider, child) {
              return PageView(
                physics: const ClampingScrollPhysics(),
                controller: provider.pageController,
                onPageChanged: provider.updatePage,
                children: provider.welcomePages,
              );
            },
          ),

          // 3-dot indicator at top-left corner
          Positioned(
            top: 75.h,
            left: 34.w,
            child: Consumer<WelcomeProvider>(
              builder: (context, provider, child) => SmoothPageIndicator(
                controller: provider.pageController,
                count: provider.welcomePages.length,
                effect: WormEffect(
                  dotHeight: 7,
                  dotWidth: 7,
                  activeDotColor: AppColors.white,
                  dotColor: AppColors.white.withOpacity(0.5),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
