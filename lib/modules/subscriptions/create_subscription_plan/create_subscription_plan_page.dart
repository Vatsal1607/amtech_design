import 'package:amtech_design/core/utils/constants/keys.dart';
import 'package:amtech_design/custom_widgets/appbar/custom_appbar_with_center_title.dart';
import 'package:amtech_design/custom_widgets/snackbar.dart';
import 'package:amtech_design/services/local/shared_preferences_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../core/utils/app_colors.dart';
import '../../../routes.dart';
import 'create_subscription_plan_provider.dart';
import 'widgets/custom_subsbutton_with_arrow.dart';
import 'widgets/dropdown_tile.dart';
import 'widgets/select_unit_dropdown.dart';

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
            child: Column(
              children: [
                const Divider(
                  color: AppColors.primaryColor,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 22.w, vertical: 22.h),
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
                                  // selectedItem: ,
                                  day: provider.days[index],
                                  isSwitched: provider
                                          .switchStates[provider.days[index]] ??
                                      true,
                                  onToggleSwitch: (value) =>
                                      provider.toggleSwitch(
                                          provider.days[index], value, context),
                                  // selectedTime: provider
                                  //     .selectedTimeslots[provider.days[index]],
                                  selectedTime: provider
                                          .selectedTimeSlots[
                                              provider.days[index]]
                                          ?.values
                                          .first ??
                                      "No Time Slot",
                                ),
                              );
                            },
                          ),

                          SizedBox(height: 120.h),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (provider.subsItems.isNotEmpty)
            Positioned.fill(
              left: 22.w,
              right: 22.w,
              bottom: 40.h,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: CustomSubsButtonWithArrow(
                  iconBgColor: AppColors.seaShell,
                  unit: provider.subsItems.length.toString(),
                  onTap: () {
                    if (provider.subsItems.isNotEmpty) {
                      provider.subscriptionCreate(context); //* Api call
                      // Navigator.pushNamed(context, Routes.subscriptionSummary);
                    } else {
                      customSnackBar(
                          context: context, message: 'Please Select Meal');
                    }
                  },
                ),
              ),
            ),
        ],
      ),
    );
  }
}
