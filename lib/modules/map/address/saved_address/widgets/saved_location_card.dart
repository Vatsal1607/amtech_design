import 'package:amtech_design/core/utils/constant.dart';
import 'package:amtech_design/custom_widgets/buttons/small_edit_button.dart';
import 'package:amtech_design/custom_widgets/svg_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/constants/keys.dart';
import '../../../../../core/utils/strings.dart';
import '../../../../../services/local/shared_preferences_service.dart';

class SavedLocationCard extends StatelessWidget {
  final bool isNearBy;
  const SavedLocationCard({
    super.key,
    this.isNearBy = false,
  });

  @override
  Widget build(BuildContext context) {
    final String accountType =
        sharedPrefsService.getString(SharedPrefsKeys.accountType) ?? '';
    return Container(
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.circular(30.r),
      ),
      padding: EdgeInsets.all(20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SvgIcon(
                    icon: isNearBy
                        ? IconStrings.locationMarker
                        : IconStrings.business,
                    color: AppColors.disabledColor,
                  ),
                  SizedBox(width: 10.w),
                  Text(
                    isNearBy ? 'Titanium City Cener' : "Work",
                    style: GoogleFonts.publicSans(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.seaShell,
                    ),
                  ),
                ],
              ),
              //* Edit & Delete buttons
              if (!isNearBy)
                Row(
                  children: [
                    SmallEditButton(
                      accountType: accountType,
                      width: 64.h,
                      height: 26.h,
                      textColor: getColorAccountType(
                        accountType: accountType,
                        businessColor: AppColors.primaryColor,
                        personalColor: AppColors.darkGreenGrey,
                      ),
                      bgColor: getColorAccountType(
                        accountType: accountType,
                        businessColor: AppColors.seaShell,
                        personalColor: AppColors.seaMist,
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Container(
                      width: 28.w,
                      height: 28.h,
                      decoration: const BoxDecoration(
                        color: AppColors.red,
                        shape: BoxShape.circle,
                      ),
                      child: SvgIcon(
                        height: 25.h,
                        width: 25.w,
                        icon: IconStrings.delete,
                        // fit: BoxFit.contain,
                      ),
                    ),
                  ],
                ),
            ],
          ),
          SizedBox(height: 15.h),
          const Divider(
            color: AppColors.disabledColor,
            thickness: 1,
          ),
          SizedBox(height: 15.h),
          _buildCurrentLocationRow(),
        ],
      ),
    );
  }

  Widget _buildCurrentLocationRow() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "AMTech Design, E-1102, 11th Floor, Titanium City Center, Satellite, Ahmedabad",
                style: GoogleFonts.publicSans(
                  fontSize: 12.sp,
                  color: AppColors.seaShell,
                ),
              ),
              SizedBox(height: 5.h),
              Text(
                "85 m away",
                style: GoogleFonts.publicSans(
                  color: AppColors.disabledColor,
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
