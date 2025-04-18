import 'package:amtech_design/modules/subscriptions/create_subscription_plan/create_subscription_plan_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:provider/provider.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/constant.dart';
import 'day_selection_dropdown.dart';
import 'selected_time_and_item_widget.dart';

class DayDropdownTile extends StatelessWidget {
  final String day;
  final bool isSwitched;
  final Function(bool) onToggleSwitch;
  final String? selectedTime;
  final String accountType;
  const DayDropdownTile({
    super.key,
    required this.day,
    required this.isSwitched,
    required this.onToggleSwitch,
    this.selectedTime,
    required this.accountType,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FlutterSwitch(
          value: isSwitched,
          onToggle: onToggleSwitch,
          width: 70.w,
          height: 35.h,
          activeColor: AppColors.lightGreen,
          inactiveColor: AppColors.red,
          activeText: "ON",
          inactiveText: "OFF",
          showOnOff: true,
        ),
        SizedBox(width: 10.w),
        Flexible(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Opacity(
                opacity: isSwitched ? 1.0 : 0.5,
                child: IgnorePointer(
                  ignoring: !isSwitched,
                  child: DaySelectionDropdown(day: day),
                ),
              ),
              if (selectedTime != null)
                //* Time & Item widget
                Consumer<CreateSubscriptionPlanProvider>(
                  builder: (context, provider, child) =>
                      SelectedTimeAndItemWidget(
                    accountType: accountType,
                    selectedTime: selectedTime!,
                    selectedItem: provider.daywiseSelectedItem[day] ?? '',
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
