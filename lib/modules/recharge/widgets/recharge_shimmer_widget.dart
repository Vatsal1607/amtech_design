import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/constant.dart';
import '../../../core/utils/constants/keys.dart';
import '../../../services/local/shared_preferences_service.dart';

class RechargeShimmerWidget extends StatelessWidget {
  const RechargeShimmerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    String accountType =
        sharedPrefsService.getString(SharedPrefsKeys.accountType) ?? '';
    return Scaffold(
      backgroundColor: getColorAccountType(
        accountType: accountType,
        businessColor: AppColors.seaShell,
        personalColor: AppColors.seaMist,
      ),
      body: SafeArea(
        child: Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: SingleChildScrollView(
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header row (back button + logo + info icon)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _circle(height: 60.h, width: 60.w),
                    Container(height: 40.h, width: 100.w, color: Colors.white),
                    _circle(height: 60.h, width: 60.w),
                  ],
                ),
                SizedBox(height: 30.h),

                // Balance Card
                Container(
                  height: 150.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(40.r),
                  ),
                ),
                SizedBox(height: 30.h),

                // Recharge Title
                Center(
                  child: Container(
                      height: 30.h, width: 120.w, color: Colors.white),
                ),
                SizedBox(height: 30.h),

                // Enter Amount Field
                Container(
                  height: 70.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30.r),
                  ),
                ),
                SizedBox(height: 20.h),

                // Note text
                Container(height: 20.h, width: 250.w, color: Colors.white),
                SizedBox(height: 40.h),

                // Recharge Button
                Container(
                  height: 50.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(40.r),
                  ),
                ),
                SizedBox(height: 50.h),

                // Recharge History Title
                Container(height: 30.h, width: 160.w, color: Colors.white),
                SizedBox(height: 30.h),

                // Recharge history list
                ...List.generate(5, (index) => _shimmerHistoryRow()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget _shimmerHistoryRow() {
  return Padding(
    padding: EdgeInsets.only(bottom: 20.h),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(height: 20.h, width: 80.w, color: Colors.white), // Date
        Container(height: 20.h, width: 70.w, color: Colors.white), // Amount
        _circle(height: 20.h, width: 20.w), // Status icon
        Container(height: 20.h, width: 50.w, color: Colors.white), // Perks
      ],
    ),
  );
}

Widget _circle({required double height, required double width}) {
  return Container(
    height: height,
    width: width,
    decoration: const BoxDecoration(
      color: Colors.white,
      shape: BoxShape.circle,
    ),
  );
}
