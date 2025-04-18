import 'package:amtech_design/core/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../subscription_cart/subscription_cart_provider.dart';

class DeliveryStatusCard extends StatelessWidget {
  final String accountType;
  const DeliveryStatusCard({
    super.key,
    required this.accountType,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 24.w),
      decoration: BoxDecoration(
        color: getColorAccountType(
          accountType: accountType,
          businessColor: AppColors.primaryColor,
          personalColor: AppColors.darkGreenGrey,
        ),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Consumer<SubscriptionCartProvider>(
            builder: (context, provider, child) => _buildStatColumn(
              "${provider.summaryRes?.data?.history?.totalUnits}",
              "TOTAL",
              Colors.grey.shade400,
            ),
          ),
          Consumer<SubscriptionCartProvider>(
            builder: (context, provider, child) => _buildStatColumn(
              "${provider.summaryRes?.data?.history?.remainingUnits}",
              "REMAINING",
              Colors.white,
            ),
          ),
          Consumer<SubscriptionCartProvider>(
            builder: (context, provider, child) => _buildStatColumn(
              "${provider.summaryRes?.data?.history?.deliveredUnits}",
              "DELIVERED",
              Colors.green,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatColumn(String number, String label, Color color) {
    return Column(
      children: [
        Text(
          number,
          style: TextStyle(
            color: color,
            fontSize: 22.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          label,
          style: TextStyle(
            color: color,
            fontSize: 12.sp,
            letterSpacing: 1,
          ),
        ),
      ],
    );
  }
}
