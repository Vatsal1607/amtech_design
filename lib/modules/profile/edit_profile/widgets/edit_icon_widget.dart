import 'package:amtech_design/core/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/strings.dart';
import '../../../../custom_widgets/svg_icon.dart';

class EditIconWidget extends StatelessWidget {
  final double height;
  final double width;
  final String accountType;
  const EditIconWidget({
    super.key,
    this.height = 35,
    this.width = 35,
    required this.accountType,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height.h,
      width: width.w,
      decoration: BoxDecoration(
        color: getColorAccountType(
          accountType: accountType,
          businessColor: AppColors.primaryColor,
          personalColor: AppColors.darkGreenGrey,
        ),
        shape: BoxShape.circle,
      ),
      child: SvgIcon(
        icon: IconStrings.edit,
        color: getColorAccountType(
          accountType: accountType,
          businessColor: AppColors.seaShell,
          personalColor: AppColors.seaMist,
        ),
      ),
    );
  }
}
