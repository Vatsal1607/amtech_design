import 'package:amtech_design/core/utils/constant.dart';
import 'package:amtech_design/custom_widgets/svg_icon.dart';
import 'package:amtech_design/modules/subscriptions/subscription_cart/widgets/subscription_cart_details_widget.dart';
import 'package:amtech_design/modules/subscriptions/subscription_summary/subscription_summary_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/constants/keys.dart';
import '../../../core/utils/strings.dart';
import '../../../custom_widgets/appbar/custom_appbar_with_center_title.dart';
import '../../../services/local/shared_preferences_service.dart';
import '../create_subscription_plan/widgets/custom_subsbutton_with_arrow.dart';
import 'subscription_cart_provider.dart';

class SubscriptionCartPage extends StatefulWidget {
  const SubscriptionCartPage({super.key});

  @override
  State<SubscriptionCartPage> createState() => _SubscriptionCartPageState();
}

class _SubscriptionCartPageState extends State<SubscriptionCartPage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context
          .read<SubscriptionCartProvider>()
          .getSubscriptionDetails(context: context);
      // final total =
      //     context.read<SubscriptionCartProvider>().summaryRes?.data?.price ?? 0;
      // Future.delayed(const Duration(milliseconds: 500), () {
      //   context.read<SubscriptionCartProvider>().getGST(total);
      // });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final String accountType =
        sharedPrefsService.getString(SharedPrefsKeys.accountType) ?? '';
    final provider =
        Provider.of<SubscriptionCartProvider>(context, listen: false);
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

                                      //* Items & Amount
                                      Consumer<SubscriptionCartProvider>(
                                        builder: (context, _, child) =>
                                            _buildItemRow(
                                          "${provider.summaryRes?.data?.units} ${provider.summaryRes?.data?.units == '1' ? 'UNIT' : 'UNITS'}",
                                          '${provider.summaryRes?.data?.price}',
                                        ),
                                      ),

                                      //* Addons details
                                      Consumer<SubscriptionCartProvider>(
                                        builder: (context, _, child) =>
                                            ListView.builder(
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount: context
                                                  .watch<
                                                      SubscriptionSummaryProvider>()
                                                  .summaryRes
                                                  ?.data
                                                  ?.items
                                                  ?.length ??
                                              0,
                                          itemBuilder: (context, index) {
                                            final summaryRes = context
                                                .watch<
                                                    SubscriptionSummaryProvider>()
                                                .summaryRes;
                                            final item =
                                                summaryRes?.data?.items?[index];
                                            final addOns = item?.customize
                                                    ?.where((custom) =>
                                                        custom.addOns != null)
                                                    .expand((custom) =>
                                                        custom.addOns!)
                                                    .toList() ??
                                                [];
                                            // Creating a list of widgets to display
                                            List<Widget> itemWidgets = [];
                                            // Add the list of add-ons
                                            for (var addOn in addOns) {
                                              final singlePrice = addOn.price;
                                              final title =
                                                  '${addOn.quantity} x ${addOn.name} (₹$singlePrice)';
                                              final quantity = addOn.quantity;
                                              final totalPrice =
                                                  (singlePrice ?? 0) *
                                                      (quantity ?? 0);
                                              // Accumulate the grand total

                                              itemWidgets.add(
                                                _buildItemRow(title,
                                                    totalPrice.toString()),
                                              );
                                            }

                                            // Return a column with all item and add-on rows
                                            return Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: itemWidgets,
                                            );
                                          },
                                        ),
                                      ),
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
                                        //* Grand total
                                        Consumer<SubscriptionCartProvider>(
                                          builder: (context, _, child) => Text(
                                            '₹ ${provider.getGrandTotal(context).toStringAsFixed(2)}',
                                            style: GoogleFonts.publicSans(
                                              fontSize: 18.sp,
                                              color: AppColors.primaryColor,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 16.w),
                                        child: Column(
                                          children: [
                                            Consumer<SubscriptionCartProvider>(
                                              builder: (context, _, child) =>
                                                  _buildItemRow("Item Total",
                                                      '${provider.summaryRes?.data?.price}'),
                                            ),
                                            Consumer<SubscriptionCartProvider>(
                                              builder: (context, _, child) =>
                                                  _buildItemRow("GST",
                                                      '${provider.getGST(provider.summaryRes?.data?.price ?? 0)}'),
                                            ),
                                            _buildItemRow("Delivery Fee", "0"),
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
                          SubscriptionCartDetailsWidget(
                            provider: provider,
                          ),
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
                  bgColor: getColorAccountType(
                    accountType: accountType,
                    businessColor: AppColors.primaryColor,
                    personalColor: AppColors.darkGreenGrey,
                  ),
                  singleText: 'Place Order',
                  singleTextColor: getColorAccountType(
                    accountType: accountType,
                    businessColor: AppColors.seaShell,
                    personalColor: AppColors.seaMist,
                  ),
                  iconBgColor: getColorAccountType(
                    accountType: accountType,
                    businessColor: AppColors.seaShell,
                    personalColor: AppColors.seaMist,
                  ),
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
            '₹ $price',
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
