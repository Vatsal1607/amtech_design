import 'package:amtech_design/custom_widgets/loader/custom_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../core/utils/app_colors.dart';
import '../../core/utils/constant.dart';
import '../../core/utils/constants/keys.dart';
import '../../custom_widgets/appbar/custom_sliver_appbar.dart';
import '../../custom_widgets/bottom_blur_on_page.dart';
import '../../custom_widgets/select_order_date.dart';
import '../../services/local/shared_preferences_service.dart';
import 'billing_provider.dart';
import 'widgets/billing_card_widgets.dart';

class BillingPage extends StatefulWidget {
  final ScrollController scrollController;
  const BillingPage({super.key, required this.scrollController});

  @override
  State<BillingPage> createState() => _BillingPageState();
}

class _BillingPageState extends State<BillingPage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<BillingProvider>().getBilling(); //* API call
      context.read<BillingProvider>().formattedStartDate = '';
      context.read<BillingProvider>().formattedEndDate = '';
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String accountType =
        sharedPrefsService.getString(SharedPrefsKeys.accountType) ?? '';
    final provider = Provider.of<BillingProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: getColorAccountType(
          accountType: accountType,
          businessColor: AppColors.seaShell,
          personalColor: AppColors.seaMist),
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              CustomSliverAppbar(
                accountType: accountType,
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 20.h, horizontal: 32.w),
                  child: Column(
                    children: [
                      //* Select Billing Date ROW
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Consumer<BillingProvider>(
                              builder: (context, _, child) =>
                                  SelectOrderDateWidget(
                                onTap: () {
                                  provider.pickStartDate(context);
                                },
                                accountType: accountType,
                                selectedDate:
                                    provider.selectedStartDate == null ||
                                            provider.formattedStartDate == ''
                                        ? 'Start Date'
                                        : provider.formattedStartDate,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.w),
                            child: Text(
                              'TO',
                              style: GoogleFonts.publicSans(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.bold,
                                color: getColorAccountType(
                                  accountType: accountType,
                                  businessColor: AppColors.primaryColor,
                                  personalColor: AppColors.darkGreenGrey,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Consumer<BillingProvider>(
                              builder: (context, _, child) =>
                                  SelectOrderDateWidget(
                                onTap: () {
                                  provider.pickEndDate(context);
                                },
                                accountType: accountType,
                                selectedDate:
                                    provider.selectedEndDate == null ||
                                            provider.formattedStartDate == ''
                                        ? 'End Date'
                                        : provider.formattedEndDate,
                              ),
                            ),
                          ),
                          SizedBox(width: 10.w),
                          GestureDetector(
                            onTap: provider.resetSelectedDates,
                            child: Container(
                              padding: EdgeInsets.all(1.w),
                              child: const Icon(Icons.refresh),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 20.h),
                      // * Billing card widget
                      Consumer<BillingProvider>(
                        builder: (context, _, child) => provider.isLoading
                            ? const CustomLoader()
                            : NotificationListener(
                                onNotification:
                                    (ScrollNotification scrollInfo) {
                                  if (scrollInfo.metrics.pixels >=
                                      scrollInfo.metrics.maxScrollExtent *
                                          0.9) {
                                    // When the user scrolls to 90% of the list, load more
                                    WidgetsBinding.instance
                                        .addPostFrameCallback((_) {
                                      provider.getBilling(); //* API call
                                    });
                                  }
                                  return false;
                                },
                                child: ListView.separated(
                                  padding: EdgeInsets.zero,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  // itemCount: provider.billingList.length,
                                  itemCount: 5,
                                  separatorBuilder: (context, index) =>
                                      SizedBox(height: 20.h),
                                  itemBuilder: (context, index) {
                                    return BillingCardWidget(
                                      accountType: accountType,
                                      // billingList: provider.billingList,
                                    );
                                  },
                                ),
                              ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ), // Bottom edge gradient
          BottomBlurOnPage(
            height: 20.h,
            accountType: accountType,
          ),
        ],
      ),
    );
  }
}
