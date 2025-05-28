import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/constant.dart';
import '../../../custom_widgets/svg_icon.dart';

class ProfileTile extends StatelessWidget {
  final String title;
  final String icon;
  final Color? iconColor;
  final bool isSelected;
  final VoidCallback? onTap;
  final String accountType;
  final Color? titleColor;
  const ProfileTile({
    super.key,
    required this.title,
    required this.icon,
    this.iconColor,
    this.isSelected = false,
    this.onTap,
    required this.accountType,
    this.titleColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 21.w, vertical: 14.h),
        decoration: isSelected
            ? BoxDecoration(
                boxShadow: kDropShadow,
                borderRadius: BorderRadius.circular(30.r),
                color: getColorAccountType(
                  accountType: accountType,
                  businessColor: AppColors.primaryColor,
                  personalColor: AppColors.darkGreenGrey,
                ),
              )
            : const BoxDecoration(color: Colors.transparent),
        child: Row(
          children: [
            SvgIcon(
              icon: icon,
              color: isSelected
                  ? getColorAccountType(
                      accountType: accountType,
                      businessColor: iconColor ?? AppColors.seaShell,
                      personalColor: iconColor ?? AppColors.seaMist,
                    )
                  : getColorAccountType(
                      accountType: accountType,
                      businessColor: iconColor ?? AppColors.disabledColor,
                      personalColor: iconColor ?? AppColors.bayLeaf,
                    ),
            ),
            SizedBox(width: 10.h),
            Text(
              title,
              style: isSelected
                  ? GoogleFonts.publicSans(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w700,
                      color: titleColor ??
                          getColorAccountType(
                            accountType: accountType,
                            businessColor: AppColors.seaShell,
                            personalColor: AppColors.seaMist,
                          ),
                    )
                  : GoogleFonts.publicSans(
                      fontSize: 15.sp,
                      color: titleColor ??
                          getColorAccountType(
                            accountType: accountType,
                            businessColor: AppColors.primaryColor,
                            personalColor: AppColors.darkGreenGrey,
                          ),
                    ),
            )
          ],
        ),
      ),
    );
  }
}
