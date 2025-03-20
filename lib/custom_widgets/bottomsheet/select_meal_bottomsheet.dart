import 'package:amtech_design/core/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/utils/app_colors.dart';

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
      return SizedBox(
        height: 400.h,
        child: const DefaultTabController(
          length: 4,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              // * Tab Bar
              TabBar(
                dividerColor: Colors.transparent,
                indicatorColor: Colors.white,
                labelColor: Colors.white,
                unselectedLabelColor: Colors.grey,
                labelStyle: TextStyle(fontWeight: FontWeight.bold),
                unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w600),
                tabs: [
                  Tab(text: "Salads"),
                  Tab(text: "Juice"),
                  Tab(text: "Shakes"),
                  Tab(text: "Favourites"),
                ],
              ),

              // * Tab Bar View
              Expanded(
                child: TabBarView(
                  children: [
                    Center(
                      child: Text("Salads Content"),
                    ),
                    Center(
                      child: Text("Juice Content"),
                    ),
                    Center(
                      child: Text("Shakes Content"),
                    ),
                    Center(
                      child: Text("Fav Content"),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
