import 'package:amtech_design/custom_widgets/buttons/custom_button_with_arrow.dart';
import 'package:amtech_design/custom_widgets/custom_textfield.dart';
import 'package:amtech_design/modules/map/google_map_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/constant.dart';
import '../../../core/utils/strings.dart';
import '../../../custom_widgets/svg_icon.dart';

// OLD
// Widget _buildCheckbox({
//   required String title,
//   required bool value,
//   void Function(bool?)? onChanged,
// }) {
//   return Row(
//     children: [
//       Checkbox(
//         value: value,
//         onChanged: onChanged,
//         checkColor: Colors.black,
//         activeColor: AppColors.disabledColor,
//       ),
//       Text(
//         title,
//         style: GoogleFonts.publicSans(
//           fontSize: 16.sp,
//           fontWeight: FontWeight.bold,
//           color: AppColors.seaShell,
//         ),
//       ),
//     ],
//   );
// }

Widget _buildCheckbox({
  required String title,
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
          color: AppColors.disabledColor,
        ),
        const SizedBox(width: 8),
        Text(
          title,
          style: GoogleFonts.publicSans(
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.seaShell,
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
      // TextEditingController addressController = TextEditingController();
      // TextEditingController floorController = TextEditingController();
      // TextEditingController companyController = TextEditingController();
      // TextEditingController landmarkController = TextEditingController();
      return Stack(
        clipBehavior: Clip.none, // Allow visible outside the bounds
        children: [
          Positioned(
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
                      color: AppColors.disabledColor,
                    ),
                  ),
                  SizedBox(height: 5.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Consumer<GoogleMapProvider>(
                        builder: (context, provider, child) => _buildCheckbox(
                          title: 'HOME',
                          value: provider.isCheckedHome,
                          onChanged: provider.onChangedHome,
                        ),
                      ),
                      SizedBox(width: 10.h),
                      Consumer<GoogleMapProvider>(
                        builder: (context, provider, child) => _buildCheckbox(
                            title: 'WORK',
                            value: provider.isCheckedWork,
                            onChanged: provider.onChangedWork),
                      ),
                      SizedBox(width: 10.h),
                      Consumer<GoogleMapProvider>(
                        builder: (context, provider, child) => _buildCheckbox(
                          title: 'OTHER',
                          value: provider.isCheckedOther,
                          onChanged: provider.onChangedOther,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  CustomTextField(
                    controller: provider.addressController,
                    hint:
                        'AMTech Design, E-1102, 11th Floor, Titanium City Center, Satellite, Ahmedabad',
                    maxLines: 3,
                  ),
                  SizedBox(height: 5.h),
                  Text(
                    'ADDED BASED ON YOUR MAP PIN YOU SELECTED',
                    style: GoogleFonts.publicSans(
                      color: AppColors.disabledColor,
                      fontSize: 12.sp,
                    ),
                  ),
                  SizedBox(height: 20.h),
                  CustomTextField(
                    hint: 'Floor *',
                    controller: provider.floorController,
                  ),
                  SizedBox(height: 15.h),
                  CustomTextField(
                    hint: 'Company / Building *',
                    controller: provider.companyController,
                  ),
                  SizedBox(height: 15.h),
                  CustomTextField(
                    hint: 'Nearby Landmark (optional)',
                    controller: provider.landmarkController,
                  ),
                  SizedBox(height: 20.h),
                  CustomButtonWithArrow(
                    isMargin: false,
                    accountType: accountType,
                    onTap: () {},
                    text: 'CONFIRM ADDRESS',
                  ),
                  SizedBox(height: 40.h),
                ],
              ),
            ),
          ),
          // Todo Create custom widget
          Positioned(
            top: -40,
            right: 0,
            left: 0,
            child: IgnorePointer(
              ignoring: true,
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  debugPrint('Close pressed');
                },
                child: Container(
                  height: 30.h,
                  width: 30.w,
                  decoration: const BoxDecoration(
                    color: AppColors.red,
                    shape: BoxShape.circle,
                  ),
                  child: const SvgIcon(
                    icon: IconStrings.close,
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    },
  );
}
