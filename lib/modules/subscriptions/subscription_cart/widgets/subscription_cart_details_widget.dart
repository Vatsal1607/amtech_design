import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/utils/app_colors.dart';

class SubscriptionCartDetailsWidget extends StatelessWidget {
  const SubscriptionCartDetailsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDetailRow(
            icon: Icons.calendar_today,
            title: "Subscription Start Date",
            subtitle: "12/03/2025",
          ),
          _buildDetailRow(
            icon: Icons.phone,
            title: "Rahul Sharma",
            subtitle: "+91 9624917829",
          ),
          _buildDetailRow(
            icon: Icons.location_city,
            title: "Delivery At",
            subtitle:
                "E/807, 8th Floor, Titanium City Center, 100 Feet Anand Nagar Road, Jodhpur Village, Ahmedabad",
            highlightText: "Work",
          ),
          SizedBox(height: 20.h),
          Text(
            "Cancellation Policy",
            style: GoogleFonts.publicSans(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.disabledColor,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            "You can cancel your subscription anytime before the next billing cycle. Refunds are not applicable once the subscription period has started.",
            style: GoogleFonts.publicSans(
              fontSize: 14.sp,
              color: AppColors.disabledColor,
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
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 22, color: AppColors.disabledColor),
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
                            color: AppColors.disabledColor,
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
                      fontSize: 14.sp, color: AppColors.disabledColor),
                ),
              ],
            ),
          ),
          // * Change button
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.h, vertical: 6.h),
            decoration: BoxDecoration(
              color: AppColors.primaryColor,
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
        ],
      ),
    );
  }
}
