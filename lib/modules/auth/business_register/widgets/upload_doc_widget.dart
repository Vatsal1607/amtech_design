import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/strings.dart';
import '../../../../custom_widgets/svg_icon.dart';

class UploadDocWidget extends StatelessWidget {
  final String title;
  final void Function()? onTap;
  final String leadingIcon;
  const UploadDocWidget({
    super.key,
    required this.title,
    this.onTap,
    this.leadingIcon = IconStrings.doc,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 54.h,
        padding: EdgeInsets.symmetric(horizontal: 18.w),
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(100.r),
          border: Border.all(
            color: AppColors.seaShell,
            width: 2.w,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SvgIcon(
                  icon: leadingIcon,
                ),
                SizedBox(width: 12.w),
                Text(
                  title,
                  textAlign: TextAlign.start,
                  style: GoogleFonts.publicSans(
                    fontSize: 14.sp,
                    color: AppColors.white,
                  ),
                ),
              ],
            ),
            const SvgIcon(icon: IconStrings.upload),
          ],
        ),
      ),
    );
  }
}
