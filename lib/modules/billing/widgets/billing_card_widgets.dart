import 'package:amtech_design/core/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/utils/app_colors.dart';

class BillingCardWidget extends StatelessWidget {
  final String accountType;
  const BillingCardWidget({
    super.key,
    required this.accountType,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: getColorAccountType(
          accountType: accountType,
          businessColor: AppColors.primaryColor,
          personalColor: AppColors.darkGreenGrey,
        ),
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
                color: getColorAccountType(
                  accountType: accountType,
                  businessColor: AppColors.seaShell.withOpacity(.5),
                  personalColor: AppColors.seaMist.withOpacity(.5),
                ),
                thickness: 1,
              ),
            ),
          ),
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
                  color: getColorAccountType(
                    accountType: accountType,
                    businessColor: AppColors.seaShell,
                    personalColor: AppColors.seaMist,
                  ),
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
                          color: getColorAccountType(
                            accountType: accountType,
                            businessColor: AppColors.primaryColor,
                            personalColor: AppColors.darkGreenGrey,
                          ),
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
                            color: getColorAccountType(
                              accountType: accountType,
                              businessColor: AppColors.disabledColor,
                              personalColor: AppColors.bayLeaf,
                            ),
                            fontSize: 12.sp,
                          ),
                          children: [
                            TextSpan(
                              text: '1234567',
                              style: GoogleFonts.publicSans(
                                color: getColorAccountType(
                                  accountType: accountType,
                                  businessColor: AppColors.disabledColor,
                                  personalColor: AppColors.bayLeaf,
                                ),
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
