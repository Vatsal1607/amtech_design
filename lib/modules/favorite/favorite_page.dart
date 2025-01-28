import 'package:amtech_design/custom_widgets/appbar/custom_appbar_with_center_title.dart';
import 'package:amtech_design/custom_widgets/bottom_blur_on_page.dart';
import 'package:amtech_design/custom_widgets/loader/custom_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../core/utils/app_colors.dart';
import '../../core/utils/constants/keys.dart';
import '../../core/utils/strings.dart';
import '../../routes.dart';
import '../../services/local/shared_preferences_service.dart';
import 'favorite_provider.dart';
import 'widgets/favourite_items_widget.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  void initState() {
    context.read<FavoritesProvider>().getFavorite();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String accountType =
        sharedPrefsService.getString(SharedPrefsKeys.accountType) ?? '';
    final provider = Provider.of<FavoritesProvider>(context, listen: false);

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
          Consumer<FavoritesProvider>(
            builder: (context, _, child) => provider.isLoading
                ? const Center(
                    child: CustomLoader(
                    backgroundColor: AppColors.primaryColor,
                  ))
                : provider.favoriteList != null &&
                        provider.favoriteList!.isNotEmpty
                    ? GridView.builder(
                        shrinkWrap: true,
                        itemCount: provider.favoriteList?.length ?? 0,
                        padding: EdgeInsets.symmetric(
                            horizontal: 32.w, vertical: 25.h),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 15.w,
                          mainAxisSpacing: 25.h,
                          childAspectRatio: .85,
                        ),
                        itemBuilder: (context, index) {
                          final menuDetails =
                              provider.favoriteList?[index].menuDetails;

                          return GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                Routes.productDetails,
                                arguments: {
                                  'menuId': menuDetails?.sId,
                                },
                              );
                            },
                            child: FavoriteItemsWidget(
                              width: 165.w,
                              menuDetails: menuDetails,
                              index: index,
                              accountType: accountType,
                            ),
                          );
                        },
                      )
                    : Center(
                        child: Text(
                          'No favorite items found!',
                          style: GoogleFonts.publicSans(
                            fontSize: 20.sp,
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ),
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
