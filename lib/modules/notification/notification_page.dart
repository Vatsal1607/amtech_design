import 'package:amtech_design/core/utils/constant.dart';
import 'package:amtech_design/core/utils/strings.dart';
import 'package:amtech_design/custom_widgets/appbar/custom_appbar_with_center_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/utils/app_colors.dart';
import 'widgets/notification_tile.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

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
        title: 'Notifications',
        isAction: true,
        actionIcon: IconStrings.more,
        actionIconColor: getColorAccountType(
          accountType: accountType,
          businessColor: AppColors.primaryColor,
          personalColor: AppColors.darkGreenGrey,
        ),
      ),
      body: ListView.separated(
        padding: EdgeInsets.symmetric(
          horizontal: 32.w,
          vertical: 46.h,
        ),
        itemCount: 10,
        separatorBuilder: (context, index) {
          return SizedBox(height: 18.h);
        },
        itemBuilder: (context, index) {
          return NotificationTile(
            accountType: accountType,
            isOpened: false,
          );
        },
      ),
    );
  }
}
