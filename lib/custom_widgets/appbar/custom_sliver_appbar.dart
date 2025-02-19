import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../core/utils/app_colors.dart';
import '../../core/utils/constant.dart';
import '../../core/utils/strings.dart';
import '../../modules/menu/menu_provider.dart';
import '../../routes.dart';
import '../svg_icon.dart';

class CustomSliverAppbar extends StatelessWidget {
  const CustomSliverAppbar({
    super.key,
    required this.accountType,
  });

  final String accountType;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MenuProvider>(context, listen: false);
    return SliverAppBar(
      backgroundColor: getColorAccountType(
        accountType: accountType,
        businessColor: AppColors.seaShell,
        personalColor: AppColors.seaMist,
      ),
      centerTitle: true,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //! leading icon
          GestureDetector(
            onTap: () => Navigator.pushNamed(context, Routes.profile),
            onLongPress: provider.onVerticalDragDownLeading,
            child: Container(
              height: 48.h,
              width: 48.w,
              decoration: BoxDecoration(
                boxShadow: kDropShadow,
                color: Colors.black,
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.primaryColor,
                  width: 2.w,
                ),
              ),
              child: ClipOval(
                child: Image.asset(
                  ImageStrings.logo,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),

          //! center title content
          Column(
            children: [
              SizedBox(height: 2.h),
              Consumer<MenuProvider>(
                builder: (context, menuProvider, child) => Text(
                  menuProvider.getGreeting(),
                  style: GoogleFonts.publicSans(
                    color: getColorAccountType(
                      accountType: accountType,
                      businessColor: AppColors.primaryColor,
                      personalColor: AppColors.darkGreenGrey,
                    ),
                    fontSize: 15.sp,
                  ),
                ),
              ),
              Row(
                children: [
                  Consumer<MenuProvider>(
                    builder: (context, menuProvider, child) => Text(
                      accountType == 'business'
                          ? menuProvider.homeMenuResponse?.data?.businessName ??
                              ''
                          : '${menuProvider.homeMenuResponse?.data?.firstName ?? ''}'
                              ' ${menuProvider.homeMenuResponse?.data?.lastName ?? ''}',
                      style: GoogleFonts.publicSans(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.bold,
                        color: getColorAccountType(
                          accountType: accountType,
                          businessColor: AppColors.primaryColor,
                          personalColor: AppColors.darkGreenGrey,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 5.w),
                  const SvgIcon(
                    icon: IconStrings.verifiedUser,
                    color: AppColors.disabledColor,
                  ),
                ],
              ),
            ],
          ),

          //! trailing(action) icon
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, Routes.notification);
            },
            child: Container(
              height: 48.h,
              width: 48.w,
              decoration: BoxDecoration(
                boxShadow: kDropShadow,
                color: getColorAccountType(
                  accountType: accountType,
                  businessColor: AppColors.primaryColor,
                  personalColor: AppColors.darkGreenGrey,
                ),
                shape: BoxShape.circle,
              ),
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Center(
                      child: SvgIcon(
                        icon: IconStrings.notification2,
                        color: AppColors.white,
                        height: 20.h,
                        width: 20.w,
                      ),
                      // child: Text(
                      //   'data',
                      //   style: TextStyle(
                      //     color: AppColors.white,
                      //     fontSize: 10.sp,
                      //   ),
                      // ),
                    ),

                    // child: Icon(
                    //   Icons.notifications_outlined,
                    //   color: AppColors.white,
                    // ),
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Container(
                      height: 20.h,
                      width: 20.h,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.red,
                      ),
                      child: Center(
                        child: Text(
                          '99+',
                          style: GoogleFonts.publicSans(
                            fontSize: 8.sp,
                            fontWeight: FontWeight.bold,
                            color: AppColors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      automaticallyImplyLeading: false,
      // expandedHeight: 150.h,
      /// Bottom content of appbar
      // bottom: PreferredSize(
    );
  }
}
