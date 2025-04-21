import 'package:amtech_design/core/utils/app_colors.dart';
import 'package:amtech_design/core/utils/constant.dart';
import 'package:amtech_design/modules/subscriptions/subscription/subscription_details/subscription_details_provider.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SelectTimeSlotDropdown extends StatelessWidget {
  final String accountType;
  const SelectTimeSlotDropdown({super.key, required this.accountType});

  @override
  Widget build(BuildContext context) {
    final createSubsPlanProvider =
        Provider.of<SubscriptionDetailsProvider>(context, listen: true);

    return Consumer<SubscriptionDetailsProvider>(
      builder: (context, _, child) => DropdownButtonHideUnderline(
        child: DropdownButton2<String>(
          value: createSubsPlanProvider.selectedValue ??
              createSubsPlanProvider.items.first["value"],
          isExpanded: true,
          menuItemStyleData: MenuItemStyleData(
            height: 40.h,
          ),
          dropdownStyleData: DropdownStyleData(
            maxHeight: 200.h,
            width: 220.w,
            decoration: BoxDecoration(
              color: getColorAccountType(
                accountType: accountType,
                businessColor: AppColors.primaryColor,
                personalColor: AppColors.darkGreenGrey,
              ),
              borderRadius: createSubsPlanProvider.isDropdownOpen
                  ? BorderRadius.zero
                  : BorderRadius.only(
                      bottomLeft: Radius.circular(30.r),
                      bottomRight: Radius.circular(30.r),
                    ),
            ),
            elevation: 0,
          ),
          buttonStyleData: ButtonStyleData(
            height: 50.h,
            width: 220.w,
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            decoration: BoxDecoration(
              color: getColorAccountType(
                accountType: accountType,
                businessColor: AppColors.primaryColor,
                personalColor: AppColors.darkGreenGrey,
              ),
              borderRadius: createSubsPlanProvider.isDropdownOpen
                  ? BorderRadius.only(
                      topLeft: Radius.circular(30.r),
                      topRight: Radius.circular(30.r),
                    )
                  : BorderRadius.circular(30.r),
            ),
          ),
          iconStyleData: const IconStyleData(
            icon: Icon(Icons.keyboard_arrow_down, color: Colors.white),
          ),
          style: GoogleFonts.publicSans(color: Colors.white, fontSize: 16.sp),
          onChanged: (String? newValue) {
            createSubsPlanProvider.setSelectedValue(newValue);
          },
          onMenuStateChange: (isOpen) {
            createSubsPlanProvider.setDropdownState(isOpen);
          },
          items: createSubsPlanProvider.items.map((item) {
            return DropdownMenuItem<String>(
              value: item["value"],
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 8.h),
                child: Text(
                  item["label"]!,
                  style: GoogleFonts.publicSans(color: Colors.white),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
