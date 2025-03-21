import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/utils/app_colors.dart';

class CustomSubsDropdown extends StatelessWidget {
  final List<String> items;
  final String? selectedValue;
  final ValueChanged<String?> onChanged;
  final ValueChanged<bool>? onMenuStateChange;
  final bool isDropdownOpen;
  final double? dropdownValueWidth;

  const CustomSubsDropdown({
    super.key,
    required this.items,
    required this.selectedValue,
    required this.onChanged,
    this.onMenuStateChange,
    required this.isDropdownOpen,
    this.dropdownValueWidth,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2<String>(
        value: selectedValue ?? items.first,
        isExpanded: true,
        menuItemStyleData: MenuItemStyleData(
          height: 38.h,
        ),
        dropdownStyleData: DropdownStyleData(
          maxHeight: 200.h,
          padding: EdgeInsets.zero,
          width: dropdownValueWidth,
          decoration: BoxDecoration(
            color: AppColors.seaShell,
            borderRadius: isDropdownOpen
                ? BorderRadius.zero
                : BorderRadius.only(
                    bottomLeft: Radius.circular(30.r),
                    bottomRight: Radius.circular(30.r),
                  ),
          ),
          elevation: 0,
        ),
        buttonStyleData: ButtonStyleData(
          height: 30.h,
          // width: 220.w, // dropdown width
          padding: EdgeInsets.only(right: 20.w, left: 2.w),
          decoration: BoxDecoration(
            color: AppColors.seaShell,
            borderRadius: isDropdownOpen
                ? BorderRadius.only(
                    topLeft: Radius.circular(30.r),
                    topRight: Radius.circular(30.r),
                  )
                : BorderRadius.circular(30.r),
          ),
        ),
        iconStyleData: const IconStyleData(
          icon: Icon(Icons.keyboard_arrow_down, color: AppColors.primaryColor),
        ),
        style: GoogleFonts.publicSans(
          color: Colors.white,
          fontSize: 14.sp,
          fontWeight: FontWeight.bold,
        ),
        onChanged: onChanged,
        onMenuStateChange: onMenuStateChange,
        items: items.map((item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Text(
              item,
              style: GoogleFonts.publicSans(
                color: AppColors.primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
