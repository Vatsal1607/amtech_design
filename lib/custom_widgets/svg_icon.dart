import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../core/utils/app_colors.dart';

class SvgIcon extends StatelessWidget {
  String icon;
  Color color;
  SvgIcon({
    super.key,
    required this.icon,
    this.color = AppColors.seaShell,
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
    );
  }
}
