import 'dart:developer';

import 'package:amtech_design/core/utils/constants/keys.dart';
import 'package:amtech_design/modules/menu/menu_provider.dart';
import 'package:amtech_design/modules/subscriptions/create_subscription_plan/ingredients_bottomsheet/ingredients_bottomsheet.dart';
import 'package:amtech_design/modules/subscriptions/create_subscription_plan/select_meal_bottomsheet/widgets/counter_widget.dart';
import 'package:amtech_design/custom_widgets/buttons/small_edit_button.dart';
import 'package:amtech_design/services/local/shared_preferences_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/constant.dart';
import '../../../../../models/home_menu_model.dart';
import '../select_meal_bottomsheet_provider.dart';

//! text should Unique category name for each tab
class BottomsheetTabbarViewWidget extends StatelessWidget {
  final String itemName;
  final SelectMealBottomsheetProvider provider;
  final MenuProvider menuProvider;
  final int itemLength;
  final List<MenuItems>? menuItems;
  final String day;
  final int mealIndex;
  const BottomsheetTabbarViewWidget({
    super.key,
    required this.itemName,
    required this.provider,
    required this.menuProvider,
    required this.itemLength,
    required this.menuItems,
    required this.day,
    required this.mealIndex,
  });

  @override
  Widget build(BuildContext context) {
    final String accountType =
        sharedPrefsService.getString(SharedPrefsKeys.accountType) ?? '';
    return ListView.builder(
      itemCount: itemLength,
      shrinkWrap: true,
      padding: EdgeInsets.only(top: 10.h, bottom: 80.h),
      itemBuilder: (context, index) {
        return Column(
          children: [
            Divider(
              color: getColorAccountType(
                accountType: accountType,
                businessColor: AppColors.disabledColor,
                personalColor: AppColors.bayLeaf,
              ),
              thickness: 0.5,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 14.h),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          itemName,
                          style: GoogleFonts.publicSans(
                              color: Colors.white,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 4.h),
                        Row(
                          children: [
                            Icon(
                              Icons.star,
                              color: getColorAccountType(
                                accountType: accountType,
                                businessColor: AppColors.disabledColor,
                                personalColor: AppColors.bayLeaf,
                              ),
                              size: 16,
                            ),
                            SizedBox(width: 4.w),
                            Text(
                              menuItems?[index].ratings.toString() ?? '',
                              style: GoogleFonts.publicSans(
                                fontSize: 14.sp,
                                color: getColorAccountType(
                                  accountType: accountType,
                                  businessColor: AppColors.disabledColor,
                                  personalColor: AppColors.bayLeaf,
                                ),
                              ),
                            ),
                            SizedBox(width: 8.w),
                            Text(
                              "• Best Seller",
                              style: GoogleFonts.publicSans(
                                color: getColorAccountType(
                                  accountType: accountType,
                                  businessColor: AppColors.disabledColor,
                                  personalColor: AppColors.bayLeaf,
                                ),
                                fontSize: 14.sp,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10.h),
                        Consumer<SelectMealBottomsheetProvider>(
                            builder: (context, provider, child) {
                          int quantity =
                              provider.getQuantity(day, itemName, index);
                          return quantity == 0
                              ? SmallEditButton(
                                  width: 108.w,
                                  height: 35.h,
                                  accountType: 'business',
                                  onTap: () {
                                    showIngredientsBottomSheeet(
                                      day: day,
                                      mealIndex: mealIndex,
                                      context: context,
                                      accountType: accountType,
                                      menuId: menuItems?[index].menuId ?? '',
                                      itemName:
                                          menuItems?[index].itemName ?? '',
                                      menuItems: menuItems?[index],
                                      mealItemIndex: index,
                                    );
                                    // Add meal item
                                    // provider.addMealItem(itemName, index);
                                  },
                                  bgColor: getColorAccountType(
                                    accountType: accountType,
                                    businessColor: AppColors.seaShell,
                                    personalColor: AppColors.seaMist,
                                  ),
                                  textColor: AppColors.primaryColor,
                                  text: 'Add',
                                  fontSize: 14.sp,
                                )
                              :
                              // * Show Quantity Counter
                              CustomCounterWidget(
                                  height: 35.h,
                                  accountType: accountType,
                                  onTapDecrease: () {
                                    //* decrementMealItem
                                    // provider.decrementMealItem(itemName, index);
                                  },
                                  onTapIncrease: () {
                                    //* incrementMealItem
                                    // provider.incrementMealItem(itemName, index);
                                  },
                                  quantity: quantity.toString(),
                                );
                        }),
                      ],
                    ),
                  ),
                  SizedBox(width: 10.w),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.r),
                    child: SizedBox(
                      width: 80.w,
                      height: 80.h,
                      child: Image.network(
                        (menuItems?[index].images?.isNotEmpty ?? false)
                            ? menuItems![index].images![0]
                            : 'https://via.placeholder.com/150', // Fallback image URL
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            const Icon(Icons.broken_image, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
