import 'package:amtech_design/core/utils/constant.dart';
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
}) {
  showModalBottomSheet(
    context: context,
    backgroundColor: getColorAccountType(
      accountType: accountType,
      businessColor: AppColors.primaryColor,
      personalColor: AppColors.darkGreenGrey,
    ),
    isScrollControlled: true, // Allows full height modal
    builder: (context) {
      final provider =
          Provider.of<SelectMealBottomsheetProvider>(context, listen: false);
      return Stack(
        clipBehavior: Clip.none,
        children: [
          SizedBox(
            height: 1.sh * .8,
            child: DefaultTabController(
              length: 5,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  // * Tab Bar
                  TabBar(
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
                    tabs: const [
                      Tab(text: "Salads"),
                      Tab(text: "Juice"),
                      Tab(text: "Shakes"),
                      Tab(text: "Favourites"),
                      Tab(text: "Food"),
                    ],
                  ),

                  // * Tab Bar View
                  Expanded(
                    child: TabBarView(
                      children: [
                        BottomsheetTabbarViewWidget(
                          text: "Salads Content",
                          provider: provider,
                        ),
                        BottomsheetTabbarViewWidget(
                          text: "Juice Content",
                          provider: provider,
                        ),
                        BottomsheetTabbarViewWidget(
                          text: "Shakes Content",
                          provider: provider,
                        ),
                        BottomsheetTabbarViewWidget(
                          text: "Favourite Content",
                          provider: provider,
                        ),
                        BottomsheetTabbarViewWidget(
                          text: "Food",
                          provider: provider,
                        ),
                      ],
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
              color: AppColors.primaryColor,
              padding: EdgeInsets.only(
                top: 8.h,
                bottom: 20.h,
                right: 20.h,
                left: 20.h,
              ),
              child: const CustomSubsButtonWithArrow(
                bgColor: AppColors.seaShell,
                singleText: '2 Items Added',
                iconData: Icons.done,
                iconColor: AppColors.seaShell,
                iconBgColor: AppColors.primaryColor,
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
