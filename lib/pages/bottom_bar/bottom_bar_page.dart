import 'package:amtech_design/core/utils/app_colors.dart';
import 'package:amtech_design/custom_widgets/svg_icon.dart';
import 'package:amtech_design/pages/billing/billing_page.dart';
import 'package:amtech_design/pages/blog/blog_page.dart';
import 'package:amtech_design/pages/menu/menu_page.dart';
import 'package:amtech_design/pages/reorder/reorder_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/utils/strings.dart';
import 'bottom_bar_provider.dart';

class BottomBarPage extends StatelessWidget {
  final List<Widget> _screens = [
    const MenuPage(),
    const ReorderPage(),
    const BillingPage(),
    const BlogPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<BottomBarProvider>(
        builder: (context, provider, child) {
          // Display the screen based on the selected index
          return _screens[provider.selectedIndex];
        },
      ),
      bottomNavigationBar: Consumer<BottomBarProvider>(
        builder: (context, provider, child) {
          return BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: AppColors.primaryColor,
            currentIndex: provider.selectedIndex,
            onTap: (index) => provider.updateIndex(index),
            selectedItemColor:
                Colors.white, // Color for the selected label and icon
            unselectedItemColor: AppColors
                .disabledColor, // Color for unselected labels and icons
            selectedLabelStyle: const TextStyle(
              height: 2.0, // Adds vertical padding to the label
            ),
            unselectedLabelStyle: const TextStyle(
              height: 2.0, // Adds vertical padding to the label
            ),
            items: [
              BottomNavigationBarItem(
                icon: SvgIcon(
                  icon: IconStrings.menu,
                  color: provider.selectedIndex == 0
                      ? AppColors.white
                      : AppColors.disabledColor,
                ),
                label: 'MENU',
              ),
              BottomNavigationBarItem(
                icon: SvgIcon(
                  icon: IconStrings.reorder,
                  color: provider.selectedIndex == 1
                      ? AppColors.white
                      : AppColors.disabledColor,
                ),
                label: 'REORDER',
              ),
              BottomNavigationBarItem(
                icon: SvgIcon(
                  icon: IconStrings.billing,
                  color: provider.selectedIndex == 2
                      ? AppColors.white
                      : AppColors.disabledColor,
                ),
                label: 'BILLING',
              ),
              BottomNavigationBarItem(
                icon: SvgIcon(
                  icon: IconStrings.blog,
                  color: provider.selectedIndex == 3
                      ? AppColors.white
                      : AppColors.disabledColor,
                ),
                label: 'BLOG',
              ),
            ],
          );
        },
      ),
    );
  }
}
