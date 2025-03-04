import 'dart:developer';

import 'package:amtech_design/core/utils/constant.dart';
import 'package:amtech_design/custom_widgets/buttons/small_edit_button.dart';
import 'package:amtech_design/custom_widgets/svg_icon.dart';
import 'package:amtech_design/models/saved_address_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/constants/keys.dart';
import '../../../../../core/utils/strings.dart';
import '../../../../../models/nearby_address_model.dart';
import '../../../../../routes.dart';
import '../../../../../services/local/shared_preferences_service.dart';
import '../saved_address_provider.dart';

class SavedLocationCard extends StatelessWidget {
  final bool isNearBy;
  final SavedAddressList? savedAddress;
  final NearByAddressList? nearByAddress;
  final SavedAddressProvider provider;
  const SavedLocationCard({
    super.key,
    this.isNearBy = false,
    this.savedAddress,
    this.nearByAddress,
    required this.provider,
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
                  SizedBox(
                    width: isNearBy ? 290.w : null,
                    child: Text(
                      isNearBy
                          ? '${nearByAddress?.name}'
                          : '${savedAddress?.addressType}',
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.publicSans(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.seaShell,
                      ),
                    ),
                  ),
                ],
              ),
              //* Edit & Delete buttons
              if (!isNearBy)
                Row(
                  children: [
                    SmallEditButton(
                      onTap: () {
                        log('Edit pressed');
                        //* Navigate to map page
                        Navigator.pushNamed(context, Routes.googleMapPage,
                            arguments: {
                              'editAddressLat': savedAddress?.lat,
                              'editAddressLong': savedAddress?.long,
                            });
                        log('Edit button: lat is ${savedAddress?.lat} long is ${savedAddress?.long}');
                      },
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
                    GestureDetector(
                      onTap: () {
                        log('Delete pressed');
                      },
                      child: Container(
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
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //* Address
                    Text(
                      isNearBy
                          ? '${nearByAddress?.address}'
                          : '${savedAddress?.propertyNumber} ${savedAddress?.residentialAddress} ${savedAddress?.nearLandmark} ${savedAddress?.suggestAddress ?? ''}',
                      style: GoogleFonts.publicSans(
                        fontSize: 12.sp,
                        color: AppColors.seaShell,
                      ),
                    ),
                    SizedBox(height: 5.h),
                    Text(
                      isNearBy
                          ? provider.formatDistance(
                              provider.parseDouble(nearByAddress?.distance))
                          : provider.formatDistance(
                              provider.parseDouble(savedAddress?.distance)),
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
          ),
        ],
      ),
    );
  }
}
