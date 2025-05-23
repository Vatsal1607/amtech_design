import 'package:amtech_design/core/utils/constant.dart';
import 'package:amtech_design/custom_widgets/loader/custom_loader.dart';
import 'package:amtech_design/custom_widgets/select_order_date.dart';
import 'package:amtech_design/modules/reorder/reorder_provider.dart';
import 'package:amtech_design/modules/reorder/widgets/reorder_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../core/utils/app_colors.dart';
import '../../core/utils/constants/keys.dart';
import '../../custom_widgets/appbar/custom_sliver_appbar.dart';
import '../../custom_widgets/bottom_blur_on_page.dart';
import '../../services/local/shared_preferences_service.dart';

class ReorderPage extends StatefulWidget {
  final ScrollController scrollController;
  const ReorderPage({super.key, required this.scrollController});

  @override
  State<ReorderPage> createState() => _ReorderPageState();
}

class _ReorderPageState extends State<ReorderPage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ReorderProvider>().getReorder(); //* API call
      context.read<ReorderProvider>().formattedStartDate = '';
      context.read<ReorderProvider>().formattedEndDate = '';
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String accountType =
        sharedPrefsService.getString(SharedPrefsKeys.accountType) ?? '';
    final provider = Provider.of<ReorderProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: getColorAccountType(
          accountType: accountType,
          businessColor: AppColors.seaShell,
          personalColor: AppColors.seaMist),
      body: Stack(
        children: [
          CustomScrollView(
            physics: const NeverScrollableScrollPhysics(),
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
                      //* Select Reorder Date Range ROW
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Consumer<ReorderProvider>(
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
                            child: Consumer<ReorderProvider>(
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
                            onTap: () {
                              provider.resetSelectedDates();
                            },
                            child: Container(
                              padding: EdgeInsets.all(1.w),
                              child: const Icon(Icons.refresh),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 24.h),
                      // * Reorder card listview
                      Consumer<ReorderProvider>(
                        builder: (context, _, child) {
                          if (provider.isLoading) {
                            return Center(
                              child: CustomLoader(
                                backgroundColor: getColorAccountType(
                                  accountType: accountType,
                                  businessColor: AppColors.primaryColor,
                                  personalColor: AppColors.darkGreenGrey,
                                ),
                              ),
                            );
                          }
                          if (provider.reorderList.isEmpty) {
                            return Text(
                              'No Orders available.',
                              style: GoogleFonts.publicSans(
                                color: getColorAccountType(
                                  accountType: accountType,
                                  businessColor: AppColors.primaryColor,
                                  personalColor: AppColors.darkGreenGrey,
                                ),
                                fontSize: 20.sp,
                              ),
                            );
                          }
                          return NotificationListener<ScrollNotification>(
                            onNotification: (scrollInfo) {
                              if (scrollInfo.metrics.pixels >=
                                  scrollInfo.metrics.maxScrollExtent * 0.9) {
                                WidgetsBinding.instance
                                    .addPostFrameCallback((_) {
                                  provider.getReorder(); //* API call
                                });
                              }
                              return false;
                            },
                            child: ListView.separated(
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              itemCount: provider.reorderList.length,
                              separatorBuilder: (context, index) =>
                                  SizedBox(height: 15.h),
                              itemBuilder: (context, index) {
                                final reorder = provider.reorderList[index];
                                //* Widget
                                return ReorderCardWidget(
                                  accountType: accountType,
                                  reorder: reorder,
                                  index: index,
                                );
                              },
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          BottomBlurOnPage(
            height: 20.h,
            accountType: accountType,
          ),
        ],
      ),
    );
  }
}
