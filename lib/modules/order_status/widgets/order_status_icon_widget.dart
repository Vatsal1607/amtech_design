import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/utils/app_colors.dart';
import '../../../custom_widgets/svg_icon.dart';

class OrderStatusIconWidget extends StatelessWidget {
  final String icon;
  final bool isActive;
  const OrderStatusIconWidget({
    super.key,
    required this.icon,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35.h,
      width: 35.w,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isActive ? AppColors.primaryColor : AppColors.disabledBg,
      ),
      child: SvgIcon(
        icon: icon,
        color: isActive ? AppColors.seaShell : AppColors.disabledColor,
      ),
    );
  }
}
