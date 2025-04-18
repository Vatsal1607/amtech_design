import 'dart:developer';
import 'package:amtech_design/core/utils/constant.dart';
import 'package:amtech_design/custom_widgets/appbar/custom_appbar_with_center_title.dart';
import 'package:amtech_design/custom_widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/constants/keys.dart';
import '../../../services/local/shared_preferences_service.dart';
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
      backgroundColor: getColorAccountType(
        accountType: accountType,
        businessColor: AppColors.seaShell,
        personalColor: AppColors.seaMist,
      ),
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
                Divider(
                  color: getColorAccountType(
                    accountType: accountType,
                    businessColor: AppColors.primaryColor,
                    personalColor: AppColors.darkGreenGrey,
                  ),
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
                                      color: getColorAccountType(
                                        accountType: accountType,
                                        businessColor: AppColors.primaryColor,
                                        personalColor: AppColors.darkGreenGrey,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    "1 Unit = 1 Item",
                                    style: GoogleFonts.publicSans(
                                      fontSize: 14.sp,
                                      color: getColorAccountType(
                                        accountType: accountType,
                                        businessColor: AppColors.disabledColor,
                                        personalColor: AppColors.bayLeaf,
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              // * Custom dropdown
                              SelectUnitDropdown(
                                accountType: accountType,
                              ),
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
                                    color: getColorAccountType(
                                      accountType: accountType,
                                      businessColor: AppColors.primaryColor,
                                      personalColor: AppColors.darkGreenGrey,
                                    ),
                                  ),
                                ),
                                Text(
                                  "We're Closed On Sunday",
                                  style: GoogleFonts.publicSans(
                                    fontSize: 14.sp,
                                    color: getColorAccountType(
                                      accountType: accountType,
                                      businessColor: AppColors.disabledColor,
                                      personalColor: AppColors.bayLeaf,
                                    ),
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
                                //* Dropdown tile
                                child: DayDropdownTile(
                                  accountType: accountType,
                                  day: provider.days[index],
                                  isSwitched: provider
                                          .switchStates[provider.days[index]] ??
                                      true,
                                  onToggleSwitch: (value) =>
                                      provider.toggleSwitch(
                                          provider.days[index], value, context),
                                  selectedTime: (provider
                                              .selectedTimeSlots[
                                                  provider.days[index]]
                                              ?.values
                                              .isNotEmpty ??
                                          false)
                                      ? provider
                                          .selectedTimeSlots[
                                              provider.days[index]]!
                                          .values
                                          .first
                                      : "No Time Slot",
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
                  bgColor: getColorAccountType(
                    accountType: accountType,
                    businessColor: AppColors.primaryColor,
                    personalColor: AppColors.darkGreenGrey,
                  ),
                  iconBgColor: getColorAccountType(
                    accountType: accountType,
                    businessColor: AppColors.seaShell,
                    personalColor: AppColors.seaMist,
                  ),
                  unit: provider.subsItems.length.toString(),
                  onTap: () {
                    if (provider.subsItems.isNotEmpty) {
                      //! Note: if isUpdateSubscription == true then Update api will call otherwise create Api call
                      if (provider.isUpdateSubscription) {
                        provider.subscriptionUpdate(
                          context: context,
                        ); //* Api call
                        log('subscriptionUpdate called');
                      } else {
                        provider.subscriptionCreate(context); //* Api call
                        log('subscriptionCreate called');
                      }
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
