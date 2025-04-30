import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class SubsCartShimmer extends StatelessWidget {
  const SubsCartShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          children: [
            // Bill Card
            Container(
              padding: EdgeInsets.all(20.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24.r),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                          height: 20.h, width: 120.w, color: Colors.white),
                      Container(height: 20.h, width: 20.w, color: Colors.white),
                    ],
                  ),
                  SizedBox(height: 30.h),

                  // Items row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                          height: 20.h, width: 100.w, color: Colors.white),
                      Container(height: 20.h, width: 60.w, color: Colors.white),
                    ],
                  ),
                  SizedBox(height: 30.h),

                  // Payable Amount Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                          height: 20.h, width: 140.w, color: Colors.white),
                      Container(height: 20.h, width: 80.w, color: Colors.white),
                    ],
                  ),
                  SizedBox(height: 30.h),

                  // Item Total, GST, Delivery Fee
                  Container(
                      height: 16.h,
                      width: double.infinity,
                      color: Colors.white),
                  SizedBox(height: 10.h),
                  Container(
                      height: 16.h,
                      width: double.infinity,
                      color: Colors.white),
                  SizedBox(height: 10.h),
                  Container(
                      height: 16.h,
                      width: double.infinity,
                      color: Colors.white),
                ],
              ),
            ),
            SizedBox(height: 30.h),
            // Subscription Start Date
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(height: 30.h, width: 180.w, color: Colors.white),
                Container(height: 40.h, width: 70.w, color: Colors.white),
              ],
            ),
            SizedBox(height: 30.h),

            // Phone Info
            Container(
                height: 30.h, width: double.infinity, color: Colors.white),
            SizedBox(height: 16.h),

            // Address Info
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(height: 40.h, width: 220.w, color: Colors.white),
                Container(height: 30.h, width: 70.w, color: Colors.white),
              ],
            ),
            SizedBox(height: 30.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(height: 40.h, width: 220.w, color: Colors.white),
                Container(height: 30.h, width: 70.w, color: Colors.white),
              ],
            ),
            SizedBox(height: 30.h),

            // Cancellation Policy
            Container(
                height: 30.h, width: double.infinity, color: Colors.white),
            SizedBox(height: 30.h),
            Container(
                height: 14.h, width: double.infinity, color: Colors.white),
            SizedBox(height: 30.h),
            Container(height: 14.h, width: 240.w, color: Colors.white),
            SizedBox(height: 30.h),

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
    );
  }
}
