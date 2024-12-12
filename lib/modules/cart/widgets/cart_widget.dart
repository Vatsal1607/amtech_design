import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/strings.dart';
import '../../../custom_widgets/item_quantity_widget.dart';

class CartWidget extends StatelessWidget {
  const CartWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
              tileColor: AppColors.primaryColor,
              leading: Container(
                height: 60.h,
                width: 60.w,
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 3.w,
                    color: AppColors.disabledColor,
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
                'Green Tea',
                style: GoogleFonts.publicSans(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.seaShell,
                ),
              ),
              subtitle: Row(
                children: [
                  Text(
                    'PRICE ',
                    style: GoogleFonts.publicSans(
                      fontSize: 10.sp,
                      color: AppColors.disabledColor,
                    ),
                  ),
                  Text(
                    '₹ 11 ',
                    style: GoogleFonts.publicSans(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.seaShell,
                    ),
                  ),
                  Text(
                    'size '.toUpperCase(),
                    style: GoogleFonts.publicSans(
                      fontSize: 10.sp,
                      color: AppColors.disabledColor,
                    ),
                  ),
                  Text(
                    'L',
                    style: GoogleFonts.publicSans(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.seaShell,
                    ),
                  ),
                ],
              ),
              trailing: Container(
                padding: EdgeInsets.all(4.w),
                decoration: BoxDecoration(
                  color: AppColors.disabledColor,
                  borderRadius: BorderRadius.circular(100.r),
                ),
                child: ItemQuantityWidget(
                  quantity: 1,
                  color: AppColors.disabledColor,
                  onIncrease: () {},
                  onDecrease: () {},
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
