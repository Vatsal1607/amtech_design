import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

// * to be continued
class OrderStatusPage extends StatelessWidget {
  const OrderStatusPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20.h),
            Text(
              "Your Order Has Been",
              style: GoogleFonts.publicSans(
                fontWeight: FontWeight.bold,
                fontSize: 16.sp,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              "Placed Successfully!",
              style: GoogleFonts.publicSans(
                fontWeight: FontWeight.bold,
                fontSize: 24.sp,
                color: Color(0xFF778DA9), // Blueish text
              ),
            ),
            SizedBox(height: 40.h),
            Center(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 24.w),
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: Color(0xFFCAD8E0),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Icon(Icons.check_circle, color: Colors.black),
                        Expanded(
                          child: Container(
                            height: 2.h,
                            margin: EdgeInsets.symmetric(horizontal: 8.w),
                            color: Colors.black,
                          ),
                        ),
                        Icon(Icons.local_fire_department, color: Colors.black),
                        Expanded(
                          child: Container(
                            height: 2.h,
                            margin: EdgeInsets.symmetric(horizontal: 8),
                            color: Colors.black,
                          ),
                        ),
                        Icon(Icons.directions_walk, color: Colors.black),
                        Expanded(
                          child: Container(
                            height: 2,
                            margin: EdgeInsets.symmetric(horizontal: 8),
                            color: Colors.black,
                          ),
                        ),
                        Icon(Icons.timer, color: Colors.black),
                      ],
                    ),
                    SizedBox(height: 16),
                    Text(
                      "Your Order Is",
                      style: TextStyle(fontSize: 14, color: Colors.black),
                    ),
                    SizedBox(height: 4),
                    Text(
                      "Placed Successfully!",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 16),
                    Divider(
                      color: Colors.black,
                      thickness: 1,
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        "View Order Details",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 40),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 24),
              width: double.infinity,
              height: 56,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Text(
                  "GO TO HOME",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
