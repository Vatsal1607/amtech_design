import 'package:amtech_design/modules/subscriptions/create_subscription_plan/ingredients_bottomsheet/ingredients_bottomsheet_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../custom_widgets/buttons/small_edit_button.dart';
import '../../../../../custom_widgets/loader/custom_loader.dart';
import '../../select_meal_bottomsheet/widgets/counter_widget.dart';

class AddOnsSelectionWidget extends StatefulWidget {
  final String accountType;
  const AddOnsSelectionWidget({super.key, required this.accountType});

  @override
  AddOnsSelectionWidgetState createState() => AddOnsSelectionWidgetState();
}

class AddOnsSelectionWidgetState extends State<AddOnsSelectionWidget> {
  @override
  Widget build(BuildContext context) {
    final ingredientsProvider =
        Provider.of<IngredientsBottomsheetProvider>(context, listen: false);
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
        Consumer<IngredientsBottomsheetProvider>(
          builder: (context, _, child) => ingredientsProvider.isLoading
              ? const Center(
                  child: CustomLoader(
                    backgroundColor: AppColors.primaryColor,
                  ),
                )
              : ListView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: ingredientsProvider.addOnsSelections.keys
                      .map((String key) {
                    final String name = ingredientsProvider.addOnsList
                            ?.firstWhere((element) => element.id == key)
                            .name ??
                        key;
                    return CheckboxListTile(
                      activeColor: AppColors.primaryColor,
                      value: ingredientsProvider
                              .addOnsSelections[key]?.values.first ??
                          false,
                      dense: true,
                      onChanged: (value) {
                        ingredientsProvider.onChangedAddOnsCheckBox(value, key);
                      },
                      title: Row(
                        children: [
                          Text(
                            name,
                            style: GoogleFonts.publicSans(fontSize: 16.sp),
                          ),
                          // Text(
                          //   " (250 ml)",
                          //   style: GoogleFonts.publicSans(
                          //     fontSize: 14.sp,
                          //     color: Colors.grey,
                          //   ),
                          // ),
                        ],
                      ),
                      controlAffinity: ListTileControlAffinity
                          .leading, // Checkbox at the start
                      contentPadding:
                          EdgeInsets.zero, // Adjust spacing if needed
                      secondary: Stack(
                        alignment: Alignment.centerRight,
                        children: [
                          Positioned.fill(
                            child: AbsorbPointer(
                              absorbing: true,
                              child: Container(color: Colors.transparent),
                            ),
                          ),
                          ingredientsProvider
                                      .addOnsSelections[key]?.values.first ==
                                  true
                              ? CustomCounterWidget(
                                  accountType: widget.accountType,
                                  height: 32.h,
                                  onTapDecrease: () {
                                    ingredientsProvider.addOnsDecrement(key);
                                  },
                                  onTapIncrease: () {
                                    ingredientsProvider.addOnsIncrement(key);
                                  },
                                  quantity: ingredientsProvider
                                      .addOnsQuantity[key]
                                      .toString(),
                                  bgColor: AppColors.primaryColor,
                                  textColor: AppColors.seaShell,
                                )
                              : SmallEditButton(
                                  width: 108.w,
                                  height: 32.h,
                                  accountType: 'business',
                                  onTap: () {
                                    ingredientsProvider.addAddOnsItem(key);
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
