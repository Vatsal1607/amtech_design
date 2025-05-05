import 'package:amtech_design/core/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/constants/keys.dart';
import '../../../../services/local/shared_preferences_service.dart';

class ProgressLineWidget extends StatelessWidget {
  final double? value;
  const ProgressLineWidget({
    super.key,
    this.value,
  });

  @override
  Widget build(BuildContext context) {
    final String accountType =
        sharedPrefsService.getString(SharedPrefsKeys.accountType) ?? '';
    return Expanded(
      child: Container(
        height: 5.h,
        margin: EdgeInsets.symmetric(horizontal: 5.w),
        child: LinearProgressIndicator(
          value: value,
          backgroundColor: AppColors.primaryColor.withOpacity(.3),
          valueColor: AlwaysStoppedAnimation<Color>(
            getColorAccountType(
              accountType: accountType,
              businessColor: AppColors.primaryColor,
              personalColor: AppColors.darkGreenGrey,
            ),
          ),
        ),
      ),
    );
  }
}
