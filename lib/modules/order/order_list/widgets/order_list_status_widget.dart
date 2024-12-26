import 'package:amtech_design/custom_widgets/buttons/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/constant.dart';
import '../../../../core/utils/strings.dart';
import '../../../../routes.dart';
import '../../order_status/widgets/order_status_icon_widget.dart';
import '../../order_status/widgets/progress_line_widget.dart';

class OrderListStatusWidget extends StatelessWidget {
  final String accountType;
  const OrderListStatusWidget({super.key, required this.accountType});

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
              const ProgressLineWidget(
                value: 0.5,
              ),

              // * Status Icon widget
              OrderStatusIconWidget(
                accountType: accountType,
                icon: IconStrings.orderStatus2,
              ),

              // * Progress line 2
              const ProgressLineWidget(
                value: 0.0,
              ),

              // * Status Icon widget
              OrderStatusIconWidget(
                accountType: accountType,
                icon: IconStrings.orderStatus3,
              ),

              // * Progress line 3
              const ProgressLineWidget(
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
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
              Row(
                children: [
                  Text(
                    'Ordered On ',
                    style: GoogleFonts.publicSans(
                      fontSize: 12.sp,
                      color: getColorAccountType(
                        accountType: accountType,
                        businessColor: AppColors.primaryColor,
                        personalColor: AppColors.darkGreenGrey,
                      ),
                    ),
                  ),
                  Text(
                    '5:55 PM',
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
                ],
              ),
            ],
          ),
          SizedBox(height: 10.h),
          Row(
            children: [
              Text(
                'Masala Tea, Green Tea ',
                style: GoogleFonts.publicSans(
                  fontWeight: FontWeight.bold,
                  fontSize: 15.sp,
                  color: getColorAccountType(
                    accountType: accountType,
                    businessColor: AppColors.primaryColor,
                    personalColor: AppColors.darkGreenGrey,
                  ),
                ),
              ),
              Text(
                '& More',
                style: GoogleFonts.publicSans(
                  fontSize: 15.sp,
                  color: getColorAccountType(
                    accountType: accountType,
                    businessColor: AppColors.primaryColor,
                    personalColor: AppColors.darkGreenGrey,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10.h),
          CustomButton(
            onTap: () {
              Navigator.pushNamed(context, Routes.orderStatus);
            },
            height: 48.h,
            text: 'view order',
            textColor: getColorAccountType(
              accountType: accountType,
              businessColor: AppColors.seaShell,
              personalColor: AppColors.seaMist,
            ),
            bgColor: getColorAccountType(
              accountType: accountType,
              businessColor: AppColors.primaryColor,
              personalColor: AppColors.darkGreenGrey,
            ),
          )
        ],
      ),
    );
  }
}
