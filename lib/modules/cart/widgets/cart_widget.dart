import 'package:amtech_design/core/utils/constant.dart';
import 'package:amtech_design/models/list_cart_model.dart';
import 'package:amtech_design/modules/cart/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/constants/keys.dart';
import '../../../core/utils/strings.dart';
import '../../../custom_widgets/item_quantity_widget.dart';
import '../../../services/local/shared_preferences_service.dart';
import '../../menu/menu_provider.dart';

class CartWidget extends StatelessWidget {
  final String accountType;
  final CartItems? cartItems;
  const CartWidget({
    super.key,
    required this.accountType,
    this.cartItems,
  });

  @override
  Widget build(BuildContext context) {
    String accountType =
        sharedPrefsService.getString(SharedPrefsKeys.accountType) ?? '';
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    return Container(
      height: 95.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.r),
      ),
      child: Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30.r),
          child: Material(
            color: Colors.transparent,
            child: ListTile(
              contentPadding:
                  EdgeInsets.symmetric(vertical: 8.h, horizontal: 20.w),
              tileColor: getColorAccountType(
                accountType: accountType,
                businessColor: AppColors.primaryColor,
                personalColor: AppColors.darkGreenGrey,
              ),
              leading: Container(
                height: 60.h,
                width: 60.w,
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 3.w,
                    color: getColorAccountType(
                      accountType: accountType,
                      businessColor: AppColors.disabledColor,
                      personalColor: AppColors.bayLeaf,
                    ),
                  ),
                  borderRadius: BorderRadius.circular(20.r),
                  image: const DecorationImage(
                    image: AssetImage(
                      ImageStrings.masalaTea2,
                    ),
                  ),
                ),
              ),
              title: Text(
                cartItems?.itemName ?? '',
                overflow: TextOverflow.ellipsis,
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
              subtitle: Row(
                children: [
                  Text(
                    'PRICE ',
                    style: GoogleFonts.publicSans(
                      fontSize: 10.sp,
                      color: getColorAccountType(
                        accountType: accountType,
                        businessColor: AppColors.disabledColor,
                        personalColor: AppColors.bayLeaf,
                      ),
                    ),
                  ),
                  Text(
                    '₹ ${cartItems?.price ?? ''} ',
                    style: GoogleFonts.publicSans(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                      color: getColorAccountType(
                        accountType: accountType,
                        businessColor: AppColors.seaShell,
                        personalColor: AppColors.seaMist,
                      ),
                    ),
                  ),
                  Text(
                    'size '.toUpperCase(),
                    style: GoogleFonts.publicSans(
                      fontSize: 10.sp,
                      color: getColorAccountType(
                        accountType: accountType,
                        businessColor: AppColors.disabledColor,
                        personalColor: AppColors.bayLeaf,
                      ),
                    ),
                  ),
                  Text(
                    '${cartItems?.size?[0].name?.substring(0, 1)}',
                    style: GoogleFonts.publicSans(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                      color: getColorAccountType(
                        accountType: accountType,
                        businessColor: AppColors.seaShell,
                        personalColor: AppColors.seaMist,
                      ),
                    ),
                  ),
                ],
              ),
              trailing: Container(
                padding: EdgeInsets.all(4.w),
                decoration: BoxDecoration(
                  color: getColorAccountType(
                    accountType: accountType,
                    businessColor: AppColors.disabledColor,
                    personalColor: AppColors.bayLeaf,
                  ),
                  borderRadius: BorderRadius.circular(100.r),
                ),
                child: Consumer<MenuProvider>(
                  builder: (context, menuProvider, child) => ItemQuantityWidget(
                    accountType: accountType,
                    quantity: cartItems?.quantity ?? 0,
                    color: getColorAccountType(
                      accountType: accountType,
                      businessColor: AppColors.disabledColor,
                      personalColor: AppColors.bayLeaf,
                    ),
                    onDecrease: () {
                      //* API call
                      menuProvider.updateCart(
                        size: cartItems?.size?[0].name ?? '',
                        menuId: cartItems?.menuId?.sId ?? '',
                        sizeId: cartItems?.size?[0].sizeId ?? '',
                        callback: (isSuccess) {
                          if (isSuccess) {
                            debugPrint('Item added to cart successfully');
                            cartProvider.getListCart();
                            debugPrint('QTY: decr: ${cartItems?.quantity}');
                            //* QTY- locally
                            // cartItems?.quantity =
                            //     (cartItems?.quantity ?? 0) - 1;
                            debugPrint('QTY: decr (2): ${cartItems?.quantity}');
                            // menuProvider.decrementQuantity(
                            //   sizeName: cartItems?.size?[0].name ?? '',
                            //   menuId: cartItems?.menuId?.sId ?? '',
                            //   sizeId: cartItems?.size?[0].sizeId ?? '',
                            // );
                          } else {
                            debugPrint('Error: Failed to update item to cart');
                          }
                        },
                      );
                    },
                    onIncrease: () {
                      //* API call
                      menuProvider.addToCart(
                        size: cartItems?.size?[0].name ?? '',
                        menuId: cartItems?.menuId?.sId ?? '',
                        sizeId: cartItems?.size?[0].sizeId ?? '',
                        callback: (isSuccess) {
                          if (isSuccess) {
                            debugPrint('Item added to cart successfully');
                            cartProvider.getListCart();
                            debugPrint('QTY: Incr: ${cartItems?.quantity}');
                            //* QTY+ locally
                            // cartItems?.quantity =
                            //     (cartItems?.quantity ?? 0) + 1;
                            // menuProvider.incrementQuantity(
                            //   sizeName: cartItems?.size?[0].name ?? '',
                            //   menuId: cartItems?.menuId?.sId ?? '',
                            //   sizeId: cartItems?.size?[0].sizeId ?? '',
                            // );
                          } else {
                            debugPrint('Error: Failed to add item to cart');
                          }
                        },
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
