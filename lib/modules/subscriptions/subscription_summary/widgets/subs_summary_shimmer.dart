import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class SubsSummaryShimmer extends StatelessWidget {
  const SubsSummaryShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: Container(
          padding: EdgeInsets.all(20.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24.r),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(height: 20.h, width: 180.w, color: Colors.white),
                  Container(height: 30.h, width: 50.w, color: Colors.white),
                ],
              ),
              SizedBox(height: 24.h),

              // Units and Price row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(height: 30.h, width: 100.w, color: Colors.white),
                  Container(height: 30.h, width: 70.w, color: Colors.white),
                ],
              ),
              SizedBox(height: 32.h),

              // Weekday
              Container(height: 20.h, width: 80.w, color: Colors.white),
              SizedBox(height: 12.h),

              // Time slot
              Container(height: 18.h, width: 180.w, color: Colors.white),
              SizedBox(height: 12.h),

              // Meal name
              Container(height: 16.h, width: 220.w, color: Colors.white),
              SizedBox(height: 10.h),

              // Add-ons / Ingredients
              Container(height: 14.h, width: 150.w, color: Colors.white),
              // Place Order Button
              Container(
                height: 60.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(32.r),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
