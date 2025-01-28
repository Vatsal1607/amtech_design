import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/utils/app_colors.dart';

class CustomLoader extends StatelessWidget {
  final Color color;
  final Color? backgroundColor;
  const CustomLoader({
    super.key,
    this.color = AppColors.seaShell,
    this.backgroundColor = AppColors.seaShell,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 25.h,
      width: 25.h,
      child: CircularProgressIndicator.adaptive(
        valueColor: AlwaysStoppedAnimation<Color>(color),
        backgroundColor: backgroundColor,
      ),
    );
  }
}
