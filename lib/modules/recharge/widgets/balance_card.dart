import 'package:amtech_design/core/utils/constant.dart';
import 'package:amtech_design/modules/recharge/recharge_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../core/utils/app_colors.dart';

class BalanceCardWidget extends StatelessWidget {
  final String accountType;
  const BalanceCardWidget({
    super.key,
    required this.accountType,
  });

  @override
  Widget build(BuildContext context) {
    final borderColor = getColorAccountType(
      accountType: accountType,
      businessColor: AppColors.primaryColor,
      personalColor: AppColors.darkGreenGrey,
    );

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40.r),
        border: Border.all(
          color: borderColor,
          width: 1.w,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //* Top Section - Available Balance
          Container(
            decoration: BoxDecoration(
              color: borderColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40.r),
                topRight: Radius.circular(40.r),
              ),
            ),
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Available Balance",
                  style: GoogleFonts.publicSans(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Consumer<RechargeProvider>(
                  builder: (context, provider, child) => Text(
                    '₹ ${provider.historyRes?.data?.totalAmount ?? '0'}',
                    style: GoogleFonts.publicSans(
                      color: Colors.white,
                      fontSize: 22.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),

          //* Middle Section - Closing Balance
          Container(
            decoration: BoxDecoration(
              color: getColorAccountType(
                accountType: accountType,
                businessColor: AppColors.disabledColor,
                personalColor: AppColors.bayLeaf,
              ),
              border: Border(
                top: BorderSide(color: borderColor, width: 1.w),
                bottom: BorderSide(color: borderColor, width: 1.w),
              ),
            ),
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 14.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Closing Balance",
                  style: GoogleFonts.publicSans(
                    color: borderColor,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Consumer<RechargeProvider>(
                  builder: (context, provider, child) => Text(
                    '₹ ${provider.historyRes?.data?.closingBalance ?? '0'}',
                    style: GoogleFonts.publicSans(
                      color: borderColor,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),

          //* Bottom Section - Total Perks Earned
          Container(
            decoration: BoxDecoration(
              color: getColorAccountType(
                accountType: accountType,
                businessColor: AppColors.seaShell,
                personalColor: AppColors.seaMist,
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40.r),
                bottomRight: Radius.circular(40.r),
              ),
            ),
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 14.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Total Perks Earned",
                  style: GoogleFonts.publicSans(
                    color: const Color(0xFF0D1E3A),
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Consumer<RechargeProvider>(
                  builder: (context, provider, child) => Text(
                    '₹ ${provider.historyRes?.data?.totalPerks ?? '0'}',
                    style: GoogleFonts.publicSans(
                      color: const Color(0xFF0D1E3A),
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
