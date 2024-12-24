import 'package:amtech_design/core/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/utils/app_colors.dart';

class NotificationTile extends StatelessWidget {
  final bool isOpened;
  final String accountType;
  const NotificationTile({
    super.key,
    this.isOpened = false,
    required this.accountType,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          isOpened ? 'Opened Notification Title' : 'Unread Notification Title',
          style: GoogleFonts.publicSans(
            fontSize: 16.sp,
            fontWeight: isOpened ? null : FontWeight.bold,
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
