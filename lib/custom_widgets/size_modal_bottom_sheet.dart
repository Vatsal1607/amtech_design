import 'dart:developer';

import 'package:amtech_design/core/utils/constant.dart';
import 'package:amtech_design/custom_widgets/loader/custom_loader.dart';
import 'package:amtech_design/custom_widgets/snackbar.dart';
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

void showSizeModalBottomSheet({
  required BuildContext context,
  required String accountType,
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
          } else if (value == false) {
            provider.quantities = {}; //* Reset quantity
            //* Cart Snackbar
            if (provider.cartSnackbarTotalItems != 0) {
              provider.scaffoldMessengerKey.currentState?.showSnackBar(
                cartSnackbarWidget(
                  message: '${provider.cartSnackbarTotalItems} Items added',
                  items: provider.cartSnackbarItemText,
                  context: context,
                ),
              );
              // showCartSnackbar(
              //   context: context,
              //   message: '${provider.cartSnackbarTotalItems} Items added',
              //   items: provider.cartSnackbarItemText,
              // );
            }
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
                              itemCount: requiredSizes.length,
                              padding: EdgeInsets.zero,
                              separatorBuilder: (context, index) =>
                                  SizedBox(height: 10.h),
                              itemBuilder: (context, index) {
                                // final sizeDetailsList = provider
                                //         .menuSizeResponse?.data?.sizeDetails ??
                                //     [];
                                final sizeDetailsList =
                                    accountType == 'business'
                                        ? provider.menuSizeResponse?.data
                                                ?.sizeDetails ??
                                            []
                                        : provider.menuSizeResponse?.data
                                                ?.personalSizeDetails ??
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
                                final price = isDisabled
                                    ? '0'
                                    : matchingSize.price.toString();
                                final volume =
                                    isDisabled ? '0' : matchingSize.volume;
                                return ProductSizeWidget(
                                  accountType: accountType,
                                  menuId: menuId,
                                  sizeId: matchingSize.sizeId ?? '',
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
                    Consumer<MenuProvider>(
                      builder: (context, _, child) {
                        final requiredSizes = provider.requiredSizes;
                        final quantities = provider.quantities;
                        int totalQty = requiredSizes
                            .map((size) => quantities[size] ?? 0)
                            .fold(0, (sum, qty) => sum + qty);

                        return CustomButtonWithArrow(
                          totalQty: '$totalQty',
                          onTap: () {
                            Navigator.pop(context);
                            // provider.quantities = {}; //* Reset quantity
                            Navigator.pushNamed(context, Routes.cart);
                          },
                          accountType: accountType,
                        );
                      },
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
