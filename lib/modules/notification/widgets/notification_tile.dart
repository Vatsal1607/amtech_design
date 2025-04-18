import 'package:amtech_design/core/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/utils/app_colors.dart';
import '../../../models/notification_history_model.dart';

class NotificationTile extends StatelessWidget {
  final int readStatus;
  final String accountType;
  final Notifications notification;
  const NotificationTile({
    super.key,
    this.readStatus = 0,
    required this.accountType,
    required this.notification,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${notification.title}',
          style: GoogleFonts.publicSans(
            fontSize: 16.sp,
            fontWeight: readStatus == 0 ? null : FontWeight.bold,
            color: getColorAccountType(
              accountType: accountType,
              businessColor: AppColors.primaryColor,
              personalColor: AppColors.darkGreenGrey,
            ),
          ),
        ),
        Text(
          '${notification.body}',
          style: GoogleFonts.publicSans(
            fontSize: 16.sp,
            fontWeight: readStatus == 0 ? null : FontWeight.bold,
            color: getColorAccountType(
              accountType: accountType,
              businessColor: AppColors.primaryColor,
              personalColor: AppColors.darkGreenGrey,
            ),
          ),
        ),
        SizedBox(height: 10.h),
        Divider(
          height: 1.h,
          color: getColorAccountType(
            accountType: accountType,
            businessColor: AppColors.disabledColor,
            personalColor: AppColors.bayLeaf,
          ),
        ),
      ],
    );
  }
}
