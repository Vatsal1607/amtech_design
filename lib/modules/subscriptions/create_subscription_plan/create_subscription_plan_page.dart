import 'package:amtech_design/core/utils/constants/keys.dart';
import 'package:amtech_design/custom_widgets/appbar/custom_appbar_with_center_title.dart';
import 'package:amtech_design/modules/subscriptions/create_subscription_plan/widgets/day_selection_dropdown.dart';
import 'package:amtech_design/services/local/shared_preferences_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../core/utils/app_colors.dart';
import 'create_subscription_plan_provider.dart';
import 'widgets/custom_subsbutton_with_arrow.dart';
import 'widgets/dropdown_tile.dart';
import 'widgets/select_unit_dropdown.dart';
import 'widgets/selected_time_and_item_widget.dart';

class CreateSubscriptionPlanPage extends StatelessWidget {
  const CreateSubscriptionPlanPage({super.key});

  @override
  Widget build(BuildContext context) {
    final String accountType =
        sharedPrefsService.getString(SharedPrefsKeys.accountType) ?? '';
    final provider =
        Provider.of<CreateSubscriptionPlanProvider>(context, listen: true);
    return Scaffold(
      appBar: CustomAppbarWithCenterTitle(
        title: 'Create Your Daily Plan',
        leftPadTitle: 35.w,
        accountType: accountType,
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const Divider(
                    color: AppColors.primaryColor,
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 22.w, vertical: 22.h),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Select Units',
                                  style: GoogleFonts.publicSans(
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.primaryColor,
                                  ),
                                ),
                                Text(
                                  "1 Unit = 1 Item",
                                  style: GoogleFonts.publicSans(
                                    fontSize: 14.sp,
                                    color: AppColors.disabledColor,
                                  ),
                                ),
                              ],
                            ),

