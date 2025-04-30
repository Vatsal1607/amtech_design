import 'package:amtech_design/core/utils/constant.dart';
import 'package:amtech_design/core/utils/enums/enums.dart';
import 'package:amtech_design/modules/order/order_status/order_status_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
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
              // * Status Icon 1 - Placed or Confirmed
              Consumer<OrderStatusProvider>(
                builder: (context, provider, child) => OrderStatusIconWidget(
                  accountType: accountType,
                  icon: IconStrings.orderStatus1,
                  isActive: provider.orderStatusEnum.index >=
                      OrderStatus.placed.index,
                ),
              ),
              // * Progress line 1
              Consumer<OrderStatusProvider>(
                builder: (context, provider, child) => ProgressLineWidget(
                  value: provider.orderStatusEnum.index >=
                          OrderStatus.prepared.index
                      ? 1.0
                      : 0.0,
                ),
              ),

              // * Status Icon 2 - Prepared
              Consumer<OrderStatusProvider>(
                builder: (context, provider, child) => OrderStatusIconWidget(
                  accountType: accountType,
                  icon: IconStrings.orderStatus2,
                  isActive: provider.orderStatusEnum.index >=
                      OrderStatus.prepared.index,
                ),
              ),

              // * Progress line 2
              Consumer<OrderStatusProvider>(
                builder: (context, provider, child) => ProgressLineWidget(
                  value: provider.orderStatusEnum.index >=
                          OrderStatus.outForDelivery.index
                      ? 1.0
                      : 0.0,
                ),
              ),

              // * Status Icon 3 - Out For Delivery
              Consumer<OrderStatusProvider>(
                builder: (context, provider, child) => OrderStatusIconWidget(
                  accountType: accountType,
                  icon: IconStrings.orderStatus3,
                  isActive: provider.orderStatusEnum.index >=
                      OrderStatus.outForDelivery.index,
                ),
              ),

              // * Progress line 3
              Consumer<OrderStatusProvider>(
                builder: (context, provider, child) => ProgressLineWidget(
                  value: provider.orderStatusEnum.index >=
                          OrderStatus.delivered.index
                      ? 1.0
                      : 0.0,
                ),
              ),

              // * Status Icon 4 - Delivered
              Consumer<OrderStatusProvider>(
                builder: (context, provider, child) => OrderStatusIconWidget(
                  accountType: accountType,
                  icon: IconStrings.orderStatus4,
                  isActive: provider.orderStatusEnum.index ==
                      OrderStatus.delivered.index,
                ),
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
            child: Consumer<OrderStatusProvider>(
              builder: (context, provider, child) => Text(
                // "Placed Successfully!",
                provider.getOrderStatusText(
                    accountType, provider.orderStatusEnum),
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
          Consumer<OrderStatusProvider>(
            builder: (context, provider, child) => Theme(
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
                children: provider.orderResponse?.items.map((item) {
                      final itemName = item.itemName;
                      final quantity = item.quantity;
                      return Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.w, vertical: 4.h),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            '$quantity x $itemName',
                            style: GoogleFonts.publicSans(
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      );
                    }).toList() ??
                    [],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
