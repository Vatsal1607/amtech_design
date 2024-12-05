import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/utils/app_colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  TextStyle? titleStyle;
  final String? subTitle;
  final Color? backgroundColor;
  final Widget? leading;
  final VoidCallback? onTapLeading;
  final List<Widget>? actions;
  final bool centerTitle;

  CustomAppBar({
    Key? key,
    required this.title,
    this.titleStyle,
    this.subTitle,
    this.backgroundColor,
    this.leading,
    this.onTapLeading,
    this.actions,
    this.centerTitle = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor,
      elevation: 0,
      title: Column(
        children: [
          Text(
            title,
            style: titleStyle ??
                GoogleFonts.publicSans(
                  color: AppColors.primaryColor,
                  fontSize: 15,
                ),
          ),
          if (subTitle != null)
            Text(
              subTitle!,
              style: GoogleFonts.publicSans(
                color: AppColors.primaryColor,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
        ],
      ),
      centerTitle: centerTitle,
      leading: GestureDetector(
        onTap: onTapLeading,
        child: Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: leading,
        ),
      ),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