                            // * Custom dropdown
                            const SelectUnitDropdown(),
                          ],
                        ),
                        SizedBox(height: 25.h),
                        // * Select Your Meals
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Select Your Meals',
                                style: GoogleFonts.publicSans(
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.primaryColor,
                                ),
                              ),
                              Text(
                                "We're Closed On Sunday",
                                style: GoogleFonts.publicSans(
                                  fontSize: 14.sp,
                                  color: AppColors.disabledColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 25.h),

                        // * DropdownTile listview
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: provider.days.length,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.only(bottom: 20.h),
                              child: DayDropdownTile(
                                day: provider.days[index],
                                isSwitched: provider
                                        .switchStates[provider.days[index]] ??
                                    true,
                                onToggleSwitch: (value) => provider
                                    .toggleSwitch(provider.days[index], value),
                                selectedTime: provider
                                    .selectedTimeslots[provider.days[index]],
                              ),
                            );
                          },
                        ),

                        //! DayDropdownTile Monday
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //   children: [
                        //     FlutterSwitch(
                        //       value: provider.isSwitched,
                        //       onToggle: provider.onToggleSwitch,
                        //       width: 70.w,
                        //       height: 35.h,
                        //       activeColor: AppColors.primaryColor,
                        //       inactiveColor: AppColors.disabledColor,
                        //     ),
                        //     SizedBox(width: 10.w),

                        //     // * Day Dropdown
                        //     Flexible(
                        //       child: Column(
                        //         mainAxisSize: MainAxisSize.min,
                        //         children: [
                        //           // * DaySelectionDropdown
                        //           const DaySelectionDropdown(day: 'Monday'),
                        //           //* Selected time and item
                        //           if (provider.selectedTimeslots['Monday'] !=
                        //               null)
                        //             SelectedTimeAndItemWidget(
                        //               selectedTime:
                        //                   '${provider.selectedTimeslots['Monday']}',
                        //               selectedItem: 'Mexican Salad',
                        //             ),
                        //         ],
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        // SizedBox(height: 20.h),
                        // //! DayDropdownTile Tuesday
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //   children: [
                        //     FlutterSwitch(
                        //       value: provider.isSwitched,
                        //       onToggle: provider.onToggleSwitch,
                        //       width: 70.w,
                        //       height: 35.h,
                        //       activeColor: AppColors.primaryColor,
                        //       inactiveColor: AppColors.disabledColor,
                        //     ),
                        //     SizedBox(width: 10.w),
                        //     // * Day Dropdown
                        //     Flexible(
                        //       child: Column(
                        //         mainAxisSize: MainAxisSize.min,
                        //         children: [
                        //           // * DaySelectionDropdown
                        //           const DaySelectionDropdown(day: 'Tuesday'),
                        //           //* Selected time and item
                        //           if (provider.selectedTimeslots['Tuesday'] !=
                        //               null)
                        //             SelectedTimeAndItemWidget(
                        //               selectedTime:
                        //                   '${provider.selectedTimeslots['Tuesday']}',
                        //               selectedItem: 'Mexican Salad',
                        //             ),
                        //         ],
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        // SizedBox(height: 20.h),
                        // //! DayDropdownTile Wednesday
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //   children: [
                        //     FlutterSwitch(
                        //       value: provider.isSwitched,
                        //       onToggle: provider.onToggleSwitch,
                        //       width: 70.w,
                        //       height: 35.h,
                        //       activeColor: AppColors.primaryColor,
                        //       inactiveColor: AppColors.disabledColor,
                        //     ),
                        //     SizedBox(width: 10.w),
                        //     // * Day Dropdown
                        //     Flexible(
                        //       child: Column(
                        //         mainAxisSize: MainAxisSize.min,
                        //         children: [
                        //           // * DaySelectionDropdown
                        //           const DaySelectionDropdown(day: 'Wednesday'),
                        //           //* Selected time and item
                        //           if (provider.selectedTimeslots['Wednesday'] !=
                        //               null)
                        //             SelectedTimeAndItemWidget(
                        //               selectedTime:
                        //                   '${provider.selectedTimeslots['Wednesday']}',
                        //               selectedItem: 'Mexican Salad',
                        //             ),
                        //         ],
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        // SizedBox(height: 20.h),
                        // //! DayDropdownTile Thursday
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //   children: [
                        //     FlutterSwitch(
                        //       value: provider.isSwitched,
                        //       onToggle: provider.onToggleSwitch,
                        //       width: 70.w,
                        //       height: 35.h,
                        //       activeColor: AppColors.primaryColor,
                        //       inactiveColor: AppColors.disabledColor,
                        //     ),
                        //     SizedBox(width: 10.w),
                        //     // * Day Dropdown
                        //     Flexible(
                        //       child: Column(
                        //         mainAxisSize: MainAxisSize.min,
                        //         children: [
                        //           // * DaySelectionDropdown
                        //           const DaySelectionDropdown(day: 'Thursday'),
                        //           //* Selected time and item
                        //           if (provider.selectedTimeslots['Thursday'] !=
                        //               null)
                        //             SelectedTimeAndItemWidget(
                        //               selectedTime:
                        //                   '${provider.selectedTimeslots['Thursday']}',
                        //               selectedItem: 'Mexican Salad',
                        //             ),
                        //         ],
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        // SizedBox(height: 20.h),
                        // //! DayDropdownTile Friday
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //   children: [
                        //     FlutterSwitch(
                        //       value: provider.isSwitched,
                        //       onToggle: provider.onToggleSwitch,
                        //       width: 70.w,
                        //       height: 35.h,
                        //       activeColor: AppColors.primaryColor,
                        //       inactiveColor: AppColors.disabledColor,
                        //     ),
                        //     SizedBox(width: 10.w),
                        //     // * Day Dropdown
                        //     Flexible(
                        //       child: Column(
                        //         mainAxisSize: MainAxisSize.min,
                        //         children: [
                        //           // * DaySelectionDropdown
                        //           const DaySelectionDropdown(day: 'Friday'),
                        //           //* Selected time and item
                        //           if (provider.selectedTimeslots['Friday'] !=
                        //               null)
                        //             SelectedTimeAndItemWidget(
                        //               selectedTime:
                        //                   '${provider.selectedTimeslots['Friday']}',
                        //               selectedItem: 'Mexican Salad',
                        //             ),
                        //         ],
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        // SizedBox(height: 20.h),
                        // //! DayDropdownTile Saturday
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //   children: [
                        //     FlutterSwitch(
                        //       value: provider.isSwitched,
                        //       onToggle: provider.onToggleSwitch,
                        //       width: 70.w,
                        //       height: 35.h,
                        //       activeColor: AppColors.primaryColor,
                        //       inactiveColor: AppColors.disabledColor,
                        //     ),
                        //     SizedBox(width: 10.w),
                        //     // * Day Dropdown
                        //     Flexible(
                        //       child: Column(
                        //         mainAxisSize: MainAxisSize.min,
                        //         children: [
                        //           // * DaySelectionDropdown
                        //           const DaySelectionDropdown(day: 'Saturday'),
                        //           //* Selected time and item
                        //           if (provider.selectedTimeslots['Saturday'] !=
                        //               null)
                        //             SelectedTimeAndItemWidget(
                        //               selectedTime:
                        //                   '${provider.selectedTimeslots['Saturday']}',
                        //               selectedItem: 'Mexican Salad',
                        //             ),
                        //         ],
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        SizedBox(height: 120.h),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned.fill(
              left: 22.w,
              right: 22.w,
              bottom: 40.h,
              child: const Align(
                alignment: Alignment.bottomCenter,
                child: CustomSubsButtonWithArrow(),
              ))
        ],
      ),
    );
  }
}
