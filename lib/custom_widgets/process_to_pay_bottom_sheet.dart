import 'package:amtech_design/core/utils/constant.dart';
import 'package:amtech_design/custom_widgets/buttons/custom_bottomsheet_close_button.dart';
import 'package:amtech_design/modules/cart/cart_provider.dart';
import 'package:amtech_design/modules/menu/menu_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../core/utils/app_colors.dart';
import '../core/utils/enums/enums.dart';
import '../core/utils/strings.dart';
import '../modules/cart/widgets/custom_slidable_button.dart';
import '../modules/cart/widgets/select_payment_method_widget.dart';
import '../modules/provider/socket_provider.dart';

double dragPosition = 0.0; // Track the drag position
const double maxDrag = 250.0; // Maximum drag length

void showProcessToPayBottomSheeet({
  required BuildContext context,
  required BuildContext scaffoldContext,
  required String accountType,
  Map<String, dynamic>? orderCreateData,
  bool isSubscriptionPay = false,
  required final String payableAmount,
}) {
  showModalBottomSheet(
    context: context,
    backgroundColor: getColorAccountType(
      accountType: accountType,
      businessColor: AppColors.primaryColor,
      personalColor: AppColors.darkGreenGrey,
    ),
    // isScrollControlled: true,
    builder: (context) {
      final cartProvider = Provider.of<CartProvider>(context, listen: false);
      final menuProvider = Provider.of<MenuProvider>(context, listen: false);
      final socketProvider =
          Provider.of<SocketProvider>(context, listen: false);

      return Stack(
        clipBehavior: Clip.none, // Allow visible outside the bounds
        children: [
          Positioned(
            child: Container(
              padding: EdgeInsets.only(top: 19.h),
              height: 323.h,
              width: 1.sw,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'select payment method'.toUpperCase(),
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
                  // * Pay with perks button
                  Consumer<CartProvider>(
                    builder: (context, provider, child) =>
                        SelectPaymentMethodWidget(
                      accountType: accountType,
                      payableAmount: payableAmount,
                      onTap: () {
                        provider.updateSelectedPaymentMethod(
                            SelectedPaymentMethod.perks.name);
                      },
                      isSelectedMethod: provider.selectedPaymentMethod ==
                          SelectedPaymentMethod.perks.name,
                      logoImage: ImageStrings.perksLogo,
                      isPerks: true,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  // * Pay with HDFC pay button
                  Consumer<CartProvider>(
                    builder: (context, provider, child) =>
                        SelectPaymentMethodWidget(
                      accountType: accountType,
                      payableAmount: payableAmount,
                      onTap: () {
                        provider.updateSelectedPaymentMethod(
                            SelectedPaymentMethod.upi.name);
                      },
                      isSelectedMethod: provider.selectedPaymentMethod ==
                          SelectedPaymentMethod.upi.name,
                      logoImage: ImageStrings.razorpayLogo,
                    ),
                  ),

                  SizedBox(height: 4.h),

                  cartProvider.isAddressSelected(
                    menuProvider.homeMenuResponse?.data?.address,
                  )
                      ? const SizedBox()
                      : Text(
                          'Please select an address first',
                          style: GoogleFonts.publicSans(
                            color: AppColors.red,
                          ),
                        ),
                  SizedBox(height: 4.h),

                  CustomSlidableButton(
                    accountType: accountType,
                    //! On Horizontal Drag End
                    onHorizontalDragEnd: cartProvider.isAddressSelected(
                            menuProvider.homeMenuResponse?.data?.address)
                        ? (details) async {
                            final address =
                                menuProvider.homeMenuResponse?.data?.address;
                            if (address == null || address.isEmpty) {
                              //* Reset position
                              cartProvider.dragPosition = 10.w;
                              cartProvider.isConfirmed = false;
                              return;
                            }
                            cartProvider.onHorizontalDragEnd(
                              details: details,
                              context: context,
                              socketProvider: socketProvider,
                              orderCreateData: orderCreateData,
                              isSubscriptionPay: isSubscriptionPay,
                              payableAmount: payableAmount,
                            );
                          }
                        : null,
                  ),
                ],
              ),
            ),
          ),
          const Positioned(
            top: -40,
            right: 0,
            left: 0,
            child: CustomBottomsheetCloseButton(),
          ),
        ],
      );
    },
  );
}
