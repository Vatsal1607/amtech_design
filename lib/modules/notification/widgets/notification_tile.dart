import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/utils/app_colors.dart';

class NotificationTile extends StatelessWidget {
  final bool isOpened;
  const NotificationTile({
    super.key,
    this.isOpened = false,
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
            color: AppColors.primaryColor,
          ),
        ),
        SizedBox(height: 10.h),
        Divider(
          height: 1.h,
          color: AppColors.disabledColor,
        ),
      ],
    );
  }
}
