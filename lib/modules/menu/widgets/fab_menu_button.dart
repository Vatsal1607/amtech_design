import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/constant.dart';
import '../../../core/utils/strings.dart';
import '../../../custom_widgets/svg_icon.dart';
import '../menu_provider.dart';

class FabMenuButton extends StatelessWidget {
  const FabMenuButton({
    super.key,
    required this.provider,
    required this.accountType,
  });

  final MenuProvider provider;
  final String accountType;

  @override
  Widget build(BuildContext context) {
    return Consumer<MenuProvider>(
      builder: (context, _, child) => PopupMenuButton(
        popUpAnimationStyle: AnimationStyle(
          duration: const Duration(seconds: 0),
        ),
        offset: provider.menuItemsName.length == 1
            ? const Offset(-10, -70)
            : const Offset(-10, -180),
        onSelected: provider.onSelectedMenuItem,
        onCanceled: provider.onCanceledMenuItem,
        onOpened: provider.onOpenedMenuItem,
        icon: Container(
          height: 50.h,
          width: 100.w,
          decoration: BoxDecoration(
            boxShadow: kDropShadow,
            color: provider.isMenuOpen
                ? AppColors.red
                : getColorAccountType(
                    accountType: accountType,
                    businessColor: AppColors.primaryColor,
                    personalColor: AppColors.darkGreenGrey,
                  ),
            borderRadius: BorderRadius.circular(30.r),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgIcon(
                icon:
                    provider.isMenuOpen ? IconStrings.close : IconStrings.menu,
                height: 18.h,
                width: 18.w,
              ),
              SizedBox(width: 8.w),
              Text(
                provider.isMenuOpen ? 'CLOSE' : 'MENU',
                style: GoogleFonts.publicSans(
                  color: AppColors.white,
                  fontSize: 12.sp,
                ),
              ),
            ],
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.r),
        ),
        color: AppColors.primaryColor,
        itemBuilder: (context) {
          return provider.menuItemsName.map<PopupMenuEntry<String>>(
            (item) {
              return PopupMenuItem(
                value: item,
                child: Container(
                  width: double.infinity,
                  padding:
                      EdgeInsets.symmetric(vertical: 15.h, horizontal: 23.w),
                  decoration: BoxDecoration(
                    color: provider.selectedValue == item
                        ? AppColors.disabledColor
                        : null,
                    borderRadius: BorderRadius.circular(30.r),
                  ),
                  child: Text(
                    item.toUpperCase(),
                    textAlign: TextAlign.center,
                    style: provider.selectedValue == item
                        ? GoogleFonts.publicSans(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryColor,
                          )
                        : GoogleFonts.publicSans(
                            fontSize: 15.sp,
                            color: AppColors.seaShell,
                          ),
                  ),
                ),
              );
            },
          ).toList();
        },
      ),
    );
  }
}
