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
        offset: provider.menuCategories?.length == 1
            ? const Offset(-10, -70)
            : const Offset(-10, -250),
        onSelected: (value) {
          provider.onSelectedMenuItem(value);
        },
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
        color: getColorAccountType(
          accountType: accountType,
          businessColor: AppColors.primaryColor,
          personalColor: AppColors.darkGreenGrey,
        ),
        itemBuilder: (context) {
          return [
            PopupMenuItem(
              enabled: false,
              child: Center(
                child: SizedBox(
                  width: 130.w, //* Box size
                  height: 250.h,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: provider.menuCategories != null &&
                              provider.menuCategories!.isNotEmpty
                          ? provider.menuCategories!.map(
                              (item) {
                                return PopupMenuItem<String>(
                                  value: item.categoryTitle,
                                  child: Container(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 15.h),
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: provider.selectedValue ==
                                              item.categoryTitle
                                          ? getColorAccountType(
                                              accountType: accountType,
                                              businessColor:
                                                  AppColors.disabledColor,
                                              personalColor: AppColors.bayLeaf,
                                            )
                                          : null,
                                      borderRadius: BorderRadius.circular(30.r),
                                    ),
                                    child: Text(
                                      item.categoryTitle?.toUpperCase() ??
                                          'UNKNOWN',
                                      textAlign: TextAlign.center,
                                      style: provider.selectedValue ==
                                              item.categoryTitle
                                          ? GoogleFonts.publicSans(
                                              fontSize: 15.sp,
                                              fontWeight: FontWeight.bold,
                                              color: getColorAccountType(
                                                accountType: accountType,
                                                businessColor:
                                                    AppColors.primaryColor,
                                                personalColor:
                                                    AppColors.darkGreenGrey,
                                              ),
                                            )
                                          : GoogleFonts.publicSans(
                                              fontSize: 15.sp,
                                              color: AppColors.seaShell,
                                            ),
                                    ),
                                  ),
                                );
                              },
                            ).toList()
                          : [
                              Center(
                                child: Padding(
                                  padding: EdgeInsets.all(20.w),
                                  child: Text(
                                    "No Categories Available",
                                    style: GoogleFonts.publicSans(
                                        color: Colors.white),
                                  ),
                                ),
                              )
                            ], // Show a message when categories are empty
                    ),
                  ),
                ),
              ),
            ),
          ];
        },
      ),
    );
  }
}
