import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class SubscriptionPageShimmer extends StatelessWidget {
  const SubscriptionPageShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 20.h),
        _buildSectionTitle(),
        SizedBox(height: 20.h),
        _buildShimmerCard(),
        SizedBox(height: 20.h),
        _buildShimmerCard(),
        SizedBox(height: 32.h),
        _buildSectionTitle(),
        SizedBox(height: 20.h),
        _buildShimmerCard(),
        SizedBox(height: 20.h),
        _buildShimmerCard(),
        SizedBox(height: 20.h),
        _buildShimmerCard(),
      ],
    );
  }

  Widget _buildSectionTitle() {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Row(
        children: [
          const Expanded(child: Divider(thickness: 2, color: Colors.grey)),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: Container(
              width: 100.w,
              height: 20.h,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
          ),
          const Expanded(child: Divider(thickness: 2, color: Colors.grey)),
        ],
      ),
    );
  }

  Widget _buildShimmerCard() {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16.w),
        padding: const EdgeInsets.all(16),
        height: 120.h,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(28.r),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildShimmerBox(width: 160.w, height: 20.h),
                  SizedBox(height: 10.h),
                  Row(
                    children: [
                      _buildShimmerBox(width: 60.w, height: 24.h),
                      SizedBox(width: 8.w),
                      _buildShimmerBox(width: 50.w, height: 20.h),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  _buildShimmerBox(width: 200.w, height: 16.h),
                ],
              ),
            ),
            SizedBox(width: 16.w),
            _buildShimmerBox(width: 80.w, height: 80.h),
          ],
        ),
      ),
    );
  }

  Widget _buildShimmerBox({required double width, required double height}) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(8.r),
      ),
    );
  }
}
