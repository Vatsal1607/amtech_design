import 'dart:developer';
import 'package:amtech_design/modules/subscriptions/create_subscription_plan/widgets/custom_subs_dropdown.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../../core/utils/app_colors.dart';
import '../create_subscription_plan_provider.dart';

class DaySelectionDropdown extends StatefulWidget {
  const DaySelectionDropdown({super.key});

  @override
  State<DaySelectionDropdown> createState() => _DaySelectionDropdownState();
}

class _DaySelectionDropdownState extends State<DaySelectionDropdown> {
  @override
  Widget build(BuildContext context) {
    final provider =
        Provider.of<CreateSubscriptionPlanProvider>(context, listen: false);
    return Flexible(
      child: Column(
        children: [
          // * Dropdown button using DropdownButton2
          DropdownButtonHideUnderline(
            child: Consumer<CreateSubscriptionPlanProvider>(
              builder: (context, _, child) => DropdownButton2<String>(
                isExpanded: true,
                onChanged: (value) {}, // No selection needed for "Monday"
                onMenuStateChange: provider.onDayDropdownMenuStateChange,
                customButton: Container(
                  width: double.infinity,
                  height: 50.h,
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: provider.isDayDropdownOpen
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
                        "Monday",
                        style: GoogleFonts.publicSans(
                          color: Colors.white,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Icon(Icons.keyboard_arrow_down,
                          color: Colors.white),
                    ],
                  ),
                ),
                dropdownStyleData: DropdownStyleData(
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: provider.isDayDropdownOpen
                        ? BorderRadius.zero
                        : BorderRadius.only(
                            bottomLeft: Radius.circular(30.r),
                            bottomRight: Radius.circular(30.r),
                          ),
                  ),
                ),
                menuItemStyleData: MenuItemStyleData(
                  height: 200.h, // Ensure each menu item has proper height
                ),
                items: [
                  DropdownMenuItem<String>(
                    value: "monday",
                    enabled: false, // Disabling selection
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          // **Time Slot Dropdown
                          Column(
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
                              Consumer<CreateSubscriptionPlanProvider>(
                                builder: (context, _, child) =>
                                    CustomSubsDropdown(
                                  items: provider.timeSlots,
                                  selectedValue: provider.selectedTime,
                                  onChanged: provider.onChangedTimeslot,
                                  onMenuStateChange: provider.onMenuStateChange,
                                  isDropdownOpen:
                                      provider.isTimeslotDropdownOpen,
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: 10.h),

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
                                child: Container(
                                  height: 30.h,
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 6.w),
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
                                      const Icon(Icons.arrow_forward_ios,
                                          color: Colors.black, size: 10),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),

                          const Divider(color: Colors.white, thickness: 0.5),

                          // **Add New Meal Button**
                          Padding(
                            padding: EdgeInsets.all(12.w),
                            child: ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white.withOpacity(0.1),
                                side: const BorderSide(color: Colors.white),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.r)),
                                elevation: 2,
                              ),
                              onPressed: () {
                                log("Add New Meal Button Pressed");
                              },
                              icon: const Icon(Icons.add,
                                  color: Colors.white, size: 16),
                              label: Text(
                                "ADD NEW MEAL",
                                style:
                                    GoogleFonts.publicSans(color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
