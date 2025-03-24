import 'package:amtech_design/core/utils/constants/keys.dart';
import 'package:amtech_design/modules/subscriptions/create_subscription_plan/ingredients_bottomsheet/ingredients_bottomsheet.dart';
import 'package:amtech_design/modules/subscriptions/create_subscription_plan/select_meal_bottomsheet/widgets/counter_widget.dart';
import 'package:amtech_design/custom_widgets/buttons/small_edit_button.dart';
import 'package:amtech_design/services/local/shared_preferences_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../../../core/utils/app_colors.dart';
import '../select_meal_bottomsheet_provider.dart';

//! text should Unique category name for each tab
class BottomsheetTabbarViewWidget extends StatelessWidget {
  final String text;
  final SelectMealBottomsheetProvider provider;
  const BottomsheetTabbarViewWidget({
    super.key,
    required this.text,
    required this.provider,
  });

  @override
  Widget build(BuildContext context) {
    final String accountType =
        sharedPrefsService.getString(SharedPrefsKeys.accountType) ?? '';
    return ListView.builder(
      itemCount: 10,
      shrinkWrap: true,
      padding: EdgeInsets.only(top: 10.h, bottom: 80.h),
      itemBuilder: (context, index) {
        return Column(
          children: [
            const Divider(
              color: AppColors.disabledColor,
              thickness: 0.5,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 14.h),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Exotic Fruit Salad",
                          style: GoogleFonts.publicSans(
                              color: Colors.white,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 4.h),
                        Row(
                          children: [
                            const Icon(Icons.star,
                                color: AppColors.disabledColor, size: 16),
                            SizedBox(width: 4.w),
                            Text(
                              "4.5",
                              style: GoogleFonts.publicSans(
                                fontSize: 14.sp,
                                color: AppColors.disabledColor,
                              ),
                            ),
                            SizedBox(width: 8.w),
                            Text(
                              "• Best Seller",
                              style: GoogleFonts.publicSans(
                                color: AppColors.disabledColor,
                                fontSize: 14.sp,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10.h),
                        Consumer<SelectMealBottomsheetProvider>(
                            builder: (context, provider, child) {
                          int quantity = provider.getQuantity(text, index);
                          return quantity == 0
                              ? SmallEditButton(
                                  width: 108.w,
                                  height: 30.h,
                                  accountType: 'business',
                                  onTap: () {
                                    showIngredientsBottomSheeet(
                                      context: context,
                                      accountType: accountType,
                                    );
                                    // Todo: Uncomment & call on Done button success select ingredients
                                    // provider.addItem(text, index);
                                  },
                                  bgColor: AppColors.seaShell,
                                  textColor: AppColors.primaryColor,
                                  text: 'Add',
                                  fontSize: 14.sp,
                                )
                              :
                              // * Show Quantity Counter
                              CustomCounterWidget(
                                  onTapDecrease: () {
                                    provider.decrement(text, index);
                                  },
                                  onTapIncrease: () {
                                    provider.increment(text, index);
                                  },
                                  quantity: quantity.toString(),
                                );
                        }),
                      ],
                    ),
                  ),
                  SizedBox(width: 10.w),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.r),
                    child: SizedBox(
                      width: 80.w,
                      height: 80.h,
                      child: Image.network(
                        "https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Nnx8Zm9vZCUyMHBuZ3xlbnwwfHwwfHx8MA%3D%3D",
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            const Icon(Icons.broken_image, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
