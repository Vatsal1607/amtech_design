import 'dart:developer';
import 'package:amtech_design/core/utils/constants/keys.dart';
import 'package:amtech_design/custom_widgets/buttons/custom_bottomsheet_close_button.dart';
import 'package:amtech_design/custom_widgets/buttons/custom_button_with_arrow.dart';
import 'package:amtech_design/custom_widgets/custom_textfield.dart';
import 'package:amtech_design/modules/map/address/saved_address/saved_address_provider.dart';
import 'package:amtech_design/modules/map/google_map_provider.dart';
import 'package:amtech_design/modules/provider/socket_provider.dart';
import 'package:amtech_design/services/local/shared_preferences_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/constant.dart';
import '../../../core/utils/strings.dart';
import '../../../custom_widgets/svg_icon.dart';
import 'suffix_address_widget.dart';

Widget _buildCheckbox({
  required String title,
  required String accountType,
  required bool value,
  void Function(bool?)? onChanged,
}) {
  return GestureDetector(
    onTap: () => onChanged?.call(!value),
    child: Row(
      children: [
        SvgIcon(
          width: 30,
          height: 30,
          icon: value
              ? IconStrings.checkboxChecked
              : IconStrings.checkboxUnchecked,
          color: getColorAccountType(
            accountType: accountType,
            businessColor: AppColors.disabledColor,
            personalColor: AppColors.bayLeaf,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          title,
          style: GoogleFonts.publicSans(
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
            color: getColorAccountType(
              accountType: accountType,
              businessColor: AppColors.seaShell,
              personalColor: AppColors.seaMist,
            ),
          ),
        ),
      ],
    ),
  );
}

void editAddressBottomSheeet({
  required BuildContext context,
  required String accountType,
  required GoogleMapProvider provider,
  required SocketProvider socketProvider,
  required SavedAddressProvider savedAddressProvider,
}) {
  showModalBottomSheet(
    context: context,
    // isDismissible: false,
    isScrollControlled: true, // Expand fully when keyboard is open
    backgroundColor: getColorAccountType(
      accountType: accountType,
      businessColor: AppColors.primaryColor,
      personalColor: AppColors.darkGreenGrey,
    ),
    builder: (context) {
      return Stack(
        clipBehavior: Clip.none, // Allow visible outside the bounds
        children: [
          Positioned(
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                  top: 19.h,
                  left: 32.w,
                  right: 32.w,
                  //* Adjust bottomsheet while keyboard open
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                width: 1.sw,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        'ADD MORE DETAILS',
                        style: GoogleFonts.publicSans(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: getColorAccountType(
                            accountType: accountType,
                            businessColor: AppColors.seaShell,
                            personalColor: AppColors.seaMist,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      'SAVE ADDRESS AS',
                      style: GoogleFonts.publicSans(
                        fontSize: 16.sp,
                        color: getColorAccountType(
                          accountType: accountType,
                          businessColor: AppColors.disabledColor,
                          personalColor: AppColors.bayLeaf,
                        ),
                      ),
                    ),
                    SizedBox(height: 5.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Consumer<GoogleMapProvider>(
                          builder: (context, provider, child) => _buildCheckbox(
                            accountType: accountType,
                            title: 'HOME',
                            value: provider.isCheckedHome,
                            onChanged: provider.onChangedHome,
                          ),
                        ),
                        SizedBox(width: 10.h),
                        Consumer<GoogleMapProvider>(
                          builder: (context, provider, child) => _buildCheckbox(
                              accountType: accountType,
                              title: 'WORK',
                              value: provider.isCheckedWork,
                              onChanged: provider.onChangedWork),
                        ),
                        SizedBox(width: 10.h),
                        Consumer<GoogleMapProvider>(
                          builder: (context, provider, child) => _buildCheckbox(
                            accountType: accountType,
                            title: 'OTHER',
                            value: provider.isCheckedOther,
                            onChanged: provider.onChangedOther,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.h),
                    CustomTextField(
                      readOnly: true,
                      controller: provider.addressController,
                      hint: '',
                      maxLines: 3,
                      borderRadius: 30.r,
                      suffixWidget: SuffixAddressWidget(
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    SizedBox(height: 5.h),
                    Text(
                      'ADDED BASED ON YOUR MAP PIN YOU SELECTED',
                      style: GoogleFonts.publicSans(
                        color: getColorAccountType(
                          accountType: accountType,
                          businessColor: AppColors.disabledColor,
                          personalColor: AppColors.bayLeaf,
                        ),
                        fontSize: 12.sp,
                      ),
                    ),
                    SizedBox(height: 20.h),
                    CustomTextField(
                      hint: 'Floor *',
                      label: 'Floor *',
                      controller: provider.floorController,
                    ),
                    SizedBox(height: 15.h),
                    CustomTextField(
                      hint: 'Company / Building *',
                      label: 'Company / Building *',
                      controller: provider.companyController,
                    ),
                    SizedBox(height: 15.h),
                    CustomTextField(
                      hint: 'Nearby Landmark (optional)',
                      label: 'Nearby Landmark (optional)',
                      controller: provider.landmarkController,
                    ),
                    SizedBox(height: 20.h),
                    Consumer<GoogleMapProvider>(
                      builder: (context, _, child) => CustomButtonWithArrow(
                        isMargin: false,
                        accountType: accountType,
                        onTap: () async {
                          if (provider.floorController.text.trim().isNotEmpty &&
                              provider.companyController.text
                                  .trim()
                                  .isNotEmpty) {
                            //* API call
                            await provider.editLocation(
                              context: context,
                              socketProvider: socketProvider,
                              savedAddressProvider: savedAddressProvider,
                              fromSubscart: context
                                      .read<GoogleMapProvider>()
                                      .fromSubscart ??
                                  false,
                            );
                            //* Assign confirm distance on select address
                            provider.confirmDistance = provider.distance;
                            final normalizedDistance = context
                                .read<SavedAddressProvider>()
                                .normalizeDistance(provider.confirmDistance);
                            //* Set confirmDistance
                            sharedPrefsService.setString(
                              SharedPrefsKeys.confirmDistance,
                              normalizedDistance.toStringAsFixed(2),
                            );
                          } else {
                            log('textfields is empty');
                          }
                        },
                        text: 'CONFIRM ADDRESS',
                      ),
                    ),
                    SizedBox(height: 40.h),
                  ],
                ),
              ),
            ),
          ),
          const Positioned(
            top: -40,
            right: 0,
            left: 0,
            child: CustomBottomsheetCloseButton(),
          ),
        ],
      );
    },
  );
}
