import 'package:amtech_design/custom_widgets/svg_icon.dart';
import 'package:amtech_design/modules/subscriptions/subscription_cart/widgets/subscription_cart_details_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/constants/keys.dart';
import '../../../core/utils/strings.dart';
import '../../../custom_widgets/appbar/custom_appbar_with_center_title.dart';
import '../../../services/local/shared_preferences_service.dart';
import '../create_subscription_plan/widgets/custom_subsbutton_with_arrow.dart';

class SubscriptionCartPage extends StatelessWidget {
  const SubscriptionCartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final String accountType =
        sharedPrefsService.getString(SharedPrefsKeys.accountType) ?? '';
    return Scaffold(
      appBar: CustomAppbarWithCenterTitle(
        title: 'Cart',
        accountType: accountType,
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Column(
              children: [
                const Divider(
                  color: AppColors.primaryColor,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: 10.h,
                        left: 22.w,
                        right: 22.w,
                        bottom: 100.h,
                      ),
                      child: Column(
                        children: [
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(20.w),
                            decoration: BoxDecoration(
                              color: AppColors.primaryColor,
                              borderRadius: BorderRadius.circular(30.r),
                            ),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    const SvgIcon(icon: IconStrings.bill),
                                    SizedBox(width: 10.w),
                                    Text(
                                      'Total Bill',
                                      style: GoogleFonts.publicSans(
                                        color: AppColors.seaShell,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 15.w),

                                // * Items & Amount
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 16.w, vertical: 10.h),
                                  decoration: BoxDecoration(
                                    color: AppColors.seaShell,
                                    borderRadius: BorderRadius.circular(20.r),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // Header Row (Items - Amount)
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Items",
                                            style: GoogleFonts.publicSans(
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.bold,
                                              color: AppColors.disabledColor,
                                            ),
                                          ),
                                          Text(
                                            "Amount",
                                            style: GoogleFonts.publicSans(
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.bold,
                                              color: AppColors.disabledColor,
                                            ),
                                          ),
                                        ],
                                      ),

                                      // List of Items
                                      _buildItemRow("25 Units", "₹2199"),
                                      _buildItemRow("1 x Apple Juice", "₹99"),
                                      _buildItemRow(
                                          "1 x Pineapple Juice", "₹99"),
                                      _buildItemRow("1 x Paneer(10gm)", "₹19"),
                                    ],
                                  ),
                                ),

                                SizedBox(height: 15.h),

                                // * Total Card with ExpansionTile
                                Container(
                                  decoration: BoxDecoration(
                                    color: AppColors.seaShell,
                                    borderRadius: BorderRadius.circular(20.r),
                                  ),
                                  child: ExpansionTile(
                                    tilePadding:
                                        EdgeInsets.symmetric(horizontal: 16.w),
                                    shape: const RoundedRectangleBorder(
                                      side: BorderSide.none,
                                    ),
                                    collapsedShape:
                                        const RoundedRectangleBorder(
                                      side: BorderSide.none,
                                    ),
                                    title: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Total",
                                              style: GoogleFonts.publicSans(
                                                  fontSize: 18.sp,
                                                  fontWeight: FontWeight.bold,
                                                  color:
                                                      AppColors.primaryColor),
                                            ),
                                            Text(
                                              "Incl. Taxes & Charges",
                                              style: GoogleFonts.publicSans(
                                                fontSize: 12.sp,
                                                color: AppColors.disabledColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          "₹2705.92",
                                          style: GoogleFonts.publicSans(
                                            fontSize: 18.sp,
                                            color: AppColors.primaryColor,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16.0),
                                        child: Column(
                                          children: [
                                            _buildItemRow(
                                                "Item Total", "₹2416"),
                                            _buildItemRow("GST", "₹289.92"),
                                            _buildItemRow("Delivery Fee", "₹0"),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 10.h),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 20.h),

                          // * SubscriptionCartDetailsWidget
                          const SubscriptionCartDetailsWidget(),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),

          // * Bottom button
          Positioned.fill(
            left: 0,
            right: 0,
            bottom: 0,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: EdgeInsets.only(
                    left: 22.w, right: 22.w, bottom: 40.h, top: 10.h),
                decoration: const BoxDecoration(
                  color: AppColors.seaShell,
                ),
                child: CustomSubsButtonWithArrow(
                  onTap: () {},
                  singleText: 'Place Order',
                  singleTextColor: AppColors.seaShell,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Helper method to build item rows
  Widget _buildItemRow(String title, String price) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: GoogleFonts.publicSans(
              fontSize: 16.sp,
              color: AppColors.primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            price,
            style: GoogleFonts.publicSans(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
