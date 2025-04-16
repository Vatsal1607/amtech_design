import 'package:amtech_design/custom_widgets/appbar/custom_sliver_appbar.dart';
import 'package:amtech_design/modules/subscriptions/subscription/widgets/subscription_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/constant.dart';
import '../../../core/utils/constants/keys.dart';
import '../../../custom_widgets/loader/custom_loader.dart';
import '../../../services/local/shared_preferences_service.dart';
import '../../recharge/widgets/center_title_with_divider.dart';
import 'subscription_provider.dart';

class SubscriptionPage extends StatefulWidget {
  const SubscriptionPage({super.key});

  @override
  State<SubscriptionPage> createState() => _SubscriptionPageState();
}

class _SubscriptionPageState extends State<SubscriptionPage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<SubscriptionProvider>().getSubsList(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String accountType =
        sharedPrefsService.getString(SharedPrefsKeys.accountType) ?? '';

    return Scaffold(
      backgroundColor: getColorAccountType(
          accountType: accountType,
          businessColor: AppColors.seaShell,
          personalColor: AppColors.seaMist),
      body: CustomScrollView(
        slivers: [
          CustomSliverAppbar(accountType: accountType),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 32.w),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: 10.h),
                    CenterTitleWithDivider(
                      accountType: accountType,
                      title: 'Active',
                    ),
                    SizedBox(height: 10.h),
                    Consumer<SubscriptionProvider>(
                      builder: (context, provider, child) => provider.isLoading
                          ? CustomLoader(
                              color: getColorAccountType(
                                accountType: accountType,
                                businessColor: AppColors.primaryColor,
                                personalColor: AppColors.darkGreenGrey,
                              ),
                            )
                          : ListView.separated(
                              itemCount: provider.activeList.length,
                              shrinkWrap: true,
                              padding: EdgeInsets.zero,
                              physics: const NeverScrollableScrollPhysics(),
                              separatorBuilder: (context, index) =>
                                  SizedBox(height: 10.h),
                              itemBuilder: (context, index) {
                                //* SubscriptionCardWidget
                                return SubscriptionCardWidget(
                                  item: provider.activeList[index],
                                );
                              },
                            ),
                    ),
                    SizedBox(height: 10.h),
                    CenterTitleWithDivider(
                      accountType: accountType,
                      title: 'Expired',
                    ),
                    SizedBox(height: 10.h),
                    Consumer<SubscriptionProvider>(
                      builder: (context, provider, child) => provider.isLoading
                          ? CustomLoader(
                              color: getColorAccountType(
                                accountType: accountType,
                                businessColor: AppColors.primaryColor,
                                personalColor: AppColors.darkGreenGrey,
                              ),
                            )
                          : ListView.separated(
                              itemCount: provider.expiredList.length,
                              shrinkWrap: true,
                              padding: EdgeInsets.zero,
                              physics: const NeverScrollableScrollPhysics(),
                              separatorBuilder: (context, index) =>
                                  SizedBox(height: 10.h),
                              itemBuilder: (context, index) {
                                //* SubscriptionCardWidget
                                return SubscriptionCardWidget(
                                  isExpired: true,
                                  item: provider.expiredList[index],
                                );
                              },
                            ),
                    ),
                    SizedBox(height: 20.h),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
