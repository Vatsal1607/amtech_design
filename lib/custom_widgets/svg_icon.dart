import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../core/utils/app_colors.dart';

class SvgIcon extends StatelessWidget {
  final String icon;
  final Color color;
  final double? height;
  final double? width;
  const SvgIcon({
    super.key,
    required this.icon,
    this.color = AppColors.seaShell,
    this.height,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      icon,
      colorFilter: ColorFilter.mode(
        color,
        BlendMode.srcIn, // Use srcIn to apply color
      ),
      fit: BoxFit.scaleDown,
      height: height,
      width: width,
    );
  }
}
