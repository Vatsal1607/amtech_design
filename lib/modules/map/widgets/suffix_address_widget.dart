import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class SuffixAddressWidget extends StatelessWidget {
  final VoidCallback onTap;
  const SuffixAddressWidget({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 10.h,
        width: 70.w,
        margin: EdgeInsets.only(
          right: 15.w,
          top: 10.w,
          bottom: 10.w,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(100.r),
        ),
        child: Center(
          child: Text(
            'CHANGE',
            style: GoogleFonts.publicSans(
              fontSize: 10.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
