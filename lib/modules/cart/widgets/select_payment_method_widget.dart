import 'package:amtech_design/modules/cart/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/constants/keys.dart';
import '../../../core/utils/strings.dart';
import '../../../custom_widgets/svg_icon.dart';
import '../../../services/local/shared_preferences_service.dart';

class SelectPaymentMethodWidget extends StatelessWidget {
  final String logoImage;
  final bool isPerks;
  final VoidCallback? onTap;
  final bool isSelectedMethod;
  final String payableAmount;
  final String? perksBalance;
  const SelectPaymentMethodWidget({
    super.key,
    required this.logoImage,
    this.isPerks = false,
    this.onTap,
    this.isSelectedMethod = false,
    required this.payableAmount,
    this.perksBalance,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 55, // width: ,
        margin: EdgeInsets.symmetric(horizontal: 32.w),
        padding: EdgeInsets.symmetric(horizontal: 22.w),
        decoration: BoxDecoration(
          color: AppColors.seaShell,
          borderRadius: BorderRadius.circular(40.r),
        ),
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text(
                  'Pay ',
                  style: GoogleFonts.publicSans(
                    fontSize: 16.sp,
                    color: AppColors.primaryColor,
                  ),
                ),
                Text(
                  // '₹ $payableAmount ',
                  '₹ ${double.parse(payableAmount).toInt()} ',

                  style: GoogleFonts.publicSans(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryColor,
                  ),
                ),
                Text(
                  'With',
                  style: GoogleFonts.publicSans(
                    fontSize: 16.sp,
                    color: AppColors.primaryColor,
                  ),
                ),
                SizedBox(width: 3.w),
                Image.asset(
                  logoImage,
                  height: isPerks ? 18.h : 20.h,
                  width: isPerks ? 72.w : 92.w,
                  fit: BoxFit.fill,
                ),
              ],
            ),
            if (isPerks)
              Container(
                height: 30.h,
                width: 78.w,
                padding: EdgeInsets.all(3.w),
                decoration: BoxDecoration(
                  color: AppColors.disabledColor,
                  borderRadius: BorderRadius.circular(100.r),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SvgIcon(
                      icon: IconStrings.rupee,
                      color: AppColors.primaryColor,
                    ),
                    SizedBox(
                      width: 3.w,
                    ),
                    //* Perks remaining amount
                    Text(
                      '${sharedPrefsService.getString(
                        SharedPrefsKeys.remainingPerksAmount,
                      )}',
                      style: GoogleFonts.publicSans(
                        fontSize: 11.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            Consumer<CartProvider>(
              builder: (context, provider, child) => SvgIcon(
                icon: isSelectedMethod
                    ? IconStrings.selected
                    : IconStrings.unselected,
                color: AppColors.primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
