import 'dart:developer';
import 'package:amtech_design/core/utils/constant.dart';
import 'package:amtech_design/modules/menu/menu_provider.dart';
import 'package:amtech_design/modules/subscriptions/create_subscription_plan/widgets/custom_subsbutton_with_arrow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../custom_widgets/buttons/custom_bottomsheet_close_button.dart';
import 'select_meal_bottomsheet_provider.dart';
import 'widgets/bottomsheet_tabbar_view_widget.dart';

void showSelectMealBottomSheeet({
  required BuildContext context,
  required String accountType,
  required String day,
  required int mealIndex,
}) {
  final menuProvider = Provider.of<MenuProvider>(context, listen: false);
  menuProvider.homeMenuApi(); //* Api call
  showModalBottomSheet(
    context: context,
    backgroundColor: getColorAccountType(
      accountType: accountType,
      businessColor: AppColors.primaryColor,
      personalColor: AppColors.darkGreenGrey,
    ),
    isScrollControlled: true,
    builder: (context) {
      log('Select meal bottomsheet called');
      final provider =
          Provider.of<SelectMealBottomsheetProvider>(context, listen: false);

      return Stack(
        clipBehavior: Clip.none,
        children: [
          SizedBox(
            height: 1.sh * .8,
            child: DefaultTabController(
              //* Categories length
              length: menuProvider.menuCategories?.length ?? 0,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  // * Tab Bar
                  Consumer<MenuProvider>(
                    builder: (context, _, child) => TabBar(
                      isScrollable: true,
                      tabAlignment: TabAlignment.start,
                      dividerColor: Colors.transparent,
                      indicatorColor: Colors.white,
                      labelColor: Colors.white,
                      unselectedLabelColor: Colors.grey,
                      labelStyle:
                          GoogleFonts.publicSans(fontWeight: FontWeight.bold),
                      unselectedLabelStyle:
                          GoogleFonts.publicSans(fontWeight: FontWeight.w600),
                      tabs: (menuProvider.menuCategories ?? [])
                          .map((category) =>
                              Tab(text: category.categoryTitle ?? ''))
                          .toList(),
                    ),
                  ),

                  // * Tab Bar View
                  Expanded(
                    child: Consumer<MenuProvider>(
                      builder: (context, _, child) => TabBarView(
                        children: (menuProvider.menuCategories ?? [])
                            .map((category) => BottomsheetTabbarViewWidget(
                                  day: day,
                                  mealIndex: mealIndex,
                                  itemLength: category.menuItems?.length ?? 0,
                                  menuItems: category.menuItems,
                                  menuProvider: menuProvider,
                                  itemName: category.menuItems
                                          ?.map((item) => item.itemName ?? '')
                                          .join(', ') ??
                                      'No Items',
                                  provider: provider,
                                ))
                            .toList(),
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
              color: getColorAccountType(
                accountType: accountType,
                businessColor: AppColors.primaryColor,
                personalColor: AppColors.darkGreenGrey,
              ),
              padding: EdgeInsets.only(
                top: 8.h,
                bottom: 20.h,
                right: 20.h,
                left: 20.h,
              ),
              child: CustomSubsButtonWithArrow(
                bgColor: getColorAccountType(
                  accountType: accountType,
                  businessColor: AppColors.seaShell,
                  personalColor: AppColors.seaMist,
                ),
                singleText: '2 Items Added (static)',
                iconData: Icons.done,
                iconColor: getColorAccountType(
                  accountType: accountType,
                  businessColor: AppColors.seaShell,
                  personalColor: AppColors.seaMist,
                ),
                iconBgColor: getColorAccountType(
                  accountType: accountType,
                  businessColor: AppColors.primaryColor,
                  personalColor: AppColors.darkGreenGrey,
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
