import 'package:amtech_design/core/utils/constant.dart';
import 'package:amtech_design/custom_widgets/loader/custom_loader.dart';
import 'package:amtech_design/custom_widgets/select_order_date.dart';
import 'package:amtech_design/modules/reorder/reorder_provider.dart';
import 'package:amtech_design/modules/reorder/widgets/reorder_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../core/utils/app_colors.dart';
import '../../core/utils/constants/keys.dart';
import '../../custom_widgets/appbar/custom_sliver_appbar.dart';
import '../../custom_widgets/bottom_blur_on_page.dart';
import '../../services/local/shared_preferences_service.dart';

class ReorderPage extends StatefulWidget {
  const ReorderPage({super.key});

  @override
  State<ReorderPage> createState() => _ReorderPageState();
}

class _ReorderPageState extends State<ReorderPage> {
  @override
  void initState() {
    context.read<ReorderProvider>().getReorder();
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
                      Consumer<ReorderProvider>(
                        builder: (context, _, child) => provider.isLoading
                            ? const Center(
                                child: CustomLoader(
                                  backgroundColor: AppColors.darkGreenGrey,
                                ),
                              )
                            : ListView.separated(
                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: provider.reorderList.length,
                                separatorBuilder: (context, index) =>
                                    SizedBox(height: 20.h),
                                itemBuilder: (context, index) {
                                  final reorder = provider.reorderList[index];
                                  return ReorderCardWidget(
                                    accountType: accountType,
                                    reorder: reorder,
                                  );
                                },
                              ),
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
