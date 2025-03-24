import 'package:amtech_design/core/utils/constant.dart';
import 'package:amtech_design/custom_widgets/buttons/custom_button.dart';
import 'package:amtech_design/modules/subscriptions/create_subscription_plan/ingredients_bottomsheet/widgets/add_ons_selection_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../custom_widgets/buttons/custom_bottomsheet_close_button.dart';
import '../select_meal_bottomsheet/select_meal_bottomsheet_provider.dart';
import 'widgets/add_note_widget.dart';

void showIngredientsBottomSheeet({
  required BuildContext context,
  required String accountType,
}) {
  showModalBottomSheet(
    context: context,
    backgroundColor: getColorAccountType(
      accountType: accountType,
      businessColor: AppColors.seaShell,
      personalColor: AppColors.seaMist,
    ),
    isScrollControlled: true, // Allows full height modal
    builder: (context) {
      final provider =
          Provider.of<SelectMealBottomsheetProvider>(context, listen: false);
      return Stack(
        clipBehavior: Clip.none,
        children: [
          // * Ingredients
          SizedBox(
            height: 1.sh * .8,
            child: Padding(
              padding: EdgeInsets.all(16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Exotic Fruit Salad",
                    style: GoogleFonts.publicSans(
                      fontSize: 22.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    "Select Ingredients & Add-Ons",
                    style: GoogleFonts.publicSans(
                        fontSize: 14.sp, color: Colors.grey),
                  ),
                  SizedBox(height: 16.h),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Ingredients",
                            style: GoogleFonts.publicSans(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          //* Ingredients Checkbox
                          ListView(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            padding: EdgeInsets.zero,
                            children:
                                provider.ingredients.keys.map((String key) {
                              return Consumer<SelectMealBottomsheetProvider>(
                                builder: (context, _, child) =>
                                    CheckboxListTile(
                                  dense: true,
                                  activeColor: AppColors.primaryColor,
                                  title: Text(key,
                                      style: GoogleFonts.publicSans(
                                          fontSize: 16.sp)),
                                  value: provider.ingredients[key],
                                  onChanged: (value) {
                                    provider.onChangedCheckBox(value, key);
                                  },
                                  materialTapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                  controlAffinity:
                                      ListTileControlAffinity.leading,
                                  visualDensity: VisualDensity.compact,
                                  contentPadding: EdgeInsets.zero,
                                ),
                              );
                            }).toList(),
                          ),
                          // SizedBox(height: 20.h),

                          //* Add-Ons Checkbox
                          const AddOnsSelectionWidget(),

                          // * Add Note widget
                          AddNoteWidget(),

                          SizedBox(height: 100.h),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: Container(
              color: AppColors.seaShell,
              padding: EdgeInsets.only(
                top: 8.h,
                bottom: 20.h,
                right: 20.h,
                left: 20.h,
              ),
              child: CustomButton(
                height: 60.h,
                onTap: () {},
                text: 'DONE',
                fontSize: 20,
                bgColor: AppColors.primaryColor,
              ),
            ),
          ),
          const Positioned(
            top: -40,
            right: 0,
            left: 0,
            child: CustomBottomsheetCloseButton(),
          ),
        ],
      );
    },
  );
}
