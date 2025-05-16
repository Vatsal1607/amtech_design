import 'package:amtech_design/core/utils/constant.dart';
import 'package:amtech_design/modules/cart/cart_provider.dart';
import 'package:amtech_design/modules/menu/menu_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../core/utils/app_colors.dart';

class CustomSlidableButton extends StatelessWidget {
  final void Function(DragEndDetails)? onHorizontalDragEnd;
  final String accountType;
  const CustomSlidableButton({
    super.key,
    this.onHorizontalDragEnd,
    required this.accountType,
  });

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    final menuProvider = Provider.of<MenuProvider>(context, listen: false);
    return Consumer<CartProvider>(builder: (context, provider, child) {
      // * New Slidable button
      // * Note: Button is disabled while address is not selected
      return GestureDetector(
        onHorizontalDragUpdate: cartProvider.isAddressSelected(
          menuProvider.homeMenuResponse?.data?.address,
        )
            ? provider.onHorizontalDragUpdate
            : null,
        //* onHorizontalDragEnd
        onHorizontalDragEnd: onHorizontalDragEnd,
        child: Stack(
          children: [
            // Background Container
            Container(
              height: 79.h,
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 32.w),
              decoration: BoxDecoration(
                color: provider.isConfirmed
                    ? AppColors.lightGreen
                    : getColorAccountType(
                        accountType: accountType,
                        businessColor: AppColors.disabledColor,
                        personalColor: AppColors.bayLeaf,
                      ),
                borderRadius: BorderRadius.circular(100.r),
              ),
            ),

            //* Text 1: Slide to Place Order - Moves Right
            if (!provider.isConfirmed)
              Positioned(
                left: provider.dragPosition +
                    1.sw / 3.5.w, // Moves right as the user drags
                top: 79.h / 2 - 10.h, // Center vertically
                child: Opacity(
                  opacity: 1 -
                      (provider.dragPosition / provider.maxDrag), // Fades out
                  child: Text(
                    'Slide to Place Order'.toUpperCase(),
                    style: GoogleFonts.publicSans(
                      color: getColorAccountType(
                        accountType: accountType,
                        businessColor: AppColors.primaryColor,
                        personalColor: AppColors.darkGreenGrey,
                      ),
                      fontWeight: FontWeight.bold,
                      fontSize: 15.sp,
                    ),
                  ),
                ),
              ),

            //* Text 2: Release to Confirm - Moves to Center
            if (!provider.isConfirmed)
              Positioned(
                left: -provider.maxDrag +
                    provider.dragPosition +
                    1.sw / 6.w, // Moves from left to center
                top: 79.h / 2 - 10.h, // Center vertically
                child: Opacity(
                  opacity: provider.dragPosition / provider.maxDrag, // Fades in
                  child: Text(
                    'Release to Confirm'.toUpperCase(),
                    style: GoogleFonts.publicSans(
                      color: getColorAccountType(
                        accountType: accountType,
                        businessColor: AppColors.primaryColor,
                        personalColor: AppColors.darkGreenGrey,
                      ),
                      fontWeight: FontWeight.bold,
                      fontSize: 15.sp,
                    ),
                  ),
                ),
              ),

            //* Sliding Button (Arrow Icon)
            if (!provider.isConfirmed)
              Positioned(
                left: provider.dragPosition + 30.w, // Moves with user drag
                top: 79.h / 2 - 30.5.h, // Center vertically
                child: Container(
                  width: 61.w,
                  height: 61.h,
                  decoration: BoxDecoration(
                    color: getColorAccountType(
                      accountType: accountType,
                      businessColor: AppColors.primaryColor,
                      personalColor: AppColors.darkGreenGrey,
                    ),
                    borderRadius: BorderRadius.circular(30.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 5.0,
                      ),
                    ],
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.arrow_forward_ios,
                      color: AppColors.seaShell,
                    ),
                  ),
                ),
              ),
            //* "DONE!" UI (Comes from bottom after completion)
            AnimatedPositioned(
              duration: const Duration(milliseconds: 100),
              curve: Curves.easeOut,
              left: 160.w,
              top: 0,
              bottom: provider.isConfirmed ? 0 : -100, // Moves from bottom
              child: Row(
                children: [
                  Text(
                    "DONE!",
                    style: GoogleFonts.publicSans(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.sp,
                    ),
                  ),
                  SizedBox(width: 105.w),
                  if (provider.isConfirmed)
                    Container(
                      width: 61.w,
                      height: 61.h,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: getColorAccountType(
                            accountType: accountType,
                            businessColor: AppColors.seaShell,
                            personalColor: AppColors.seaMist,
                          )),
                      child: const Icon(Icons.check, color: Colors.green),
                    ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}
