import 'dart:developer';
import 'package:amtech_design/custom_widgets/svg_icon.dart';
import 'package:amtech_design/modules/subscriptions/create_subscription_plan/create_subscription_plan_provider.dart';
import 'package:amtech_design/modules/subscriptions/create_subscription_plan/widgets/custom_button_with_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/constant.dart';
import '../../../core/utils/constants/keys.dart';
import '../../../core/utils/strings.dart';
import '../../../custom_widgets/appbar/custom_appbar_with_center_title.dart';
import '../../../routes.dart';
import '../../../services/local/shared_preferences_service.dart';
import '../create_subscription_plan/widgets/custom_subsbutton_with_arrow.dart';
import 'subscription_summary_provider.dart';
import 'widgets/daywise_details_list_widget.dart';

class SubscriptionSummaryPage extends StatefulWidget {
  const SubscriptionSummaryPage({super.key});

  @override
  State<SubscriptionSummaryPage> createState() =>
      _SubscriptionSummaryPageState();
}

class _SubscriptionSummaryPageState extends State<SubscriptionSummaryPage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider =
          Provider.of<SubscriptionSummaryProvider>(context, listen: false);
      provider.getSubscriptionSummary(context: context); // API call
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final String accountType = 'personal';
    // sharedPrefsService.getString(SharedPrefsKeys.accountType) ?? '';
    final provider =
        Provider.of<SubscriptionSummaryProvider>(context, listen: false);
    return Scaffold(
      appBar: CustomAppbarWithCenterTitle(
        title: 'Subscription Summary',
        accountType: accountType,
        leftPadTitle: 30.w,
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Column(
              children: [
                Divider(
                  color: getColorAccountType(
                    accountType: accountType,
                    businessColor: AppColors.primaryColor,
                    personalColor: AppColors.darkGreenGrey,
                  ),
                ),
                SizedBox(height: 10.h),
                SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.w,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // * Container with BG color
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(20.w),
                          decoration: BoxDecoration(
                            color: getColorAccountType(
                              accountType: accountType,
                              businessColor: AppColors.primaryColor,
                              personalColor: AppColors.darkGreenGrey,
                            ),
                            borderRadius: BorderRadius.circular(30.r),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  // * Subs details Row
                                  Row(
                                    children: [
                                      const SvgIcon(
                                          icon: IconStrings.subsDetails2),
                                      SizedBox(width: 10.w),
                                      Text(
                                        'Subscription Details',
                                        style: GoogleFonts.publicSans(
                                          fontSize: 18.sp,
                                          color: getColorAccountType(
                                            accountType: accountType,
                                            businessColor: AppColors.seaShell,
                                            personalColor: AppColors.seaMist,
                                          ),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  CustomButtonWithIcon(
                                    height: 25.h,
                                    labelText: 'EDIT',
                                    icon: IconStrings.editPen,
                                    onPressed: () {
                                      log('Edit called');
                                      context
                                          .read<
                                              CreateSubscriptionPlanProvider>()
                                          .setUpdateSubscription(
                                              true); // isUpadte: True
                                      Navigator.pop(context);
                                    },
                                  ),
                                ],
                              ),
                              SizedBox(height: 20.h),

                              // * Units & Price Row
                              Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 10.h, horizontal: 15.w),
                                decoration: BoxDecoration(
                                  color: getColorAccountType(
                                    accountType: accountType,
                                    businessColor: AppColors.seaShell,
                                    personalColor: AppColors.seaMist,
                                  ),
                                  borderRadius: BorderRadius.circular(30.r),
                                ),
                                child: Consumer<SubscriptionSummaryProvider>(
                                  builder: (context, _, child) => Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        '${provider.summaryRes?.data?.units ?? ''} ${provider.summaryRes?.data?.units == '1' ? 'UNIT' : 'UNITS'}',
                                        style: GoogleFonts.publicSans(
                                            fontSize: 18.sp,
                                            color: getColorAccountType(
                                              accountType: accountType,
                                              businessColor:
                                                  AppColors.primaryColor,
                                              personalColor:
                                                  AppColors.darkGreenGrey,
                                            ),
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        '₹ ${provider.summaryRes?.data?.price ?? ''}',
                                        style: GoogleFonts.publicSans(
                                            fontSize: 18.sp,
                                            color: getColorAccountType(
                                              accountType: accountType,
                                              businessColor:
                                                  AppColors.primaryColor,
                                              personalColor:
                                                  AppColors.darkGreenGrey,
                                            ),
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: 10.h),

                              // * DayWiseDetailsList
                              SizedBox(
                                height: 500.h,
                                child: DayWiseDetailsListWidget(
                                  provider: provider,
                                  accountType: accountType,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10.h),

                        // * Note Text
                        Text.rich(
                          TextSpan(
                            text:
                                'Note: Your Selected Time Slot And Meal Will Be Repeated ',
                            style: GoogleFonts.publicSans(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: getColorAccountType(
                                accountType: accountType,
                                businessColor:
                                    AppColors.primaryColor.withOpacity(.7),
                                personalColor:
                                    AppColors.darkGreenGrey.withOpacity(.7),
                              ),
                            ),
                            children: [
                              TextSpan(
                                text: 'Each Week ',
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
                              TextSpan(
                                text: 'Until Your Unit Is Fully Utilized.',
                                style: GoogleFonts.publicSans(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                  color: getColorAccountType(
                                    accountType: accountType,
                                    businessColor:
                                        AppColors.primaryColor.withOpacity(.7),
                                    personalColor:
                                        AppColors.darkGreenGrey.withOpacity(.7),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          textAlign: TextAlign.justify,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          // * Bottom button
          Positioned.fill(
            left: 22.w,
            right: 22.w,
            bottom: 40.h,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: CustomSubsButtonWithArrow(
                bgColor: getColorAccountType(
                  accountType: accountType,
                  businessColor: AppColors.primaryColor,
                  personalColor: AppColors.darkGreenGrey,
                ),
                onTap: () {
                  Navigator.pushNamed(context, Routes.subscriptionCart);
                },
                singleText: 'Finalize Your Order',
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
        ],
      ),
    );
  }
}
