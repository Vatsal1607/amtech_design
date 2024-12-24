import 'package:amtech_design/core/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/strings.dart';
import 'order_status_icon_widget.dart';
import 'progress_line_widget.dart';

class OrderStatusWithProgressWidget extends StatelessWidget {
  final String accountType;
  const OrderStatusWithProgressWidget({
    super.key,
    required this.accountType,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: getColorAccountType(
          accountType: accountType,
          businessColor: AppColors.disabledColor,
          personalColor: AppColors.bayLeaf,
        ),
        borderRadius: BorderRadius.circular(30.r),
      ),
      child: Column(
        children: [
          Row(
            children: [
              // * Status Icon widget
              OrderStatusIconWidget(
                accountType: accountType,
                isActive: true,
                icon: IconStrings.orderStatus1,
              ),

              // * Progress line 1
              ProgressLineWidget(
                value: 0.5,
              ),

              // * Status Icon widget
              OrderStatusIconWidget(
                accountType: accountType,
                icon: IconStrings.orderStatus2,
              ),

              // * Progress line 2
              ProgressLineWidget(
                value: 0.0,
              ),

              // * Status Icon widget
              OrderStatusIconWidget(
                accountType: accountType,
                icon: IconStrings.orderStatus3,
              ),

              // * Progress line 3
              ProgressLineWidget(
                value: 0.0,
              ),

              // * Status Icon widget
              OrderStatusIconWidget(
                accountType: accountType,
                icon: IconStrings.orderStatus4,
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Your Order Is",
              style: GoogleFonts.publicSans(
                fontSize: 12.sp,
                color: getColorAccountType(
                  accountType: accountType,
                  businessColor: AppColors.primaryColor,
                  personalColor: AppColors.darkGreenGrey,
                ),
              ),
            ),
          ),
          SizedBox(height: 4.h),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Placed Successfully!",
              style: GoogleFonts.publicSans(
                fontWeight: FontWeight.bold,
                fontSize: 20.sp,
                color: getColorAccountType(
                  accountType: accountType,
                  businessColor: AppColors.primaryColor,
                  personalColor: AppColors.darkGreenGrey,
                ),
              ),
            ),
          ),
          SizedBox(height: 16.h),
          Divider(
            color: getColorAccountType(
              accountType: accountType,
              businessColor: AppColors.primaryColor.withOpacity(.3),
              personalColor: AppColors.darkGreenGrey.withOpacity(.3),
            ),
            thickness: 2,
          ),
          Theme(
            data: Theme.of(context).copyWith(
              dividerColor: Colors.transparent,
            ),
            child: ExpansionTile(
              minTileHeight: 20.h,
              title: Text(
                'View Order Details',
                textAlign: TextAlign.center,
                style: GoogleFonts.publicSans(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.bold,
                  color: getColorAccountType(
                    accountType: accountType,
                    businessColor: AppColors.primaryColor,
                    personalColor: AppColors.darkGreenGrey,
                  ),
                ),
              ),
              iconColor: getColorAccountType(
                accountType: accountType,
                businessColor: AppColors.primaryColor,
                personalColor: AppColors.darkGreenGrey,
              ),
              collapsedIconColor: getColorAccountType(
                accountType: accountType,
                businessColor: AppColors.primaryColor,
                personalColor: AppColors.darkGreenGrey,
              ),
              children: const [
                Text('data 1'),
                Text('data 2'),
              ],
            ),
          ),
          // SizedBox(height: 50.h),
        ],
      ),
    );
  }
}
