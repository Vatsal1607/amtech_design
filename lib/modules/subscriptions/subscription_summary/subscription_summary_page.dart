import 'package:amtech_design/custom_widgets/svg_icon.dart';
import 'package:amtech_design/modules/subscriptions/create_subscription_plan/widgets/custom_button_with_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/constants/keys.dart';
import '../../../core/utils/strings.dart';
import '../../../custom_widgets/appbar/custom_appbar_with_center_title.dart';
import '../../../routes.dart';
import '../../../services/local/shared_preferences_service.dart';
import '../create_subscription_plan/widgets/custom_subsbutton_with_arrow.dart';
import 'subscription_summary_provider.dart';
import 'widgets/daywise_details_list_widget.dart';

class SubscriptionSummaryPage extends StatelessWidget {
  const SubscriptionSummaryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final String accountType =
        sharedPrefsService.getString(SharedPrefsKeys.accountType) ?? '';
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
                const Divider(
                  color: AppColors.primaryColor,
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
                            color: AppColors.primaryColor,
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
                                      const SvgIcon(icon: IconStrings.bill),
                                      SizedBox(width: 10.w),
                                      Text(
                                        'Subscription Details',
                                        style: GoogleFonts.publicSans(
                                            fontSize: 18.sp,
                                            color: AppColors.seaShell,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  CustomButtonWithIcon(
                                    labelText: 'EDIT',
                                    height: 25.h,
                                    onPressed: () {},
                                  ),
                                ],
                              ),
                              SizedBox(height: 20.h),

                              // * Units & amount Row
                              Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 10.h, horizontal: 15.w),
                                decoration: BoxDecoration(
                                  color: AppColors.seaShell,
                                  borderRadius: BorderRadius.circular(30.r),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '25 UNITS',
                                      style: GoogleFonts.publicSans(
                                          fontSize: 18.sp,
                                          color: AppColors.primaryColor,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      '₹ 2199',
                                      style: GoogleFonts.publicSans(
                                          fontSize: 18.sp,
                                          color: AppColors.primaryColor,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 10.h),

                              // * DayWiseDetailsList
                              SizedBox(
                                height: 500.h,
                                child: DayWiseDetailsListWidget(
                                  provider: provider,
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
                              color: AppColors.primaryColor.withOpacity(.7),
                            ),
                            children: [
                              TextSpan(
                                text: 'Each Week ',
                                style: GoogleFonts.publicSans(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.primaryColor,
                                ),
                              ),
                              TextSpan(
                                text: 'Until Your Unit Is Fully Utilized.',
                                style: GoogleFonts.publicSans(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.primaryColor.withOpacity(.7),
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
                onTap: () {
                  Navigator.pushNamed(context, Routes.subscriptionCart);
                },
                singleText: 'Finalize Your Order',
                singleTextColor: AppColors.seaShell,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
