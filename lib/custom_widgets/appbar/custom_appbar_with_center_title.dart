import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/utils/app_colors.dart';
import '../../core/utils/strings.dart';
import '../svg_icon.dart';

class CustomAppbarWithCenterTitle extends StatelessWidget
    implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onBackButtonPressed;
  final Color? backgroundColor;
  final bool isAction;

  const CustomAppbarWithCenterTitle({
    super.key,
    required this.title,
    this.onBackButtonPressed,
    this.backgroundColor = AppColors.seaShell,
    this.isAction = false,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor,
      automaticallyImplyLeading: false,
      title: Stack(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: GestureDetector(
              onTap: onBackButtonPressed ?? () => Navigator.pop(context),
              child: Container(
                height: 48.h,
                width: 48.w,
                margin: EdgeInsets.only(left: 20.w),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primaryColor,
                ),
                child: SvgIcon(icon: IconStrings.arrowBack),
              ),
            ),
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.center,
              child: Text(
                title,
                style: GoogleFonts.publicSans(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primaryColor,
                ),
              ),
            ),
          ),
          if (isAction)
            Positioned.fill(
              child: Align(
                alignment: Alignment.centerRight,
                child: SvgIcon(
                  icon: IconStrings.info,
                  color: AppColors.disabledColor,
                ),
              ),
            ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
