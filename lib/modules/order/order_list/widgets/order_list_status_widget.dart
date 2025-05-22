import 'package:amtech_design/custom_widgets/buttons/custom_button.dart';
import 'package:amtech_design/modules/order/order_list/order_list_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/constant.dart';
import '../../../../core/utils/enums/enums.dart';
import '../../../../core/utils/strings.dart';
import '../../../../core/utils/utils.dart';
import '../../../../routes.dart';
import '../../order_status/widgets/order_status_icon_widget.dart';
import '../../order_status/widgets/progress_line_widget.dart';

class OrderListStatusWidget extends StatelessWidget {
  final String accountType;
  final String? orderId;
  final String? orderStatus;
  final List<String> itemNames;
  final String? createdAt;
  final String? currentStatus;
  const OrderListStatusWidget({
    super.key,
    required this.accountType,
    this.orderId,
    this.orderStatus,
    required this.itemNames,
    this.createdAt,
    this.currentStatus,
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
              Consumer<OrderListProvider>(
                builder: (context, provider, child) {
                  OrderStatus currentStatusEnum =
                      provider.getOrderStatusFromString(currentStatus);
                  return OrderStatusIconWidget(
                    accountType: accountType,
                    icon: IconStrings.orderStatus1,
                    isActive:
                        currentStatusEnum.index >= OrderStatus.placed.index,
                  );
                },
              ),
              // * Progress line 1
              Consumer<OrderListProvider>(
                builder: (context, provider, child) {
                  OrderStatus currentStatusEnum =
                      provider.getOrderStatusFromString(currentStatus);
                  return ProgressLineWidget(
                    value: currentStatusEnum.index > OrderStatus.prepared.index
                        ? 1.0
                        : 0.0,
                  );
                },
              ),

              // * Status Icon 2 - Prepared
              Consumer<OrderListProvider>(
                builder: (context, provider, child) {
                  OrderStatus currentStatusEnum =
                      provider.getOrderStatusFromString(currentStatus);
                  return OrderStatusIconWidget(
                    accountType: accountType,
                    icon: IconStrings.orderStatus2,
                    isActive:
                        currentStatusEnum.index > OrderStatus.prepared.index,
                  );
                },
              ),
              // * Progress line 2
              Consumer<OrderListProvider>(
                builder: (context, provider, child) {
                  OrderStatus currentStatusEnum =
                      provider.getOrderStatusFromString(currentStatus);
                  return ProgressLineWidget(
                    value: currentStatusEnum.index >=
                            OrderStatus.outForDelivery.index
                        ? 1.0
                        : 0.0,
                  );
                },
              ),
              // * Status Icon 3 - Out For Delivery
              Consumer<OrderListProvider>(
                builder: (context, provider, child) {
                  OrderStatus currentStatusEnum =
                      provider.getOrderStatusFromString(currentStatus);
                  return OrderStatusIconWidget(
                    accountType: accountType,
                    icon: IconStrings.orderStatus3,
                    isActive: currentStatusEnum.index >=
                        OrderStatus.outForDelivery.index,
                  );
                },
              ),
              // * Progress line 3
              Consumer<OrderListProvider>(
                builder: (context, provider, child) {
                  OrderStatus currentStatusEnum =
                      provider.getOrderStatusFromString(currentStatus);
                  return ProgressLineWidget(
                    value:
                        currentStatusEnum.index >= OrderStatus.delivered.index
                            ? 1.0
                            : 0.0,
                  );
                },
              ),
              // * Status Icon 4 - Delivered
              Consumer<OrderListProvider>(
                builder: (context, provider, child) {
                  OrderStatus currentStatusEnum =
                      provider.getOrderStatusFromString(currentStatus);
                  return OrderStatusIconWidget(
                    accountType: accountType,
                    icon: IconStrings.orderStatus4,
                    isActive:
                        currentStatusEnum.index == OrderStatus.delivered.index,
                  );
                },
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Your Order Is $orderStatus",
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
                    Utils.formatTime(createdAt ?? ''),
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
          SizedBox(height: 5.h),
          //* Item names:
          Align(
            alignment: Alignment.centerLeft,
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: itemNames.length > 2
                        ? '${itemNames.take(2).join(", ")} '
                        : '${itemNames.join(", ")} ', // if 2 or less items, just join them
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
                  if (itemNames.length >
                      2) // if more than 2 items, show "& More"
                    TextSpan(
                      text: '& More',
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
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
          SizedBox(height: 10.h),
          CustomButton(
            onTap: () {
              Navigator.pushNamed(
                context,
                Routes.orderStatus,
                arguments: {
                  'orderId': orderId,
                  'isBack': true,
                },
              );
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
