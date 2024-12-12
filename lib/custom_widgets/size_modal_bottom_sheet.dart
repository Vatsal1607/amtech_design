import 'package:amtech_design/custom_widgets/svg_icon.dart';
import 'package:amtech_design/modules/cart/cart_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/utils/app_colors.dart';
import '../core/utils/strings.dart';
import 'product_size_widget.dart';

void showSizeModalBottomSheet({
  required BuildContext context,
}) {
  showModalBottomSheet(
    context: context,
    // isDismissible: false,
    backgroundColor: AppColors.primaryColor,
    // isScrollControlled: true,
    builder: (context) {
      return Stack(
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
                      color: AppColors.seaShell,
                    ),
                  ),
                  SizedBox(height: 17.h),
                  const ProductSizeWidget(
                    size: 'regular',
                  ),
                  SizedBox(height: 9.h),
                  const ProductSizeWidget(
                    size: 'medium',
                  ),
                  SizedBox(height: 9.h),
                  const ProductSizeWidget(
                    size: 'large',
                  ),
                  SizedBox(height: 9.h),

                  // * Added to cart button
                  Container(
                    height: 55.h,
                    margin: EdgeInsets.symmetric(horizontal: 32.w),
                    padding: EdgeInsets.symmetric(horizontal: 22.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40.r),
                      color: AppColors.white,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              '1 item '.toUpperCase(),
                              style: GoogleFonts.publicSans(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                                color: AppColors.primaryColor,
                              ),
                            ),
                            Text(
                              'added to cart'.toUpperCase(),
                              style: GoogleFonts.publicSans(
                                fontSize: 16.sp,
                                color: AppColors.primaryColor,
                              ),
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: () {
                            // Todo imp: Replace with named routes
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const CartPage(),
                                ));
                          },
                          child: Container(
                            height: 30.h,
                            width: 45.w,
                            decoration: BoxDecoration(
                              color: AppColors.primaryColor,
                              borderRadius: BorderRadius.circular(100.r),
                            ),
                            child: SvgIcon(
                              icon: IconStrings.arrowNext,
                            ),
                          ),
                        ),
                      ],
                    ),
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
                  child: SvgIcon(
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
