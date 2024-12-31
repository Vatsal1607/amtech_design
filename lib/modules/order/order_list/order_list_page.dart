import 'package:amtech_design/core/utils/constant.dart';
import 'package:amtech_design/custom_widgets/bottom_blur_on_page.dart';
import 'package:amtech_design/modules/order/order_list/widgets/order_list_status_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/utils/app_colors.dart';
import '../../../custom_widgets/appbar/custom_appbar_with_center_title.dart';

class OrderListPage extends StatelessWidget {
  const OrderListPage({super.key});

  @override
  Widget build(BuildContext context) {
    String accountType = 'business'; // Todo imp set dynamic
    // sharedPrefsService.getString(SharedPrefsKeys.accountType) ?? '';
    return Scaffold(
      backgroundColor: getColorAccountType(
        accountType: accountType,
        businessColor: AppColors.seaShell,
        personalColor: AppColors.seaMist,
      ),
      appBar: CustomAppbarWithCenterTitle(
        accountType: accountType,
        title: 'Orders',
      ),
      body: Stack(
        children: [
          ListView.separated(
            shrinkWrap: true,
            padding: EdgeInsets.only(
                left: 32.w, right: 32.w, top: 16.h, bottom: 40.h),
            itemCount: 6,
            separatorBuilder: (context, index) {
              return SizedBox(height: 16.h);
            },
            itemBuilder: (context, index) {
              return OrderListStatusWidget(
                accountType: accountType,
              );
            },
          ),
          BottomBlurOnPage(
            accountType: accountType,
          ),
          BottomBlurOnPage(
            isTopBlur: true,
            accountType: accountType,
          ),
        ],
      ),
    );
  }
}
