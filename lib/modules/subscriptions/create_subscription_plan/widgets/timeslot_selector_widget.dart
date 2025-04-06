import 'dart:developer';
import 'package:amtech_design/core/utils/constant.dart';
import 'package:amtech_design/modules/subscriptions/create_subscription_plan/create_subscription_plan_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../../core/utils/app_colors.dart';

class TimeSlotSelectorWidget extends StatelessWidget {
  final String day;
  final int mealIndex;
  final String accountType;
  const TimeSlotSelectorWidget({
    super.key,
    required this.day,
    required this.mealIndex,
    required this.accountType,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30.h,
      child: Consumer<CreateSubscriptionPlanProvider>(
        builder: (context, provider, child) {
          final selectedTimeSlot = provider.selectedTimeSlots[day]
                  ?[mealIndex] ??
              provider.timeSlots.first;

          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: provider.timeSlots.length,
            itemBuilder: (context, index) {
              final isSelected = selectedTimeSlot == provider.timeSlots[index];

              return GestureDetector(
                onTap: () {
                  provider.onTapTimeSlot(
                      day, mealIndex, provider.timeSlots[index]);
                  log('Selected timeslot: ${provider.selectedTimeSlots.toString()}');
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  margin: EdgeInsets.symmetric(horizontal: 8.w),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? getColorAccountType(
                            accountType: accountType,
                            businessColor: AppColors.disabledColor,
                            personalColor: AppColors.bayLeaf,
                          )
                        : getColorAccountType(
                            accountType: accountType,
                            businessColor: AppColors.seaShell,
                            personalColor: AppColors.seaMist,
                          ),
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Center(
                    child: Text(
                      provider.timeSlots[index],
                      style: GoogleFonts.publicSans(
                        fontSize: 14.sp,
                        color: isSelected ? Colors.white : Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
