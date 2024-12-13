import 'package:amtech_design/core/utils/strings.dart';
import 'package:amtech_design/custom_widgets/appbar/custom_appbar_with_center_title.dart';
import 'package:amtech_design/custom_widgets/custom_button.dart';
import 'package:amtech_design/custom_widgets/process_to_pay_bottom_sheet.dart';
import 'package:amtech_design/modules/cart/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../core/utils/app_colors.dart';
import '../../custom_widgets/size_modal_bottom_sheet.dart';
import '../../custom_widgets/svg_icon.dart';
import 'widgets/cart_widget.dart';
import 'widgets/you_may_like_widget.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    String accountType = 'business'; // Todo imp set dynamic
    // sharedPrefsService.getString(SharedPrefsKeys.accountType) ?? '';
    final provider = Provider.of<CartProvider>(context, listen: false);
    return Scaffold(
      // extendBodyBehindAppBar: true, // show content of body behind appbar
      appBar: const CustomAppbarWithCenterTitle(
        title: 'Cart',
        // backgroundColor: Colors.transparent,
      ),
      body: Stack(
        children: [
          Image.asset(
            ImageStrings.cartDoodle,
            height: 1.sh,
            width: 1.sw,
          ),
          Positioned.fill(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListView.separated(
                  shrinkWrap: true,
                  itemCount: 3,
                  padding: EdgeInsets.only(left: 31.w, right: 31.w, top: 27.h),
                  separatorBuilder: (context, index) => SizedBox(height: 18.h),
                  itemBuilder: (context, index) {
                    return const CartWidget();
                  },
                ),
                SizedBox(height: 18.h),
                Container(
                  height: 170.h,
                  width: 1.sw,
                  margin: EdgeInsets.symmetric(
                    horizontal: 31.w,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.disabledColor,
                    borderRadius: BorderRadius.circular(30.r),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          top: 19.h,
                          left: 22.w,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SvgIcon(
                              icon: IconStrings.youMayLike,
                              color: AppColors.primaryColor,
                            ),
                            SizedBox(width: 6.w),
                            Text(
                              'You May Like',
                              style: GoogleFonts.publicSans(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.bold,
                                color: AppColors.primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 15.h),
                      SizedBox(
                        height: 100.h,
                        child: ListView.separated(
                          itemCount: 4,
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          padding: EdgeInsets.symmetric(horizontal: 21.w),
                          separatorBuilder: (context, index) {
                            return SizedBox(width: 21.w);
                          },
                          itemBuilder: (context, index) {
                            return YouMayLikeWidget();
                          },
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 18.h),
                // * Expansion tile
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 31.w),
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(30.r),
                  ),
                  child: ExpansionTile(
                    onExpansionChanged: provider.onExpansionChanged,
                    leading: SvgIcon(icon: IconStrings.totalBill),
                    trailing: Icon(
                      provider.isExpanded
                          ? Icons.expand_less
                          : Icons.expand_more,
                      color: AppColors.seaShell,
                    ),
                    title: Row(
                      children: [
                        Text(
                          'Total Bill ',
                          style: GoogleFonts.publicSans(
                            fontSize: 12.sp,
                            color: AppColors.seaShell,
                          ),
                        ),
                        Text(
                          '₹11 ',
                          style: GoogleFonts.publicSans(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.bold,
                            color: AppColors.seaShell,
                          ),
                        ),
                        Text(
                          'Incl. taxes & charges',
                          style: GoogleFonts.publicSans(
                            fontSize: 10.sp,
                            color: AppColors.seaShell,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned.fill(
            bottom: 50.h,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.w),
                child: CustomButton(
                  onTap: () {
                    showProcessToPayBottomSheeet(
                      context: context,
                      accountType: accountType,
                    );
                  },
                  height: 55.h,
                  width: double.infinity,
                  bgColor: AppColors.primaryColor,
                  text: 'proceed to pay ₹ 11',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
