import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/utils/app_colors.dart';
import '../core/utils/strings.dart';
import 'svg_icon.dart';

class ProductSizeWidget extends StatelessWidget {
  final String size;
  const ProductSizeWidget({
    super.key,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 32.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40.r),
        color: AppColors.disabledColor,
      ),
      child: ListTile(
        leading: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              size.toUpperCase(),
              style: GoogleFonts.publicSans(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryColor,
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '₹ 10 '.toUpperCase(),
                  style: GoogleFonts.publicSans(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryColor,
                  ),
                ),
                Text(
                  '( 65 ml )'.toUpperCase(),
                  style: GoogleFonts.publicSans(
                    fontSize: 12.sp,
                    color: AppColors.primaryColor,
                  ),
                ),
              ],
            ),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: () {
                //
              },
              child: Container(
                height: 30.h,
                width: 30.w,
                decoration: const BoxDecoration(
                  color: AppColors.primaryColor,
                  shape: BoxShape.circle,
                ),
                child: SvgIcon(
                  icon: IconStrings.minus,
                ),
              ),
            ),
            SizedBox(width: 10.w),
            Text(
              '1',
              style: GoogleFonts.publicSans(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryColor,
              ),
            ),
            SizedBox(width: 10.w),
            GestureDetector(
              onTap: () {
                //
              },
              child: Container(
                height: 30.h,
                width: 30.w,
                decoration: const BoxDecoration(
                  color: AppColors.primaryColor,
                  shape: BoxShape.circle,
                ),
                child: SvgIcon(
                  icon: IconStrings.plus,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
