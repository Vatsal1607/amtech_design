import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../core/utils/app_colors.dart';

class LegendSection extends StatelessWidget {
  const LegendSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        LegendItem(
          label: 'TOTAL JARS',
          innerColor: AppColors.disabledColor,
          borderColor: Color(0xFF0A1E3F),
        ),
        LegendItem(
          label: 'REMAINING',
          innerColor: Colors.transparent,
          borderColor: Color(0xFF0A1E3F),
        ),
        LegendItem(
          label: 'DELIVERED',
          innerColor: Colors.green,
          borderColor: Color(0xFF0A1E3F),
        ),
        LegendItem(
          label: 'POSTPONED',
          innerColor: Colors.red,
          borderColor: Color(0xFF0A1E3F),
        ),
      ],
    );
  }
}

class LegendItem extends StatelessWidget {
  final String label;
  final Color innerColor;
  final Color borderColor;

  const LegendItem({
    required this.label,
    required this.innerColor,
    required this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 16.w,
          height: 16.h,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: innerColor,
            border: Border.all(color: borderColor, width: 2.w),
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          label,
          style: GoogleFonts.publicSans(
            fontSize: 12.sp,
            color: const Color(0xFF59687C),
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ),
      ],
    );
  }
}
