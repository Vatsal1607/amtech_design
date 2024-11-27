import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/constant.dart';
import '../../../core/utils/strings.dart';
import '../../product_page/product_page.dart';
import '../menu_provider.dart';

class BannerView extends StatelessWidget {
  final String accountType;
  const BannerView({
    super.key,
    required this.accountType,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                ProductPage.route(),
              );
            },
            child: Container(
              height: 102.0,
              // width: 300.0,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    getColorAccountType(
                      accountType: accountType,
                      businessColor: AppColors.primaryColor,
                      personalColor: AppColors.darkGreenGrey,
                    ),
                    getColorAccountType(
                      accountType: accountType,
                      businessColor: AppColors.disabledColor,
                      personalColor: AppColors.seaMist,
                    ),
                  ],
                ),
                borderRadius: BorderRadius.circular(30.0),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    offset: Offset(0, 4),
                    blurRadius: 6,
                  ),
                ],
              ),
              child: Consumer<MenuProvider>(
                builder: (context, provider, child) => PageView.builder(
                  controller: provider.pageController,
                  itemCount: provider.banners.length,
                  itemBuilder: (context, index) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 12.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'A FRESH CUP OF',
                                style: GoogleFonts.publicSans(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.white,
                                ),
                              ),
                              Text(
                                'MASALA CHAI',
                                style: GoogleFonts.publicSans(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: getColorAccountType(
                                    accountType: accountType,
                                    businessColor: AppColors.disabledColor,
                                    personalColor: AppColors.seaMist,
                                  ),
                                ),
                              ),
                              Text(
                                'IS WAITING FOR YOU!',
                                style: GoogleFonts.publicSans(
                                  fontSize: 10,
                                  color: AppColors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Image.asset(
                          ImageStrings.bannerImage,
                          fit: BoxFit.cover,
                        ),
                      ],
                    );
                  },
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
