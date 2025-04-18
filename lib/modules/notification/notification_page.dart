import 'package:amtech_design/core/utils/constant.dart';
import 'package:amtech_design/core/utils/strings.dart';
import 'package:amtech_design/custom_widgets/appbar/custom_appbar_with_center_title.dart';
import 'package:amtech_design/custom_widgets/loader/custom_loader.dart';
import 'package:amtech_design/modules/notification/notification_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../core/utils/app_colors.dart';
import '../../core/utils/constants/keys.dart';
import '../../services/local/shared_preferences_service.dart';
import 'widgets/notification_tile.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<NotificationProvider>().notificationHistory(); //* Api call
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String accountType =
        sharedPrefsService.getString(SharedPrefsKeys.accountType) ?? '';
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
      body: Consumer<NotificationProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return Center(
              child: CustomLoader(
                color: getColorAccountType(
                  accountType: accountType,
                  businessColor: AppColors.primaryColor,
                  personalColor: AppColors.darkGreenGrey,
                ),
              ),
            );
          } else if (provider.notificationsList == null ||
              provider.notificationsList!.isEmpty) {
            return Center(
              child: Text(
                "No notifications found",
                style: GoogleFonts.publicSans(
                  fontSize: 20.sp,
                  color: Colors.black,
                ),
              ),
            );
          } else {
            return ListView.separated(
              shrinkWrap: true,
              padding: EdgeInsets.symmetric(
                horizontal: 32.w,
                vertical: 20.h,
              ),
              itemCount: provider.notificationsList!.length,
              separatorBuilder: (context, index) => SizedBox(height: 18.h),
              itemBuilder: (context, index) {
                final notification = provider.notificationsList![index];
                return NotificationTile(
                  //* 0 for READ 1 for UNREAD
                  readStatus: notification.readStatus ?? 0,
                  accountType: accountType,
                  notification: notification,
                );
              },
            );
          }
        },
      ),
    );
  }
}
