import 'package:amtech_design/core/utils/constant.dart';
import 'package:amtech_design/custom_widgets/item_quantity_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/utils/app_colors.dart';

class ProductSizeWidget extends StatelessWidget {
  final String size;
  final String accountType;
  const ProductSizeWidget({
    super.key,
    required this.size,
    required this.accountType,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 32.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40.r),
        color: getColorAccountType(
                  accountType: accountType,
                  businessColor: AppColors.disabledColor,
                  personalColor: AppColors.bayLeaf,
                ),
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
                  '₹ 10 '.toUpperCase(),
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
                  '( 65 ml )'.toUpperCase(),
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
          quantity: 1,
          onIncrease: () {},
          onDecrease: () {},
        ),
      ),
    );
  }
}
