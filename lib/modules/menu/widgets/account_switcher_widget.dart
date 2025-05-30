import 'dart:developer';

import 'package:amtech_design/modules/auth/login/login_provider.dart';
import 'package:amtech_design/modules/menu/menu_provider.dart';
import 'package:amtech_design/modules/menu/widgets/account_switch_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/constant.dart';
import '../../../core/utils/constants/keys.dart';
import '../../../routes.dart';
import '../../../services/local/shared_preferences_service.dart';
import 'account_tile.dart';

class AccountSwitcherWidget extends StatelessWidget {
  final String accountType;
  const AccountSwitcherWidget({
    super.key,
    required this.accountType,
  });

  @override
  Widget build(BuildContext context) {
    final menuProvider = Provider.of<MenuProvider>(context, listen: false);
    return Consumer<MenuProvider>(
      builder: (context, _, child) => AnimatedContainer(
        height: menuProvider.panelHeight.h,
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.only(left: 32.w, right: 32.w, top: 60.h),
        decoration: BoxDecoration(
          color: getColorAccountType(
            accountType: accountType,
            businessColor: AppColors.primaryColor,
            personalColor: AppColors.darkGreenGrey,
          ),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(35.r),
            bottomRight: Radius.circular(35.r),
          ),
        ),
        child: menuProvider.isLoadingAccount
            ? const ProfileShimmerLoader()
            : ListView(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: menuProvider.accounts?.map((account) {
                      return AccountTile(
                        onTap: () async {
                          final provider = Provider.of<LoginProvider>(context,
                              listen: false);
                          await provider
                              .userLogin(
                            context: context,
                            accountType: account.userType.toString(),
                            isAccountSwitch: true,
                            accountSwitchContact: account.contact.toString(),
                          )
                              .then((isSuccess) async {
                            if (isSuccess) {
                              sharedPrefsService.setString(
                                SharedPrefsKeys.accountType,
                                account.userType.toString(),
                              );
                              //reset globalKey prevent Duplicate key
                              // menuProvider.dynamicKeys = {};
                              menuProvider.dynamicKeys.clear();
                              menuProvider.panelHeight = 0.0;
                              WidgetsBinding.instance.addPostFrameCallback((_) {
                                // * Replace all previous routes & Navigate to Bottombar page
                                Navigator.pushNamedAndRemoveUntil(
                                  context,
                                  Routes.bottomBarPage,
                                  (Route<dynamic> route) => false,
                                );
                                // menuProvider.homeMenuApi(); //* API
                              });
                            }
                          });
                        },
                        title: '${account.name}',
                        subTitle: '${account.userType}'.toUpperCase(),
                        isCurrentAccount: sharedPrefsService
                                .getString(SharedPrefsKeys.accountType) ==
                            account.userType,
                        profilePic: account.image ?? '',
                      );
                    }).toList() ??
                    [],
                // children: [
                //   AccountTile(
                //     onTap: () {
                // * Change Save account type
                //       sharedPrefsService.setString(
                //         SharedPrefsKeys.accountType,
                //         Strings.accountTypeBusiness,
                //       );
                //     },
                //     title: 'AMTech Design',
                //     subTitle: 'Business Account',
                //     isCurrentAccount:
                //         sharedPrefsService.getString(SharedPrefsKeys.accountType) ==
                //             'business',
                //     profilePic: ImageStrings.logo,
                //   ),
                //   AccountTile(
                //     onTap: () {
                //       // * Change Save account type
                //       sharedPrefsService.setString(
                //         SharedPrefsKeys.accountType,
                //         Strings.accountTypePersonal,
                //       );
                //     },
                //     title: 'Anup Parekh',
                //     subTitle: 'Personal Account',
                //     isCurrentAccount:
                //         sharedPrefsService.getString(SharedPrefsKeys.accountType) ==
                //             'personal',
                //     profilePic: ImageStrings.personalPic,
                //   ),
                // ],
              ),
      ),
    );
  }
}
