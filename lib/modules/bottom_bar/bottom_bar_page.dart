import 'package:amtech_design/core/utils/app_colors.dart';
import 'package:amtech_design/core/utils/constant.dart';
import 'package:amtech_design/core/utils/constants/keys.dart';
import 'package:amtech_design/custom_widgets/svg_icon.dart';
import 'package:amtech_design/modules/billing/billing_page.dart';
import 'package:amtech_design/modules/menu/menu_page.dart';
import 'package:amtech_design/modules/menu/widgets/account_selection_widget.dart';
import 'package:amtech_design/modules/reorder/reorder_page.dart';
import 'package:amtech_design/services/local/shared_preferences_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../core/utils/strings.dart';
import '../menu/menu_provider.dart';
import 'bottom_bar_provider.dart';

class BottomBarPage extends StatefulWidget {
  BottomBarPage({super.key});

  @override
  State<BottomBarPage> createState() => _BottomBarPageState();
}

class _BottomBarPageState extends State<BottomBarPage> {
  late ScrollController _scrollController;
  late List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);

    _screens = [
      MenuPage(scrollController: _scrollController),
      ReorderPage(scrollController: _scrollController),
      BillingPage(scrollController: _scrollController),
    ];
  }

  void _onScroll() {
    final provider = Provider.of<BottomBarProvider>(context, listen: false);
    if (_scrollController.position.userScrollDirection ==
        ScrollDirection.reverse) {
      provider.setBottomBarVisibility(false);
    } else if (_scrollController.position.userScrollDirection ==
        ScrollDirection.forward) {
      provider.setBottomBarVisibility(true);
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String accountType = 'business';
    // sharedPrefsService.getString(SharedPrefsKeys.accountType) ?? '';
    final menuProvider = Provider.of<MenuProvider>(context, listen: false);
    debugPrint(
        'User Token is: ${sharedPrefsService.getString(SharedPrefsKeys.userToken.toString())}');

    return Scaffold(
      body: Stack(
        children: [
          GestureDetector(
            onTap: menuProvider.onTapOutsideAccountUI,
            child: Consumer<BottomBarProvider>(
              builder: (context, provider, child) {
                return _screens[provider.selectedIndex];
              },
            ),
          ),
          AccountSelectionWidget(
            accountType: accountType,
          ),
        ],
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
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  height: provider.isBottomBarVisible
                      ? kBottomNavigationBarHeight + 15.h
                      : 0,
                  child: Wrap(
                    children: [
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
                          // * Blog Nav Item
                          // BottomNavigationBarItem(
                          //   icon: SvgIcon(
                          //     icon: IconStrings.blog,
                          //     color: provider.selectedIndex == 3
                          //         ? getColorAccountType(
                          //             accountType: accountType,
                          //             businessColor: AppColors.white,
                          //             personalColor: AppColors.seaMist,
                          //           )
                          //         : getColorAccountType(
                          //             accountType: accountType,
                          //             businessColor: AppColors.disabledColor,
                          //             personalColor: AppColors.bayLeaf,
                          //           ),
                          //   ),
                          //   label: 'BLOG',
                          // ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
