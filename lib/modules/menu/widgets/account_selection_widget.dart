import 'package:amtech_design/modules/bottom_bar/bottom_bar_provider.dart';
import 'package:amtech_design/modules/menu/menu_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/constant.dart';
import '../../../core/utils/constants/keys.dart';
import '../../../core/utils/strings.dart';
import '../../../services/local/shared_preferences_service.dart';
import 'account_tile.dart';

class AccountSelectionWidget extends StatelessWidget {
  final String accountType;
  const AccountSelectionWidget({
    super.key,
    required this.accountType,
  });

  @override
  Widget build(BuildContext context) {
    final menuProvider = Provider.of<MenuProvider>(context, listen: false);
    final bottomBarProvider =
        Provider.of<BottomBarProvider>(context, listen: false);
    debugPrint(bottomBarProvider.selectedAccountType);
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
        child: ListView(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            AccountTile(
              onTap: () {
                // * Change Save account type
                sharedPrefsService.setString(
                  SharedPrefsKeys.accountType,
                  Strings.accountTypeBusiness,
                );
              },
              title: 'AMTech Design',
              subTitle: 'Business Account',
              isCurrentAccount:
                  sharedPrefsService.getString(SharedPrefsKeys.accountType) ==
                      'business',
              profilePic: ImageStrings.logo,
            ),
            AccountTile(
              onTap: () {
                // * Change Save account type
                sharedPrefsService.setString(
                  SharedPrefsKeys.accountType,
                  Strings.accountTypePersonal,
                );
              },
              title: 'Anup Parekh',
              subTitle: 'Personal Account',
              isCurrentAccount:
                  sharedPrefsService.getString(SharedPrefsKeys.accountType) ==
                      'personal',
              profilePic: ImageStrings.personalPic,
            ),
          ],
        ),
      ),
    );
  }
}
