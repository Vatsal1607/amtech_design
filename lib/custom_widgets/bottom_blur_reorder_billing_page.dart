import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../core/utils/app_colors.dart';
import '../core/utils/constant.dart';

class BottomBlurReorderAndBillingPage extends StatelessWidget {
  const BottomBlurReorderAndBillingPage({
    super.key,
    required this.accountType,
  });

  final String accountType;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      height: 36.h,
      child: IgnorePointer(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [
                getColorAccountType(
                  accountType: accountType,
                  businessColor: AppColors.seaShell,
                  personalColor: AppColors.seaMist,
                ), // Your background color
                getColorAccountType(
                  accountType: accountType,
                  businessColor: AppColors.seaShell.withOpacity(0),
                  personalColor: AppColors.seaMist.withOpacity(0),
                ), // Fades to transparent
              ],
            ),
          ),
        ),
      ),
    );
  }
}
