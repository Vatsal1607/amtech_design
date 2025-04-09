import 'package:amtech_design/custom_widgets/size_modal_bottom_sheet.dart';
import 'package:amtech_design/modules/menu/menu_provider.dart';
import 'package:amtech_design/modules/product_page/product_details_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/constant.dart';
import '../../../core/utils/strings.dart';
import '../../../custom_widgets/svg_icon.dart';
import '../../../models/favorites_model.dart';
import '../favorite_provider.dart';

class FavoriteItemsWidget extends StatelessWidget {
  final MenuDetails? menuDetails;
  final int index;
  final String accountType;
  final bool isHealthFirst;
  final double? height;
  final double? width;
  const FavoriteItemsWidget({
    super.key,
    this.menuDetails,
    required this.index,
    required this.accountType,
    this.isHealthFirst = false,
    this.height,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    final menuProvider = Provider.of<MenuProvider>(context, listen: false);
    final detailsProvider =
        Provider.of<ProductDetailsProvider>(context, listen: false);
    final favoriteProvider =
        Provider.of<FavoritesProvider>(context, listen: false);
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(menuDetails?.images?.first ?? ''),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(30.r),
            border: Border.all(
              color:
                  isHealthFirst ? AppColors.deepGreen : AppColors.primaryColor,
              width: 2.w,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.center,
                children: [
                  // * Gradient Overlay at the Bottom
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: 55.h,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: isHealthFirst
                              ? [
                                  AppColors.teaGreen.withOpacity(0.0),
                                  AppColors.teaGreen.withOpacity(0.8),
                                  AppColors.teaGreen,
                                ]
                              : [
                                  getColorAccountType(
                                      accountType: accountType,
                                      businessColor:
                                          AppColors.seaShell.withOpacity(0.0),
                                      personalColor:
                                          AppColors.seaMist.withOpacity(0.0)),
                                  getColorAccountType(
                                      accountType: accountType,
                                      businessColor:
                                          AppColors.seaShell.withOpacity(0.8),
                                      personalColor:
                                          AppColors.seaMist.withOpacity(0.8)),
                                  getColorAccountType(
                                      accountType: accountType,
                                      businessColor: AppColors.seaShell,
                                      personalColor: AppColors.seaMist),
                                ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          stops: const [0.0, 0.5, 1.0],
                        ),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(30.r),
                          bottomRight: Radius.circular(30.r),
                        ),
                      ),
                    ),
                  ),
                  // * Foreground Content
                  Text(
                    capitalizeEachWord(menuDetails?.itemName ?? ''),
                    maxLines: 1,
                    overflow: TextOverflow.visible,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.publicSans(
                      fontWeight: FontWeight.bold,
                      fontSize: 12.sp,
                      color: isHealthFirst
                          ? AppColors.deepGreen
                          : getColorAccountType(
                              accountType: accountType,
                              businessColor: AppColors.primaryColor,
                              personalColor: AppColors.darkGreenGrey,
                            ),
                    ),
                  ),
                ],
              ),
              // SizedBox(height: 8.h),
            ],
          ),
        ),
        Positioned(
          top: 13.h,
          right: 25.w,
          child: GestureDetector(
            onTap: () {
              detailsProvider
                  .removeFavorite(
                      context: context, menuId: menuDetails?.sId ?? '')
                  .then((isSuccess) {
                if (isSuccess) {
                  favoriteProvider.getFavorite(); //* API call
                }
              });
            },
            child: const Icon(
              Icons.favorite,
              color: AppColors.lightGreen,
            ),
          ),
        ),
        Positioned(
          bottom: -7,
          left: 0,
          right: 0,
          child: Align(
            alignment: Alignment.bottomCenter,
            // * Add button
            child: GestureDetector(
              onTap: () {
                //* Custom Size bottomsheet
                showSizeModalBottomSheet(
                  context: context,
                  accountType: accountType,
                  provider: menuProvider,
                  menuId: menuDetails?.sId ?? '',
                );
                // showSnackbar(context, '{count} ITEMS ADDED');
              },
              child: Container(
                padding: EdgeInsets.symmetric(
                  vertical: 3.h,
                  horizontal: 8.w,
                ),
                decoration: BoxDecoration(
                  color: isHealthFirst
                      ? AppColors.deepGreen
                      : getColorAccountType(
                          accountType: accountType,
                          businessColor: AppColors.primaryColor,
                          personalColor: AppColors.darkGreenGrey,
                        ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'ADD',
                      style: GoogleFonts.publicSans(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.white,
                      ),
                    ),
                    SizedBox(width: 4.w),
                    const SvgIcon(icon: IconStrings.add),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
