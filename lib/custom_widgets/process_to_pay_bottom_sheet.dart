import 'package:amtech_design/core/utils/constant.dart';
import 'package:amtech_design/core/utils/constants/keys.dart';
import 'package:amtech_design/custom_widgets/svg_icon.dart';
import 'package:amtech_design/modules/cart/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../core/utils/app_colors.dart';
import '../core/utils/strings.dart';
import '../modules/cart/widgets/custom_slidable_button.dart';
import '../modules/cart/widgets/select_payment_method_widget.dart';
import '../modules/provider/socket_provider.dart';

double dragPosition = 0.0; // Track the drag position
const double maxDrag = 250.0; // Maximum drag length
bool isConfirmed = false; // Track if the action is confirmed

void showProcessToPayBottomSheeet({
  required BuildContext context,
  required String accountType,
  required Map<String, dynamic> orderCreateData,
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
                      onTap: () {
                        provider.updateSelectedPaymentMethod('Perks');
                      },
                      isSelectedMethod:
                          provider.selectedPaymentMethod == 'Perks',
                      logoImage: ImageStrings.perksLogo,
                      isPerks: true,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  // * Pay with razor pay button
                  Consumer<CartProvider>(
                    builder: (context, provider, child) =>
                        SelectPaymentMethodWidget(
                      onTap: () {
                        provider.updateSelectedPaymentMethod('UPI');
                      },
                      isSelectedMethod: provider.selectedPaymentMethod == 'UPI',
                      logoImage: ImageStrings.razorpayLogo,
                    ),
                  ),

                  SizedBox(height: 10.h),

                  CustomSlidableButton(
                    onHorizontalDragEnd: (details) {
                      cartProvider.onHorizontalDragEnd(details, context);
                      //* Emit socket event
                      socketProvider.emitEvent(
                        SocketEvents.orderCreate,
                        orderCreateData,
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
      );
    },
  );
}
