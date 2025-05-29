import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/constant.dart';
import '../../../core/utils/strings.dart';
import '../../../custom_widgets/svg_icon.dart';

class AccountTile extends StatelessWidget {
  final String title;
  final String subTitle;
  final bool isCurrentAccount;
  final String profilePic;
  final VoidCallback? onTap;
  const AccountTile({
    super.key,
    required this.title,
    required this.subTitle,
    this.isCurrentAccount = false,
    required this.profilePic,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Container(
        height: 50.h,
        width: 50.w,
        decoration: BoxDecoration(
          boxShadow: kDropShadow,
          color: Colors.black,
          shape: BoxShape.circle,
          border: Border.all(
            color: AppColors.seaShell,
            width: 2.w,
          ),
        ),
        child: ClipOval(
          child: profilePic != ''
              ? Image.network(
                  profilePic,
                  fit: BoxFit.cover,
                )
              : Image.asset(
                  ImageStrings.defaultAvatar,
                  color: Colors.white,
                ),
        ),
      ),
      title: Text(
        title,
        style: GoogleFonts.publicSans(
          fontSize: 20.sp,
          fontWeight: isCurrentAccount ? FontWeight.bold : null,
          color: AppColors.white,
        ),
      ),
      subtitle: Text(
        subTitle,
        style: GoogleFonts.publicSans(
          fontSize: 12.sp,
          color: AppColors.white,
        ),
      ),
      trailing: SvgIcon(
        icon: isCurrentAccount ? IconStrings.selected : IconStrings.unselected,
        color: AppColors.white,
      ),
    );
  }
}
