import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/utils/app_colors.dart';

class BillingCardWidget extends StatelessWidget {
  const BillingCardWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: 360.w, // height: 420.h,
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.circular(30.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 14.h, bottom: 11.h),
            child: Center(
              child: Text(
                'TODAY',
                style: GoogleFonts.publicSans(
                  color: Colors.white,
                  fontSize: 10.sp,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
              ),
            ),
          ),
          Center(
            child: SizedBox(
              width: 320.w,
              child: Divider(
                color: AppColors.seaShell.withOpacity(.5),
                thickness: 1,
              ),
            ),
          ),
          // SizedBox(height: 5.h),
          ListView.builder(
            padding: EdgeInsets.only(bottom: 15.h),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 6,
            itemBuilder: (context, index) {
              return Container(
                height: 40.h,
                margin: EdgeInsets.symmetric(
                  horizontal: 22.w,
                  vertical: 8.h,
                ),
                decoration: BoxDecoration(
                  color: AppColors.seaShell,
                  borderRadius: BorderRadius.circular(30.r),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 16.w),
                      child: Text(
                        '9/12/2024 05:55PM',
                        style: GoogleFonts.publicSans(
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 12.sp,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 16.w),
                      child: RichText(
                        text: TextSpan(
                          text: 'INVOICE: ',
                          style: GoogleFonts.publicSans(
                            color: AppColors.disabledColor,
                            fontSize: 12.sp,
                          ),
                          children: [
                            TextSpan(
                              text: '1234567',
                              style: GoogleFonts.publicSans(
                                color: AppColors.disabledColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
