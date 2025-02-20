import 'package:amtech_design/custom_widgets/buttons/custom_button_with_arrow.dart';
import 'package:amtech_design/custom_widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/constant.dart';
import '../../../core/utils/strings.dart';
import '../../../custom_widgets/svg_icon.dart';

Widget _buildCheckbox(String title) {
  return Row(
    children: [
      Checkbox(
        value: true,
        onChanged: (value) {},
        checkColor: Colors.black,
        activeColor: Colors.white,
      ),
      Text(
        title,
        style: GoogleFonts.publicSans(
          fontSize: 16.sp,
          fontWeight: FontWeight.bold,
          color: AppColors.seaShell,
        ),
      ),
    ],
  );
}

Widget _buildTextField(String hintText) {
  return TextField(
    style: GoogleFonts.publicSans(color: Colors.white),
    decoration: InputDecoration(
      hintText: hintText,
      hintStyle: GoogleFonts.publicSans(color: Colors.white60),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.white),
        borderRadius: BorderRadius.circular(10.r),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
        borderRadius: BorderRadius.circular(10.r),
      ),
    ),
  );
}

void editAddressBottomSheeet({
  required BuildContext context,
  required String accountType,
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
      TextEditingController addressController = TextEditingController();
      TextEditingController floorController = TextEditingController();
      TextEditingController companyController = TextEditingController();
      TextEditingController landmarkController = TextEditingController();
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
                  SizedBox(height: 10.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildCheckbox('HOME'),
                      SizedBox(width: 10.h),
                      _buildCheckbox('WORK'),
                      SizedBox(width: 10.h),
                      _buildCheckbox('OTHER'),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  CustomTextField(
                    controller: addressController,
                    hint:
                        'AMTech Design, E-1102, 11th Floor, Titanium City Center, Satellite, Ahmedabad',
                        
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
                  _buildTextField('Floor *'),
                  SizedBox(height: 15.h),
                  _buildTextField('Company / Building *'),
                  SizedBox(height: 15.h),
                  _buildTextField('Nearby Landmark (Optional)'),
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
