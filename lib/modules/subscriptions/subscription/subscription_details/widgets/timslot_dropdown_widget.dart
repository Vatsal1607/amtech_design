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
  const SelectTimeSlotDropdown({
    super.key,
    required this.accountType,
  });

  @override
  Widget build(BuildContext context) {
    final subscriptionDetailsProvider =
        Provider.of<SubscriptionDetailsProvider>(context, listen: true);

    return Consumer<SubscriptionDetailsProvider>(
      builder: (context, _, child) => DropdownButtonHideUnderline(
        child: DropdownButton2<String>(
          value: subscriptionDetailsProvider.selectedTimeSlotValue ??
              subscriptionDetailsProvider.items.first["value"],
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
              borderRadius: subscriptionDetailsProvider.isDropdownOpen
                  ? BorderRadius.zero
                  : BorderRadius.only(
                      bottomLeft: Radius.circular(30.r),
                      bottomRight: Radius.circular(30.r),
                    ),
              boxShadow: [
                BoxShadow(
                  color: getColorAccountType(
                      accountType: accountType,
                      businessColor: AppColors.seaShell.withOpacity(0.4),
                      personalColor:
                          AppColors.seaMist.withOpacity(0.2)), // soft shadow
                  blurRadius: 10,
                  spreadRadius: 2,
                  offset: const Offset(0, 3), // down and slight to right
                ),
              ],
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
              borderRadius: subscriptionDetailsProvider.isDropdownOpen
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
            subscriptionDetailsProvider.setSelectedValue(newValue);
          },
          onMenuStateChange: (isOpen) {
            subscriptionDetailsProvider.setDropdownState(isOpen);
          },
          items: subscriptionDetailsProvider.items.map((item) {
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
