import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/utils/app_colors.dart';
import '../../core/utils/strings.dart';
import '../svg_icon.dart';

class CustomBottomsheetCloseButton extends StatelessWidget {
  const CustomBottomsheetCloseButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: true,
      child: GestureDetector(
        onTap: () {
          Navigator.pop(context);
          debugPrint('Close pressed');
        },
        child: Container(
          height: 30.h,
          width: 30.w,
          decoration: const BoxDecoration(
            color: AppColors.red,
            shape: BoxShape.circle,
          ),
          child: const SvgIcon(
            icon: IconStrings.close,
          ),
        ),
      ),
    );
  }
}
