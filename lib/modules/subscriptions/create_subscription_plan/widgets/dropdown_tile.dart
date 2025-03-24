import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_switch/flutter_switch.dart';
import '../../../../core/utils/app_colors.dart';
import 'day_selection_dropdown.dart';
import 'selected_time_and_item_widget.dart';

class DayDropdownTile extends StatelessWidget {
  final String day;
  final bool isSwitched;
  final Function(bool) onToggleSwitch;
  final String? selectedTime;

  const DayDropdownTile({
    super.key,
    required this.day,
    required this.isSwitched,
    required this.onToggleSwitch,
    this.selectedTime,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start, //
      children: [
        FlutterSwitch(
          value: isSwitched,
          onToggle: onToggleSwitch,
          width: 70.w,
          height: 35.h,
          activeColor: AppColors.primaryColor,
          inactiveColor: AppColors.disabledColor,
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
                SelectedTimeAndItemWidget(
                  selectedTime: selectedTime!,
                  selectedItem: 'Mexican Salad',
                ),
                
            ],
          ),
        ),
      ],
    );
  }
}
