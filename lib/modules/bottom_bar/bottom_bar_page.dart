import 'package:amtech_design/core/utils/app_colors.dart';
import 'package:amtech_design/core/utils/constant.dart';
import 'package:amtech_design/custom_widgets/svg_icon.dart';
import 'package:amtech_design/modules/billing/billing_page.dart';
import 'package:amtech_design/modules/blog/blog_page.dart';
import 'package:amtech_design/modules/menu/menu_page.dart';
import 'package:amtech_design/modules/reorder/reorder_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../core/utils/constants/shared_prefs_keys.dart';
import '../../core/utils/strings.dart';
import '../../services/local/shared_preferences_service.dart';
import 'bottom_bar_provider.dart';

class BottomBarPage extends StatelessWidget {
  final List<Widget> _screens = [
    const MenuPage(),
    const ReorderPage(),
    const BillingPage(),
    const BlogPage(),
  ];

  BottomBarPage({super.key});

  @override
  Widget build(BuildContext context) {
    String accountType = 'business'; //Todo replace with bottom data
    // sharedPrefsService.getString(SharedPrefsKeys.accountType) ??
    //     '';
    debugPrint('$accountType is from bottombar page (build)');
    return Scaffold(
      body: Consumer<BottomBarProvider>(
        builder: (context, provider, child) {
          // Display the screen based on the selected index
          return _screens[provider.selectedIndex];
        },
      ),
      bottomNavigationBar: Consumer<BottomBarProvider>(
        builder: (context, provider, child) {
          return Theme(
            data: ThemeData(
              splashColor: Colors.transparent, // Removes splash effect
              highlightColor: Colors.transparent, // Removes highlight effect
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Top Indicator
                // AnimatedContainer(
                //   duration: const Duration(milliseconds: 300),
                //   margin: EdgeInsets.only(
                //       left: (provider.selectedIndex *
                //           MediaQuery.of(context).size.width /
                //           4),
                //       right: (MediaQuery.of(context).size.width / 4) *
                //           (3 - provider.selectedIndex)),
                //   child: Container(
                //     height: 4.h,
                //     color: getColorAccountType(
                //       accountType: accountType,
                //       businessColor: AppColors.seaShell,
                //       personalColor: AppColors.seaMist,
                //     ),
                //   ),
                // ),
                BottomNavigationBar(
                  type: BottomNavigationBarType.fixed,
                  backgroundColor: getColorAccountType(
                    accountType: accountType,
                    businessColor: AppColors.primaryColor,
                    personalColor: AppColors.darkGreenGrey,
                  ),
                  currentIndex: provider.selectedIndex,
                  onTap: (index) => provider.updateIndex(index),
                  selectedItemColor: getColorAccountType(
                    accountType: accountType,
                    businessColor: AppColors.white,
                    personalColor: AppColors.seaMist,
                  ), // Color for the selected label and icon

                  unselectedItemColor: getColorAccountType(
                    accountType: accountType,
                    businessColor: AppColors.disabledColor,
                    personalColor: AppColors.bayLeaf,
                  ), // Color for unselected labels and icons
                  selectedLabelStyle: TextStyle(
                    height: 2.h, // Adds vertical padding to the label
                  ),
                  unselectedLabelStyle: TextStyle(
                    height: 2.h, // Adds vertical padding to the label
                  ),
                  items: [
                    BottomNavigationBarItem(
                      icon: SvgIcon(
                        icon: IconStrings.menu,
                        color: provider.selectedIndex == 0
                            ? getColorAccountType(
                                accountType: accountType,
                                businessColor: AppColors.white,
                                personalColor: AppColors.seaMist,
                              )
                            : getColorAccountType(
                                accountType: accountType,
                                businessColor: AppColors.disabledColor,
                                personalColor: AppColors.bayLeaf,
                              ),
                      ),
                      label: 'MENU',
                    ),
                    BottomNavigationBarItem(
                      icon: SvgIcon(
                        icon: IconStrings.reorder,
                        color: provider.selectedIndex == 1
                            ? getColorAccountType(
                                accountType: accountType,
                                businessColor: AppColors.white,
                                personalColor: AppColors.seaMist,
                              )
                            : getColorAccountType(
                                accountType: accountType,
                                businessColor: AppColors.disabledColor,
                                personalColor: AppColors.bayLeaf,
                              ),
                      ),
                      label: 'REORDER',
                    ),
                    BottomNavigationBarItem(
                      icon: SvgIcon(
                        icon: IconStrings.billing,
                        color: provider.selectedIndex == 2
                            ? getColorAccountType(
                                accountType: accountType,
                                businessColor: AppColors.white,
                                personalColor: AppColors.seaMist,
                              )
                            : getColorAccountType(
                                accountType: accountType,
                                businessColor: AppColors.disabledColor,
                                personalColor: AppColors.bayLeaf,
                              ),
                      ),
                      label: 'BILLING',
                    ),
                    BottomNavigationBarItem(
                      icon: SvgIcon(
                        icon: IconStrings.blog,
                        color: provider.selectedIndex == 3
                            ? getColorAccountType(
                                accountType: accountType,
                                businessColor: AppColors.white,
                                personalColor: AppColors.seaMist,
                              )
                            : getColorAccountType(
                                accountType: accountType,
                                businessColor: AppColors.disabledColor,
                                personalColor: AppColors.bayLeaf,
                              ),
                      ),
                      label: 'BLOG',
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
