import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/utils/app_colors.dart';

class DividerLabel extends StatelessWidget {
  final String label;
  const DividerLabel({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Divider(
            thickness: 2,
            color: AppColors.primaryColor.withOpacity(0.25),
          ),
        ),
        const SizedBox(width: 7),
        Text(
          label,
          style: GoogleFonts.publicSans(
            fontSize: 10.0,
            fontWeight: FontWeight.bold,
            color: AppColors.primaryColor.withOpacity(0.25),
          ),
        ),
        const SizedBox(width: 7),
        Expanded(
          child: Divider(
            thickness: 2,
            color: AppColors.primaryColor.withOpacity(0.25),
          ),
        ),
      ],
    );
  }
}
