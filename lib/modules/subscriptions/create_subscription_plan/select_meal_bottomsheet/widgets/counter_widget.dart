import 'package:amtech_design/custom_widgets/svg_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/constant.dart';
import '../../../../../core/utils/strings.dart';

class CustomCounterWidget extends StatelessWidget {
  final VoidCallback? onTapDecrease;
  final VoidCallback? onTapIncrease;
  final String? quantity;
  final Color textColor;
  final Color bgColor;
  final double height;
  final String accountType;
  const CustomCounterWidget({
    super.key,
    this.onTapDecrease,
    this.onTapIncrease,
    this.quantity,
    this.textColor = AppColors.primaryColor,
    this.bgColor = AppColors.seaShell,
    this.height = 25,
    required this.accountType,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 90.w,
      height: height.h,
      decoration: BoxDecoration(
        border: Border.all(
          color: getColorAccountType(
            accountType: accountType,
            businessColor: AppColors.primaryColor,
            personalColor: AppColors.darkGreenGrey,
          ),
        ),
        color: bgColor,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: GestureDetector(
              onTap: onTapDecrease,
              child: Container(
                height: 20.h,
                color: Colors.transparent,
                child: SvgIcon(
                  icon: IconStrings.minus,
                  color: textColor,
                ),
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: Text(
                '$quantity',
                style: GoogleFonts.publicSans(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: onTapIncrease,
              child: Container(
                height: 20.h,
                color: Colors.transparent,
                child: SvgIcon(
                  icon: IconStrings.plus,
                  color: textColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
