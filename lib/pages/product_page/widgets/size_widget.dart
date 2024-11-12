import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/utils/app_colors.dart';

class SizeWidget extends StatelessWidget {
  final String text;
  final Color? bgColor;
  final Color? borderColor;
  const SizeWidget({
    super.key,
    required this.text,
    this.bgColor,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.0,
      width: 85.0,
      decoration: BoxDecoration(
        color: bgColor ?? AppColors.primaryColor,
        borderRadius: BorderRadius.circular(100),
        border: Border.all(
          color: borderColor ?? AppColors.primaryColor,
          width: 2,
        ),
      ),
      child: Center(
        child: Text(
          text,
          style: GoogleFonts.publicSans(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.seaShell,
          ),
        ),
      ),
    );
  }
}
