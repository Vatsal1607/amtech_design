import 'dart:developer';
import 'package:amtech_design/core/utils/constants/keys.dart';
import 'package:amtech_design/core/utils/strings.dart';
import 'package:amtech_design/modules/subscriptions/create_subscription_plan/select_meal_bottomsheet/select_meal_bottomsheet.dart';
import 'package:amtech_design/custom_widgets/svg_icon.dart';
import 'package:amtech_design/modules/subscriptions/create_subscription_plan/widgets/custom_button_with_icon.dart';
import 'package:amtech_design/modules/subscriptions/create_subscription_plan/widgets/custom_subs_dropdown.dart';
import 'package:amtech_design/services/local/shared_preferences_service.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../../core/utils/app_colors.dart';
import '../create_subscription_plan_provider.dart';

class DaySelectionDropdown extends StatelessWidget {
  final String day;
  const DaySelectionDropdown({
    super.key,
    required this.day,
  });

  @override
  Widget build(BuildContext context) {
    final provider =
        Provider.of<CreateSubscriptionPlanProvider>(context, listen: true);
    final String accountType =
        sharedPrefsService.getString(SharedPrefsKeys.accountType) ?? '';
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // * Dropdown button using DropdownButton2
        DropdownButtonHideUnderline(
          child: DropdownButton2<String>(
            isExpanded: true,
            onChanged: (value) {}, // No selection needed for "day"
            onMenuStateChange: (isOpen) {
              provider.onDayDropdownMenuStateChange(day, isOpen);
            },
            customButton: Container(
              width: double.infinity,
              height: 50.h,
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: provider.isDayDropdownOpen[day] ?? false
                    ? BorderRadius.only(
                        topLeft: Radius.circular(30.r),
                        topRight: Radius.circular(30.r),
                      )
                    : BorderRadius.circular(30.r),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    day,
                    style: GoogleFonts.publicSans(
                      color: Colors.white,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Icon(Icons.keyboard_arrow_down, color: Colors.white),
                ],
              ),
            ),
            dropdownStyleData: DropdownStyleData(
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: provider.isDayDropdownOpen[day] ?? false
                    ? BorderRadius.zero
                    : BorderRadius.only(
                        bottomLeft: Radius.circular(30.r),
                        bottomRight: Radius.circular(30.r),
                      ),
              ),
            ),
            menuItemStyleData: MenuItemStyleData(
              height: 180.h, // Ensure each menu item has proper height
            ),
            items: [
              DropdownMenuItem<String>(
                value: 'Monday',
                enabled: false, // Disabling selection
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // **Time Slot Dropdown
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Select Time Slot',
                            style: GoogleFonts.publicSans(
                              color: AppColors.disabledColor,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8.h),

                          // * Custom Subscription Dropdown
                          Consumer<CreateSubscriptionPlanProvider>(
                            builder: (context, _, child) => CustomSubsDropdown(
                              items: provider.timeSlots,
                              selectedValue: provider.selectedTimeslots[day],
                              onChanged: (value) {
                                provider.onChangedTimeslot(day, value);
                              },
                              onMenuStateChange: (isOpen) {
                                provider.onMenuStateChange(day, isOpen);
                              },
                              isDropdownOpen:
                                  provider.isTimeslotDropdownOpen[day] ?? false,
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 20.h),

                      // **Meal Selection (Non-Selectable)**
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Select Meal",
                            style: GoogleFonts.publicSans(
                              color: AppColors.disabledColor,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 25.w),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                // * Show Select Meal BottomSheet
                                showSelectMealBottomSheeet(
                                  context: context,
                                  accountType: accountType,
                                );
                              },
                              child: Container(
                                height: 30.h,
                                padding: EdgeInsets.symmetric(horizontal: 6.w),
                                decoration: BoxDecoration(
                                  color: AppColors.seaShell,
                                  borderRadius: BorderRadius.circular(30.r),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Exotic Fruit Salad',
                                      style: GoogleFonts.publicSans(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14.sp),
                                    ),
                                    SvgIcon(
                                      icon: IconStrings.arrowNext,
                                      color: AppColors.primaryColor,
                                      height: 12.h,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                      const Divider(color: Colors.white, thickness: 1),
                      SizedBox(height: 10.h),
                      // * Add New Meal Button
                      Align(
                        alignment: Alignment.centerLeft,
                        child: CustomButtonWithIcon(
                          labelText: "ADD NEW MEAL",
                          onPressed: () {
                            log("Add New Meal Button Pressed");
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
