import 'package:amtech_design/core/utils/constant.dart';
import 'package:amtech_design/custom_widgets/item_quantity_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../core/utils/app_colors.dart';
import '../modules/menu/menu_provider.dart';

class ProductSizeWidget extends StatelessWidget {
  final String size;
  final String accountType;
  final String price;
  final String volume;
  final bool isDisabled;
  final int quantity;
  final String menuId;
  final String sizeId;
  const ProductSizeWidget({
    super.key,
    required this.size,
    required this.accountType,
    required this.price,
    required this.volume,
    this.isDisabled = false,
    required this.quantity,
    required this.menuId,
    required this.sizeId,
  });

  @override
  Widget build(BuildContext context) {
    final menuProvider = Provider.of<MenuProvider>(context, listen: false);
    debugPrint('Size is: $size');
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 32.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40.r),
        color: getColorAccountType(
          accountType: accountType,
          businessColor: isDisabled
              ? AppColors.disabledColor.withOpacity(.5)
              : AppColors.disabledColor,
          personalColor: isDisabled
              ? AppColors.bayLeaf.withOpacity(.5)
              : AppColors.bayLeaf,
        ),
      ),
      child: ListTile(
        leading: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              size,
              // .toUpperCase(),
              style: GoogleFonts.publicSans(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: getColorAccountType(
                  accountType: accountType,
                  businessColor: AppColors.primaryColor,
                  personalColor: AppColors.darkGreenGrey,
                ),
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '₹ $price '.toUpperCase(),
                  style: GoogleFonts.publicSans(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                      color: getColorAccountType(
                        accountType: accountType,
                        businessColor: AppColors.primaryColor,
                        personalColor: AppColors.darkGreenGrey,
                      )),
                ),
                Text(
                  '( $volume )'.toUpperCase(),
                  style: GoogleFonts.publicSans(
                    fontSize: 12.sp,
                    color: getColorAccountType(
                      accountType: accountType,
                      businessColor: AppColors.primaryColor,
                      personalColor: AppColors.darkGreenGrey,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        trailing: ItemQuantityWidget(
          accountType: accountType,
          quantity: isDisabled ? 0 : quantity,
          isLoading: menuProvider.getIsLoadingStates(size),
          // isLoading: menuProvider.isLoadingAddToCart ||
          //     menuProvider.isLoadingUpdateCart,
          onDecrease: isDisabled
              ? null
              : () {
                  menuProvider.updateCart(
                    size: size,
                    menuId: menuId,
                    sizeId: sizeId,
                    callback: (isSuccess) {
                      if (isSuccess) {
                        debugPrint('Item added to cart successfully');
                        menuProvider.decrementQuantity(
                          sizeName: size,
                          menuId: menuId,
                          sizeId: sizeId,
                        );
                      } else {
                        debugPrint('Error: Failed to update item to cart');
                      }
                    },
                  );
                },
          onIncrease: isDisabled
              ? null
              : () {
                  menuProvider.addToCart(
                    size: size,
                    menuId: menuId,
                    sizeId: sizeId,
                    callback: (isSuccess) {
                      if (isSuccess) {
                        debugPrint('Item added to cart successfully');
                        menuProvider.incrementQuantity(
                          sizeName: size,
                          menuId: menuId,
                          sizeId: sizeId,
                        );
                      } else {
                        debugPrint('Error: Failed to add item to cart');
                      }
                    },
                  ); // API call
                },
        ),
      ),
    );
  }
}
