import 'dart:developer';
import 'package:amtech_design/core/utils/constant.dart';
import 'package:amtech_design/core/utils/constants/keys.dart';
import 'package:amtech_design/custom_widgets/appbar/custom_appbar_with_center_title.dart';
import 'package:amtech_design/custom_widgets/loader/custom_loader.dart';
import 'package:amtech_design/modules/recharge/widgets/center_title_with_divider.dart';
import 'package:amtech_design/modules/subscriptions/subscription/subscription_details/widgets/calender_widget.dart';
import 'package:amtech_design/modules/subscriptions/subscription/subscription_details/widgets/delivery_status_widget.dart';
import 'package:amtech_design/modules/subscriptions/subscription/subscription_details/widgets/item_details.dart';
import 'package:amtech_design/modules/subscriptions/subscription/subscription_details/widgets/subs_details_shimmer.dart';
import 'package:amtech_design/modules/subscriptions/subscription/subscription_details/widgets/timslot_dropdown_widget.dart';
import 'package:amtech_design/services/local/shared_preferences_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/utils.dart';
import '../../../../models/subscription_modify_request_model.dart' as modify;
import 'package:amtech_design/models/subscription_summary_model.dart'
    as summary;
import '../../create_subscription_plan/create_subscription_plan_provider.dart';
import '../../subscription_cart/subscription_cart_provider.dart';
import 'subscription_details_provider.dart';

class SubscriptonDetailsPage extends StatefulWidget {
  const SubscriptonDetailsPage({super.key});

  @override
  State<SubscriptonDetailsPage> createState() => _SubscriptonDetailsPageState();
}

class _SubscriptonDetailsPageState extends State<SubscriptonDetailsPage> {
  String? modifySubsId;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final args =
          ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
      final subsId = args != null && args.containsKey('subsId')
          ? args['subsId'] as String?
          : null;
      modifySubsId = subsId;
      final subsCartProvider =
          Provider.of<SubscriptionCartProvider>(context, listen: false);
      //* API call
      await subsCartProvider.getSubscriptionDetails(
        context: context,
        subsId: '$subsId',
      );
      final createdAtString = subsCartProvider.summaryRes?.data?.createdAt;
      DateTime? createdAtDate;
      if (createdAtString != null) {
        createdAtDate = DateTime.tryParse(createdAtString);
      }

      final subsDetailsProvider =
          Provider.of<SubscriptionDetailsProvider>(context, listen: false);
      //* Assign subsItems fromm subs cart (getSubscriptionDetails api)
      subsDetailsProvider.subsItem = subsCartProvider.summaryRes?.data?.items
              ?.map((item) => modify.SubscriptionItem.fromSummary(item))
              .toList() ??
          [];
      for (var item in subsDetailsProvider.subsItem) {
        log('subsItem list(details page) ${item.toJson()}'); // If you have toJson()
      }

      if (createdAtDate != null) {
        //* API call
        await subsDetailsProvider.getSubsDayDetails(
          subsId: '$subsId',
          day: subsDetailsProvider.getDayName(createdAtDate),
        );
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final String accountType =
        sharedPrefsService.getString(SharedPrefsKeys.accountType) ?? '';
    return Scaffold(
      appBar: CustomAppbarWithCenterTitle(
        title: 'Subscription Details',
        accountType: accountType,
      ),
      body: Consumer<SubscriptionCartProvider>(
        builder: (context, subsCartProvider, child) => subsCartProvider
                .isLoading
            ? const SubscriptionDetailsShimmer()
            : SingleChildScrollView(
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

                      Consumer<SubscriptionDetailsProvider>(
                        builder: (context, provider, child) =>
                            provider.isLoading
                                ? CustomLoader(
                                    backgroundColor: AppColors.primaryColor,
                                    height: 40.h,
                                    width: 40.w,
                                  )
                                : provider.dayDetailsRes == null
                                    ? Text(
                                        '${provider.errorMsg}',
                                        style: GoogleFonts.publicSans(
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )
                                    : ItemDetailsWidget(
                                        accountType: accountType,
                                      ),
                      ),

                      //* Timeslot Dropdown
                      Consumer<SubscriptionDetailsProvider>(
                        builder: (context, provider, child) =>
                            provider.dayDetailsRes == null
                                ? Container()
                                : Padding(
                                    padding: EdgeInsets.only(top: 10.h),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'TimeSlot:',
                                          style: GoogleFonts.publicSans(
                                            fontSize: 17.sp,
                                          ),
                                        ),
                                        //* Dropdown
                                        SelectTimeSlotDropdown(
                                          accountType: accountType,
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            log('save pressed');
                                            final subsDetailsProvider = Provider
                                                .of<SubscriptionDetailsProvider>(
                                                    context,
                                                    listen: false);
                                            context //* Api call
                                                .read<
                                                    CreateSubscriptionPlanProvider>()
                                                .subscriptionUpdate(
                                                  context: context,
                                                  isModifySubsItem: true,
                                                  modifySubsId: modifySubsId,
                                                  modifySubsItem:
                                                      subsDetailsProvider
                                                              .subsItem
                                                              .isNotEmpty
                                                          ? subsDetailsProvider
                                                              .subsItem
                                                          : null,
                                                );
                                          },
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 5.w,
                                              vertical: 7.h,
                                            ),
                                            decoration: BoxDecoration(
                                              color: AppColors.lightGreen,
                                              borderRadius:
                                                  BorderRadius.circular(15.r),
                                            ),
                                            child: Text(
                                              'SAVE',
                                              style: GoogleFonts.publicSans(
                                                fontSize: 17.sp,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
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
                              value:
                                  '${subsCartProvider.summaryRes?.data?.units}',
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
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Modify Note:',
                              style: GoogleFonts.publicSans(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Text(
                              'If you select a specific product for a particular day (e.g., Monday), you will receive the same product on that day every week.',
                              textAlign: TextAlign.justify,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 5.h),
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
                          RichText(
                            textAlign: TextAlign.justify,
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
                            textAlign: TextAlign.justify,
                            text: TextSpan(
                              style: GoogleFonts.publicSans(
                                  color: Colors.black, fontSize: 14.sp),
                              children: const [
                                TextSpan(
                                    text:
                                        'If you are unavailable at your delivery address on any specific weekday, you can select the date to disable the delivery. '),
                                TextSpan(
                                  text:
                                      'The skipped delivery will be postponed',
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
