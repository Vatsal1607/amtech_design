import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class SubscriptionDetailsShimmer extends StatelessWidget {
  const SubscriptionDetailsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _shimmerBox(width: 200.w, height: 24.h), // Header
            SizedBox(height: 24.h),

            // Summary Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(3, (index) => _shimmerSummaryBox()),
            ),
            SizedBox(height: 32.h),

            _shimmerBox(width: 150.w, height: 20.h), // Items Details title
            SizedBox(height: 16.h),

            _shimmerContainer(height: 140.h), // Card block for items & button
            SizedBox(height: 24.h),

            _shimmerBox(width: 100.w, height: 18.h), // Time Slot text
            SizedBox(height: 8.h),
            _shimmerContainer(height: 50.h, borderRadius: 30.r), // Time Slot
            SizedBox(height: 32.h),

            _shimmerBox(width: 120.w, height: 20.h), // Customize title
            SizedBox(height: 16.h),
            _shimmerContainer(height: 300.h), // Calendar block
          ],
        ),
      ),
    );
  }

  Widget _shimmerBox({required double width, required double height}) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }

  Widget _shimmerContainer({required double height, double borderRadius = 20}) {
    return Container(
      width: double.infinity,
      height: height,
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
    );
  }

  Widget _shimmerSummaryBox() {
    return Expanded(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 4.w),
        padding: EdgeInsets.symmetric(vertical: 16.h),
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            Container(height: 20.h, width: 30.w, color: Colors.grey),
            SizedBox(height: 8.h),
            Container(height: 12.h, width: 50.w, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}
