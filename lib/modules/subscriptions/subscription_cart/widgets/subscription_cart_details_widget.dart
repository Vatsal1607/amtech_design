import 'package:amtech_design/core/utils/constant.dart';
import 'package:amtech_design/core/utils/constants/keys.dart';
import 'package:amtech_design/core/utils/utils.dart';
import 'package:amtech_design/modules/subscriptions/create_subscription_plan/create_subscription_plan_provider.dart';
import 'package:amtech_design/services/local/shared_preferences_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../routes.dart';
import '../subscription_cart_provider.dart';

class SubscriptionCartDetailsWidget extends StatefulWidget {
  final SubscriptionCartProvider provider;
  final String accountType;
  const SubscriptionCartDetailsWidget({
    super.key,
    required this.provider,
    required this.accountType,
  });

  @override
  State<SubscriptionCartDetailsWidget> createState() =>
      _SubscriptionCartDetailsWidgetState();
}

class _SubscriptionCartDetailsWidgetState
    extends State<SubscriptionCartDetailsWidget> {
  @override
  void initState() {
    Future.microtask(() {
      context.read<SubscriptionCartProvider>().loadAddress();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Consumer<SubscriptionCartProvider>(
            builder: (context, provider, child) => _buildDetailRow(
              accountType: widget.accountType,
              icon: Icons.calendar_today,
              onTapChange: () {
                provider.pickStartDate(context);
              },
              title: "Subscription Start Date",
              subtitle: Utils.formatDateToDDMMYYYY('${provider.subsStartDate}'),
            ),
          ),
          _buildDetailRow(
            accountType: widget.accountType,
            isChange: false,
            icon: Icons.phone,
            title: '${sharedPrefsService.getString(SharedPrefsKeys.userName)}',
            subtitle:
                '+${sharedPrefsService.getString(SharedPrefsKeys.userContact)}',
          ),
          Consumer<SubscriptionCartProvider>(
            builder: (context, provider, child) => _buildDetailRow(
              accountType: widget.accountType,
              onTapChange: () async {
                await Navigator.pushNamed(
                  context,
                  Routes.googleMapPage,
                );
                await widget.provider.loadAddress();
                context //* Api call
                    .read<CreateSubscriptionPlanProvider>()
                    .subscriptionUpdate(
                      context: context,
                      deliveryAddress: provider.selectedAddress,
                    );
              },
              icon: Icons.location_city,
              title: "Delivery At",
              subtitle:
                  widget.provider.selectedAddress ?? 'Please Select Address',
              highlightText: "Work",
            ),
          ),
          SizedBox(height: 20.h),
          Text(
            "Cancellation Policy",
            style: GoogleFonts.publicSans(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: getColorAccountType(
                accountType: widget.accountType,
                businessColor: AppColors.primaryColor,
                personalColor: AppColors.darkGreenGrey,
              ),
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            "You can cancel your subscription anytime before the next billing cycle. Refunds are not applicable once the subscription period has started.",
            style: GoogleFonts.publicSans(
              fontSize: 14.sp,
              color: getColorAccountType(
                accountType: widget.accountType,
                businessColor: AppColors.primaryColor,
                personalColor: AppColors.darkGreenGrey,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget to create each row dynamically
  Widget _buildDetailRow({
    required IconData icon,
    required String title,
    required String subtitle,
    String? highlightText,
    bool isChange = true,
    VoidCallback? onTapChange,
    required String accountType,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            size: 22,
            color: getColorAccountType(
              accountType: accountType,
              businessColor: AppColors.primaryColor,
              personalColor: AppColors.darkGreenGrey,
            ),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    style: GoogleFonts.publicSans(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                    children: [
                      TextSpan(
                          text: title,
                          style: GoogleFonts.publicSans(
                            color: getColorAccountType(
                              accountType: accountType,
                              businessColor: AppColors.primaryColor,
                              personalColor: AppColors.darkGreenGrey,
                            ),
                          )),
                      if (highlightText != null)
                        TextSpan(
                          text: " $highlightText",
                          style: GoogleFonts.publicSans(
                              fontWeight: FontWeight.bold, color: Colors.black),
                        ),
                    ],
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  subtitle,
                  style: GoogleFonts.publicSans(
                    fontSize: 14.sp,
                    color: getColorAccountType(
                      accountType: accountType,
                      businessColor: AppColors.primaryColor,
                      personalColor: AppColors.darkGreenGrey,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // * Change button
          if (isChange)
            GestureDetector(
              onTap: onTapChange,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12.h, vertical: 6.h),
                decoration: BoxDecoration(
                  color: getColorAccountType(
                    accountType: accountType,
                    businessColor: AppColors.primaryColor,
                    personalColor: AppColors.darkGreenGrey,
                  ),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Text(
                  "Change",
                  style: GoogleFonts.publicSans(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
