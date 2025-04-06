import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/constant.dart';

class SelectedTimeAndItemWidget extends StatelessWidget {
  final String selectedTime;
  final String selectedItem;
  final String accountType;
  const SelectedTimeAndItemWidget({
    super.key,
    required this.selectedTime,
    required this.selectedItem,
    required this.accountType,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          selectedTime,
          style: GoogleFonts.publicSans(
            fontSize: 14.sp,
            color: getColorAccountType(
              accountType: accountType,
              businessColor: AppColors.disabledColor,
              personalColor: AppColors.bayLeaf,
            ),
          ),
        ),
        SizedBox(width: 4.w),
        SizedBox(
          width: 150.w,
          child: Text(
            selectedItem,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.publicSans(
              fontSize: 14.sp,
              color: getColorAccountType(
                accountType: accountType,
                businessColor: AppColors.disabledColor,
                personalColor: AppColors.bayLeaf,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
