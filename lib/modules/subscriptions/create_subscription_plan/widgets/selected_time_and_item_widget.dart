import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/utils/app_colors.dart';

class SelectedTimeAndItemWidget extends StatelessWidget {
  final String selectedTime;
  final String selectedItem;
  const SelectedTimeAndItemWidget({
    super.key,
    required this.selectedTime,
    required this.selectedItem,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(
          selectedTime,
          style: GoogleFonts.publicSans(
            fontSize: 15.sp,
            color: AppColors.disabledColor,
          ),
        ),
        Text(
          selectedItem,
          style: GoogleFonts.publicSans(
            fontSize: 15.sp,
            color: AppColors.disabledColor,
          ),
        ),
      ],
    );
  }
}
