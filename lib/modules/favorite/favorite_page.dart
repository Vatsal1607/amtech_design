import 'package:amtech_design/custom_widgets/appbar/custom_appbar_with_center_title.dart';
import 'package:amtech_design/custom_widgets/bottom_blur_on_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/utils/app_colors.dart';
import '../../core/utils/strings.dart';
import '../../routes.dart';
import 'widgets/favourite_items_widget.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    String accountType = 'business'; // Todo imp set dynamic
    // sharedPrefsService.getString(SharedPrefsKeys.accountType) ?? '';
    return Scaffold(
      appBar: CustomAppbarWithCenterTitle(
        title: 'Favorite Items',
        accountType: accountType,
        isAction: true,
        actionIcon: IconStrings.more,
        actionIconColor: AppColors.primaryColor,
      ),
      body: Stack(
        children: [
          GridView.builder(
            shrinkWrap: true,
            itemCount: 10,
            padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 25.h),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 15.w,
              mainAxisSpacing: 25.h,
              childAspectRatio: .85,
            ),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, Routes.productDetails);
                },
                child: FavoriteItemsWidget(
                  width: 165.w,
                  image: ImageStrings.masalaTea2,
                  name: 'Masala Tea',
                  index: index,
                  accountType: accountType,
                ),
              );
            },
          ),
          BottomBlurOnPage(
            accountType: accountType,
            isTopBlur: true,
          ),
          BottomBlurOnPage(
            accountType: accountType,
          ),
        ],
      ),
    );
  }
}
