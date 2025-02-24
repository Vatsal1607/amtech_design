import 'package:amtech_design/custom_widgets/svg_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/strings.dart';

class AddLocationCard extends StatelessWidget {
  const AddLocationCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.circular(30.r),
      ),
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildAddNewLocationRow(),
          const Divider(color: Colors.grey, thickness: 0.5),
          _buildCurrentLocationRow(),
        ],
      ),
    );
  }

  Widget _buildAddNewLocationRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            const SvgIcon(
              icon: IconStrings.addLocation,
              color: AppColors.disabledColor,
            ),
            SizedBox(width: 10.w),
            Text(
              "Add New Location",
              style: GoogleFonts.publicSans(
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.seaShell,
              ),
            ),
          ],
        ),
        const Icon(Icons.arrow_forward_ios,
            color: Colors.white, size: 18), // Arrow Icon
      ],
    );
  }

  Widget _buildCurrentLocationRow() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SvgIcon(
          icon: IconStrings.useCurrentLocation,
          color: AppColors.disabledColor,
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Use Your Current Location",
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                "AMTech Design, E-1102, 11th Floor, Titanium City Center, Satellite, Ahmedabad",
                style: GoogleFonts.publicSans(
                  fontSize: 14.sp,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

//   Widget _buildIcon(IconData icon, Color? color) {
//     return Container(
//       padding: EdgeInsets.all(6.w),
//       decoration: const BoxDecoration(
//         shape: BoxShape.circle,
//         color: AppColors.disabledColor,
//       ),
//       child: Icon(icon, color: color, size: 18.w),
//     );
//   }
}
