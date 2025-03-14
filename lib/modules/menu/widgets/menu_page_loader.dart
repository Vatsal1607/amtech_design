import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/constant.dart';
import '../../../core/utils/constants/keys.dart';
import '../../../services/local/shared_preferences_service.dart';

class MenuPageLoader extends StatelessWidget {
  const MenuPageLoader({super.key});

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
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Section
              Row(
                children: [
                  _shimmerCircle(60.r),
                  SizedBox(width: 12.w),
                  Expanded(
                      child: _shimmerContainer(height: 20.h, width: 100.w)),
                  SizedBox(width: 12.w),
                  _shimmerCircle(60.r),
                ],
              ),
              SizedBox(height: 20.h),

              // Location Bar
              _shimmerContainer(height: 15.h, width: 250.w),
              SizedBox(height: 20.h),

              // Perks Section
              _shimmerContainer(height: 20.h, width: 180.w),
              SizedBox(height: 20.h),

              // Search Bar
              _shimmerContainer(
                  height: 50.h, width: double.infinity, borderRadius: 25.r),
              SizedBox(height: 20.h),

              // Banner Carousel
              SizedBox(
                height: 170.h,
                child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: 3,
                  itemBuilder: (context, index) => Padding(
                    padding: EdgeInsets.only(right: 10.w),
                    child: _shimmerContainer(height: 140.h, width: 280.w),
                  ),
                ),
              ),
              SizedBox(height: 20.h),

              // Subscription Section
              _shimmerContainer(height: 120.h, width: double.infinity),
              SizedBox(height: 20.h),

              // Best Seller Items
              Row(
                children: [
                  Expanded(child: _shimmerContainer(height: 120.h)),
                  SizedBox(width: 12.h),
                  Expanded(child: _shimmerContainer(height: 120.h)),
                ],
              ),
              SizedBox(height: 20.h),
              // Bottom Menu
              Stack(
                children: [
                  _shimmerContainer(
                    height: 70.h,
                    width: 320.w,
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: _shimmerCircle(60.h),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Reusable Shimmer Container
  Widget _shimmerContainer(
      {double height = 50,
      double width = double.infinity,
      double borderRadius = 10}) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
    );
  }

  // Reusable Shimmer Circle
  Widget _shimmerCircle(double size) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        height: size,
        width: size,
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
