import 'dart:developer';

import 'package:amtech_design/core/utils/constant.dart';
import 'package:amtech_design/core/utils/constants/keys.dart';
import 'package:amtech_design/custom_widgets/appbar/custom_appbar_with_center_title.dart';
import 'package:amtech_design/modules/recharge/widgets/center_title_with_divider.dart';
import 'package:amtech_design/modules/subscriptions/subscription/subscription_details/widgets/calender_widget.dart';
import 'package:amtech_design/modules/subscriptions/subscription/subscription_details/widgets/delivery_status_widget.dart';
import 'package:amtech_design/modules/subscriptions/subscription/subscription_details/widgets/item_details.dart';
import 'package:amtech_design/modules/subscriptions/subscription/subscription_details/widgets/timslot_dropdown_widget.dart';
import 'package:amtech_design/services/local/shared_preferences_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/utils.dart';
import '../../subscription_cart/subscription_cart_provider.dart';
import 'subscription_details_provider.dart';

class SubscriptonDetailsPage extends StatefulWidget {
  const SubscriptonDetailsPage({super.key});

  @override
  State<SubscriptonDetailsPage> createState() => _SubscriptonDetailsPageState();
}

class _SubscriptonDetailsPageState extends State<SubscriptonDetailsPage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final args =
          ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
      final subsId = args != null && args.containsKey('subsId')
          ? args['subsId'] as String?
          : null;
      context.read<SubscriptionCartProvider>().getSubscriptionDetails(
            context: context,
            subsId: '$subsId',
          );
      context.read<SubscriptionDetailsProvider>().getSubsDayDetails(
            subsId: '$subsId',
          );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final String accountType =
        sharedPrefsService.getString(SharedPrefsKeys.accountType) ?? '';
    final subsCartProvider =
        Provider.of<SubscriptionCartProvider>(context, listen: false);
    return Scaffold(
      appBar: CustomAppbarWithCenterTitle(
        title: 'Subscription Details',
        accountType: accountType,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(32.w),
          child: Column(
            children: [
              DeliveryStatusCard(
                accountType: accountType,
              ),

              SizedBox(height: 10.h),

              CenterTitleWithDivider(
                accountType: accountType,
                title: 'ITEMS DETAILS',
                fontSize: 20.sp,
              ),
              SizedBox(height: 10.h),

              ItemDetailsWidget(
                accountType: accountType,
              ),

              SizedBox(height: 10.h),

              //* Dropdown
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    'Time Slot:',
                    style: GoogleFonts.publicSans(
                      fontSize: 18.sp,
                    ),
                  ),
                  SelectTimeSlotDropdown(
                    accountType: accountType,
                  ),
                ],
              ),

              SizedBox(height: 10.h),

              //* Customize Divider
              CenterTitleWithDivider(
                accountType: accountType,
                title: 'CUSTOMIZE',
                fontSize: 20.sp,
              ),

              SizedBox(height: 10.h),
              //* Calendar Widget
              CalendarWidget(
                accountType: accountType,
              ),
              //* Divider
              CenterTitleWithDivider(
                accountType: accountType,
                title: 'SUMMARY',
                fontSize: 20.sp,
              ),
              SizedBox(height: 20.h),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Consumer<SubscriptionCartProvider>(
                      builder: (context, _, child) {
                    log('date is: ${subsCartProvider.summaryRes?.data?.createdAt}');
                    return _buildText(
                      label: 'Subscribed Date',
                      value: Utils.formatSubscriptionDate(
                          '${subsCartProvider.summaryRes?.data?.createdAt}'),
                      accountType: accountType,
                    );
                  }),
                  Consumer<SubscriptionCartProvider>(
                    builder: (context, _, child) => _buildText(
                      label: 'Unit',
                      value: '${subsCartProvider.summaryRes?.data?.units}',
                      accountType: accountType,
                    ),
                  ),
                  _buildText(
                    label: 'Period',
                    value: 'Monthly (static)',
                    accountType: accountType,
                  ),
                  Consumer<SubscriptionCartProvider>(
                    builder: (context, _, child) => _buildText(
                      label: 'Timings',
                      value:
                          '${subsCartProvider.summaryRes?.data?.items?.first.mealSubscription?.first.timeSlot}',
                      accountType: accountType,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.h),
              //* Note:
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Note:',
                    style: GoogleFonts.publicSans(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  RichText(
                    text: TextSpan(
                      style: GoogleFonts.publicSans(
                          color: Colors.black, fontSize: 16.sp),
                      children: [
                        const TextSpan(
                            text:
                                'Our delivery service operates exclusively on weekdays '),
                        TextSpan(
                          text: '(Monday to Saturday, 9 AM to 5 PM)',
                          style: GoogleFonts.publicSans(
                              fontWeight: FontWeight.bold),
                        ),
                        const TextSpan(
                            text:
                                '. We do not deliver on, Sundays, or public holidays.'),
                      ],
                    ),
                  ),
                  SizedBox(height: 10.h),
                  RichText(
                    text: TextSpan(
                      style: GoogleFonts.publicSans(
                          color: Colors.black, fontSize: 14.sp),
                      children: const [
                        TextSpan(
                            text:
                                'If you are unavailable at your delivery address on any specific weekday, you can select the date to disable the delivery. '),
                        TextSpan(
                          text: 'The skipped delivery will be postponed',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                            text:
                                ' as an additional day added to your subscription.'),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildText({
    required String label,
    required String value,
    required String accountType,
  }) {
    return Row(
      children: [
        Text(
          "$label : ",
          style: GoogleFonts.publicSans(
            fontSize: 18.sp,
            color: getColorAccountType(
              accountType: accountType,
              businessColor: AppColors.disabledColor,
              personalColor: AppColors.bayLeaf,
            ),
          ),
        ),
        Text(
          value,
          style: GoogleFonts.publicSans(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: getColorAccountType(
              accountType: accountType,
              businessColor: AppColors.primaryColor,
              personalColor: AppColors.darkGreenGrey,
            ),
          ),
        ),
      ],
    );
  }
}
