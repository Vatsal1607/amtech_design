import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../custom_widgets/buttons/small_edit_button.dart';
import '../../select_meal_bottomsheet/select_meal_bottomsheet_provider.dart';
import '../../select_meal_bottomsheet/widgets/counter_widget.dart';

class AddOnsSelectionWidget extends StatefulWidget {
  const AddOnsSelectionWidget({super.key});

  @override
  AddOnsSelectionWidgetState createState() => AddOnsSelectionWidgetState();
}

class AddOnsSelectionWidgetState extends State<AddOnsSelectionWidget> {
  @override
  Widget build(BuildContext context) {
    final provider =
        Provider.of<SelectMealBottomsheetProvider>(context, listen: false);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Title
        Row(
          children: [
            Text(
              "Add-Ons",
              style: GoogleFonts.publicSans(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              " (1 Unit Each)",
              style: GoogleFonts.publicSans(
                fontSize: 14.sp,
                color: Colors.grey,
              ),
            ),
          ],
        ),
        SizedBox(height: 8.h),

        // Add-Ons List
        Consumer<SelectMealBottomsheetProvider>(
          builder: (context, _, child) => ListView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: provider.addOns.keys.map((String key) {
              return CheckboxListTile(
                activeColor: AppColors.primaryColor,
                value: provider.addOns[key],
                dense: true,
                onChanged: (value) {
                  provider.onChangedAddOnsCheckBox(value, key);
                },
                title: Row(
                  children: [
                    Text(
                      key,
                      style: GoogleFonts.publicSans(fontSize: 16.sp),
                    ),
                    Text(
                      " (250 ml)",
                      style: GoogleFonts.publicSans(
                        fontSize: 14.sp,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                controlAffinity:
                    ListTileControlAffinity.leading, // Checkbox at the start
                contentPadding: EdgeInsets.zero, // Adjust spacing if needed
                secondary: Stack(
                  alignment: Alignment.centerRight,
                  children: [
                    // This absorbs taps on the background area behind the secondary widget
                    Positioned.fill(
                      child: AbsorbPointer(
                        absorbing:
                            true, // Prevents taps from going to CheckboxListTile
                        child: Container(
                            color: Colors.transparent), // Invisible tap blocker
                      ),
                    ),
                    // Actual interactive widget (Add button or Counter)
                    provider.addOns[key] == true
                        ? CustomCounterWidget(
                            height: 32.h,
                            onTapDecrease: () {
                              provider.addOnsDecrement(key);
                            },
                            onTapIncrease: () {
                              provider.addOnsIncrement(key);
                            },
                            quantity: provider.addOnsQuantity[key].toString(),
                            bgColor: AppColors.primaryColor,
                            textColor: AppColors.seaShell,
                          )
                        : SmallEditButton(
                            width: 108.w,
                            height: 32.h,
                            accountType: 'business',
                            onTap: () {
                              provider.addAddOnsItem(key);
                            },
                            bgColor: AppColors.seaShell,
                            textColor: AppColors.primaryColor,
                            text: 'Add',
                            fontSize: 14.sp,
                          ),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
