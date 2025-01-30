import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/utils/app_colors.dart';

class CustomLoader extends StatelessWidget {
  final Color color;
  final Color? backgroundColor;
  final double height;
  final double width;
  const CustomLoader({
    super.key,
    this.color = AppColors.seaShell,
    this.backgroundColor = AppColors.seaShell,
    this.height = 25,
    this.width = 25,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height.h,
      width: width.w,
      child: CircularProgressIndicator.adaptive(
        valueColor: AlwaysStoppedAnimation<Color>(color),
        backgroundColor: backgroundColor,
      ),
    );
  }
}
