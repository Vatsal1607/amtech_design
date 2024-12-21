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
    return Scaffold(
      appBar: const CustomAppbarWithCenterTitle(
        title: 'Notifications',
        isAction: true,
        actionIcon: IconStrings.more,
        actionIconColor: AppColors.primaryColor,
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
          return const NotificationTile(
            isOpened: false,
          );
        },
      ),
    );
  }
}
