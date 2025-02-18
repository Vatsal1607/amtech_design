import 'package:amtech_design/core/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../custom_widgets/svg_icon.dart';

class OrderStatusIconWidget extends StatelessWidget {
  final String icon;
  final bool isActive;
  final String accountType;
  const OrderStatusIconWidget({
    super.key,
    required this.icon,
    this.isActive = false,
    required this.accountType,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35.h,
      width: 35.w,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isActive
            ? getColorAccountType(
                accountType: accountType,
                businessColor: AppColors.primaryColor,
                personalColor: AppColors.darkGreenGrey,
              )
            : getColorAccountType(
                accountType: accountType,
                businessColor: AppColors.disabledBg,
                personalColor: AppColors.darkGreenGrey.withOpacity(.5),
              ),
      ),
      child: SvgIcon(
        icon: icon,
        color: isActive
            ? getColorAccountType(
                accountType: accountType,
                businessColor: AppColors.seaShell,
                personalColor: AppColors.seaMist,
              )
            : getColorAccountType(
                accountType: accountType,
                businessColor: AppColors.disabledColor,
                personalColor: AppColors.seaMist,
              ),
      ),
    );
  }
}
