import 'dart:developer';

import 'package:amtech_design/core/utils/constant.dart';
import 'package:amtech_design/custom_widgets/loader/custom_loader.dart';
import 'package:amtech_design/custom_widgets/svg_icon.dart';
import 'package:amtech_design/modules/menu/menu_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../core/utils/app_colors.dart';
import '../core/utils/strings.dart';
import '../models/home_menu_model.dart';
import '../models/menu_size_model.dart';
import '../routes.dart';
import 'buttons/custom_button_with_arrow.dart';
import 'product_size_widget.dart';

final requiredSizes = ['MEDIUM', 'LARGE', 'REGULAR'];
// bool _hasFetchedMenuSize = false;

void showSizeModalBottomSheet({
  required BuildContext context,
  required String accountType,
  // final MenuSizeModel? menuSizeResponse,
  required MenuProvider provider,
  MenuItems? menuItems,
  required String menuId,
}) {
  showModalBottomSheet(
    context: context,
    backgroundColor: getColorAccountType(
      accountType: accountType,
      businessColor: AppColors.primaryColor,
      personalColor: AppColors.darkGreenGrey,
    ),
    isScrollControlled: false,
    builder: (context) {
      return FocusableActionDetector(
        autofocus: true,
        onFocusChange: (value) {
          log('onFocusChange: ${value.toString()}');
          if (value == true) {
            provider.getMenuSize(
              menuId: menuItems?.menuId?.toString() ?? (menuId ?? ''),
            );
          }
        },
        child: Stack(
          clipBehavior: Clip.none, // Allow visible outside the bounds
          children: [
            Positioned(
              child: Container(
                padding: EdgeInsets.only(top: 19.h),
                height: 380.h,
                width: 1.sw,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'select size'.toUpperCase(),
                      style: GoogleFonts.publicSans(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: getColorAccountType(
                          accountType: accountType,
                          businessColor: AppColors.seaShell,
                          personalColor: AppColors.seaMist,
                        ),
                      ),
                    ),
                    SizedBox(height: 17.h),
                    Consumer<MenuProvider>(
                      builder: (context, _, child) => provider.isLoadingSize
                          ? const Center(
                              child: CustomLoader(color: AppColors.seaShell),
                            )
                          : ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              // itemCount: provider.menuSizeResponse?.data
                              //         ?.sizeDetails?.length ??
                              //     0,
                              itemCount: requiredSizes.length,
                              padding: EdgeInsets.zero,
                              separatorBuilder: (context, index) =>
                                  SizedBox(height: 10.h),
                              itemBuilder: (context, index) {
                                // final sizeDetails = provider
                                //     .menuSizeResponse?.data?.sizeDetails?[index];
                                final sizeDetailsList = provider
                                        .menuSizeResponse?.data?.sizeDetails ??
                                    [];
                                // Find the current size in the response
                                final matchingSize = sizeDetailsList.firstWhere(
                                  (detail) =>
                                      detail.sizeName == requiredSizes[index],
                                  orElse: () => SizeDetails(
                                    sizeName: null,
                                    volume: null,
                                    price: null,
                                  ),
                                );
                                // If not found, create a disabled widget for the missing size
                                final isDisabled = matchingSize.sizeName !=
                                    requiredSizes[index];
                                // Display price and volume if the size exists, else show placeholders
                                final price = isDisabled
                                    ? '0'
                                    : matchingSize.price.toString();
                                final volume =
                                    isDisabled ? '0' : matchingSize.volume;
                                // Ensure the map has the required size
                                // provider.quantities = {
                                //   for (var size in requiredSizes) size: 0
                                // };
                                // Access the current quantity of the size
                                // final quantity =
                                //     provider.quantities[requiredSizes[index]] ??
                                //         0;
                                // log('bottomsheet quantity:- $quantity');
                                return ProductSizeWidget(
                                  accountType: accountType,
                                  // size: '${sizeDetails?.sizeName}',
                                  size: requiredSizes[index],
                                  isDisabled: isDisabled,
                                  price: price.toString(),
                                  volume: volume ?? '',
                                  quantity: provider
                                          .quantities[requiredSizes[index]] ??
                                      0,
                                );
                              },
                            ),
                    ),
                    SizedBox(height: 9.h),

                    // * Added to cart button
                    CustomButtonWithArrow(
                      onTap: () {
                        Navigator.pushNamed(context, Routes.cart);
                      },
                      accountType: accountType,
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: -40,
              right: 0,
              left: 0,
              child: IgnorePointer(
                ignoring: true,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    debugPrint('Close pressed');
                  },
                  child: Container(
                    height: 30.h,
                    width: 30.w,
                    decoration: const BoxDecoration(
                      color: AppColors.red,
                      shape: BoxShape.circle,
                    ),
                    child: const SvgIcon(
                      icon: IconStrings.close,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}
