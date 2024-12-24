import 'package:amtech_design/core/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/utils/app_colors.dart';
import '../../core/utils/strings.dart';
import '../svg_icon.dart';

class CustomAppbarWithCenterTitle extends StatelessWidget
    implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onBackButtonPressed;
  final Color? backgroundColor;
  final bool isAction;
  final VoidCallback? onTapAction;
  final double? leftPadTitle;
  final String actionIcon;
  final Color actionIconColor;
  final String accountType;
  const CustomAppbarWithCenterTitle({
    super.key,
    required this.title,
    this.onBackButtonPressed,
    this.backgroundColor = AppColors.seaShell,
    this.isAction = false,
    this.onTapAction,
    this.leftPadTitle = 0.0,
    this.actionIcon = IconStrings.info,
    this.actionIconColor = AppColors.disabledColor,
    required this.accountType,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      forceMaterialTransparency: true, // * disable color change on scroll
      elevation: 0.0,
      backgroundColor: backgroundColor,
      automaticallyImplyLeading: false,
      title: Stack(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: GestureDetector(
              onTap: onBackButtonPressed ?? () => Navigator.pop(context),
              child: Container(
                height: 48.h,
                width: 48.w,
                margin: EdgeInsets.only(left: 20.w),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: getColorAccountType(
                    accountType: accountType,
                    businessColor: AppColors.primaryColor,
                    personalColor: AppColors.darkGreenGrey,
                  ),
                ),
                child: SvgIcon(
                  icon: IconStrings.arrowBack,
                  color: getColorAccountType(
                    accountType: accountType,
                    businessColor: AppColors.seaShell,
                    personalColor: AppColors.seaMist,
                  ),
                ),
              ),
            ),
          ),
          Positioned.fill(
            left: leftPadTitle,
            child: Align(
              alignment: Alignment.center,
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: GoogleFonts.publicSans(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w700,
                  color: getColorAccountType(
                    accountType: accountType,
                    businessColor: AppColors.primaryColor,
                    personalColor: AppColors.darkGreenGrey,
                  ),
                ),
              ),
            ),
          ),
          if (isAction)
            Positioned.fill(
              right: 15.w,
              child: GestureDetector(
                onTap: onTapAction,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: SvgIcon(
                    icon: actionIcon,
                    color: actionIconColor,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
