import 'package:amtech_design/core/utils/constant.dart';
import 'package:amtech_design/custom_widgets/select_order_date.dart';
import 'package:amtech_design/modules/reorder/reorder_provider.dart';
import 'package:amtech_design/modules/reorder/widgets/reorder_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../core/utils/app_colors.dart';
import '../../custom_widgets/appbar/custom_sliver_appbar.dart';
import '../../custom_widgets/bottom_blur_reorder_billing_page.dart';

class ReorderPage extends StatelessWidget {
  const ReorderPage({super.key});

  @override
  Widget build(BuildContext context) {
    String accountType = 'personal'; // Todo imp set dynamic
    // sharedPrefsService.getString(SharedPrefsKeys.accountType) ?? '';
    final provider = Provider.of<ReorderProvider>(context);
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
                      SelectOrderDateWidget(
                        accountType: accountType,
                      ),
                      SizedBox(height: 20.h),
                      // * Reorder card listview
                      ListView.separated(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: 5,
                        separatorBuilder: (context, index) =>
                            SizedBox(height: 20.h),
                        itemBuilder: (context, index) {
                          return ReorderCardWidget(
                            accountType: accountType,
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          BottomBlurOnPage(accountType: accountType),
        ],
      ),
    );
  }
}
