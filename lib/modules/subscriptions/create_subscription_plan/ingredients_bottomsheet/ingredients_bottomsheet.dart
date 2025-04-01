import 'dart:developer';
import 'package:amtech_design/core/utils/constant.dart';
import 'package:amtech_design/custom_widgets/buttons/custom_button.dart';
import 'package:amtech_design/custom_widgets/loader/custom_loader.dart';
import 'package:amtech_design/modules/menu/menu_provider.dart';
import 'package:amtech_design/modules/subscriptions/create_subscription_plan/create_subscription_plan_provider.dart';
import 'package:amtech_design/modules/subscriptions/create_subscription_plan/ingredients_bottomsheet/widgets/add_ons_selection_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../custom_widgets/buttons/custom_bottomsheet_close_button.dart';
import 'package:amtech_design/models/subscription_create_request_model.dart'
    as subscription;
import '../../../../models/home_menu_model.dart' as home;
import 'ingredients_bottomsheet_provider.dart';
import 'widgets/add_note_widget.dart';

Future<void> showIngredientsBottomSheeet({
  required String day,
  required BuildContext context,
  required String accountType,
  required String menuId,
  required String itemName,
  home.MenuItems? menuItems,
  // required int index,
}) async {
  // log('Index is: $index');
  final ingredientsProvider =
      Provider.of<IngredientsBottomsheetProvider>(context, listen: false);
  final menuProvider = Provider.of<MenuProvider>(context, listen: false);
  await ingredientsProvider.getIngredientsAndAddOns(
      menuId: menuId); //* Api call
  await menuProvider.getMenuSize(menuId: menuId); //* Api call
  final size = menuProvider.menuSizeResponse?.data?.sizeDetails?.first;
  final String sizeId = size?.sizeId ?? '';
  final String sizeName = size?.sizeName ?? '';
  final num sizePrice = size?.price ?? 0;
  log('Get menusize price: ${menuProvider.menuSizeResponse?.data?.sizeDetails?.first.price}');
  showModalBottomSheet(
    context: context,
    backgroundColor: getColorAccountType(
      accountType: accountType,
      businessColor: AppColors.seaShell,
      personalColor: AppColors.seaMist,
    ),
    isScrollControlled: true, // Allows full height modal
    builder: (context) {
      log('Ingredients bottomsheet called');
      return Stack(
        clipBehavior: Clip.none,
        children: [
          // * Ingredients
          SizedBox(
            height: 1.sh * .8,
            child: Padding(
              padding: EdgeInsets.only(
                left: 16.w,
                right: 16.w,
                top: 16.w,
                //* Adjust bottomsheet while keyboard open
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    itemName,
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
                          Consumer<IngredientsBottomsheetProvider>(
                            builder: (context, _, child) => ingredientsProvider
                                    .isLoading
                                ? const Center(
                                    child: CustomLoader(
                                      backgroundColor: AppColors.primaryColor,
                                    ),
                                  )
                                : ListView(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    padding: EdgeInsets.zero,
                                    children: ingredientsProvider
                                        .ingredientSelections.entries
                                        .map((entry) {
                                      // Extracting the name and the selection status from the map
                                      final name = entry.value.keys.first;
                                      final isSelected =
                                          entry.value.values.first;

                                      return CheckboxListTile(
                                        dense: true,
                                        activeColor: AppColors.primaryColor,
                                        title: Text(
                                          name,
                                          style: GoogleFonts.publicSans(
                                              fontSize: 16.sp),
                                        ),
                                        value: isSelected,
                                        onChanged: (value) {
                                          ingredientsProvider.onChangedCheckBox(
                                              value, entry.key);
                                        },
                                        materialTapTargetSize:
                                            MaterialTapTargetSize.shrinkWrap,
                                        controlAffinity:
                                            ListTileControlAffinity.leading,
                                        visualDensity: VisualDensity.compact,
                                        contentPadding: EdgeInsets.zero,
                                      );
                                    }).toList(),
                                  ),
                          ),

                          //* Add-Ons Checkbox
                          const AddOnsSelectionWidget(),

                          // * Add Note widget
                          const AddNoteWidget(),

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
              child: Consumer<CreateSubscriptionPlanProvider>(
                builder: (context, createSubsProvider, child) => CustomButton(
                  height: 60.h,
                  onTap: () {
                    // DayWiseSelected ItemName
                    createSubsProvider.addOrUpdateDayWiseSelectedItem(
                        day, itemName);
                    //* Subscription create Add items depends on selected days
                    createSubsProvider.addItem(
                      menuId: menuId,
                      size: subscription.Size(
                        sizeId: sizeId,
                        name: sizeName,
                        price: sizePrice.toDouble(),
                      ),
                      meals: [
                        subscription.MealSubscription(
                          day: day,
                          // timeSlot: createSubsProvider.getSelectedTimeSlot(
                          //   day,
                          //   mealIndex,
                          // ),
                          timeSlot: createSubsProvider
                                  .selectedTimeSlots[day]?.values.first ??
                              '',
                          quantity: 1, // Todo (Static): set dynamic
                        ),
                      ],
                      customize: [
                        subscription.Customization(
                          ingredients:
                              ingredientsProvider.getSelectedIngredients(),
                          addOns: ingredientsProvider.getSelectedAddOns(),
                        ),
                      ],
                    );
                    // Reset addOnsQuantity
                    ingredientsProvider.addOnsQuantity = {};
                    log('addOnsQuantity: ${ingredientsProvider.addOnsQuantity}');
                    Navigator.pop(context);
                    log('subsItems.length: ${createSubsProvider.subsItems.length}');
                  },
                  text: 'DONE',
                  fontSize: 20.sp,
                  bgColor: AppColors.primaryColor,
                ),
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
