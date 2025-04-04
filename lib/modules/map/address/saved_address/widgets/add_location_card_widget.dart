import 'package:amtech_design/custom_widgets/svg_icon.dart';
import 'package:amtech_design/modules/map/google_map_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/strings.dart';
import '../../../../../routes.dart';

class AddLocationCard extends StatelessWidget {
  const AddLocationCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.circular(30.r),
      ),
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //* Add new location
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(
                context,
                Routes.googleMapPage,
                arguments: null,
              );
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 5.h),
              color: Colors.transparent,
              child: Row(
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
              ),
            ),
          ),
          SizedBox(height: 5.h),
          const Divider(
            color: AppColors.disabledColor,
            thickness: 1,
          ),
          SizedBox(height: 15.h),

          //* Use your current location
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, Routes.googleMapPage);
            },
            child: Row(
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
                        style: GoogleFonts.publicSans(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Consumer<GoogleMapProvider>(
                        builder: (context, googleMapProvider, child) {
                          return Text(
                            '${googleMapProvider.address}',
                            style: GoogleFonts.publicSans(
                              fontSize: 12.sp,
                              color: Colors.grey,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
