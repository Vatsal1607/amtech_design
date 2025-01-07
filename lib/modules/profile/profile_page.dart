import 'package:amtech_design/core/utils/strings.dart';
import 'package:amtech_design/custom_widgets/appbar/custom_appbar_with_center_title.dart';
import 'package:amtech_design/custom_widgets/custom_confirm_dialog.dart';
import 'package:amtech_design/custom_widgets/svg_icon.dart';
import 'package:amtech_design/modules/profile/profile_provider.dart';
import 'package:amtech_design/modules/profile/widgets/profile_tile.dart';
import 'package:amtech_design/modules/ratings/ratings_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../core/utils/app_colors.dart';
import '../../core/utils/constant.dart';
import '../../core/utils/constants/keys.dart';
import '../../routes.dart';
import '../../services/local/shared_preferences_service.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    String accountType = 'business';
    // sharedPrefsService.getString(SharedPrefsKeys.accountType) ?? '';
    final provider = Provider.of<ProfileProvider>(context, listen: false);

    return Scaffold(
      backgroundColor: getColorAccountType(
        accountType: accountType,
        businessColor: AppColors.seaShell,
        personalColor: AppColors.seaMist,
      ),
      appBar: CustomAppbarWithCenterTitle(
        accountType: accountType,
        title: 'Account',
        backgroundColor: getColorAccountType(
          accountType: accountType,
          businessColor: AppColors.seaShell,
          personalColor: AppColors.seaMist,
        ),
      ),
      floatingActionButton: GestureDetector(
        onTap: () {
          showDialog(
            context: context,
            builder: (context) {
              return Consumer<ProfileProvider>(
                builder: (context, _, child) => CustomConfirmDialog(
                  accountType: accountType,
                  onTapCancel: () => Navigator.pop(context),
                  onTapYes: () {
                    // * LogOut
                    provider.logout(context: context);
                  },
                  yesBtnText: 'LOGOUT',
                  isLoading: provider.isLoading,
                  title: 'ARE YOU SURE?',
                  subTitle: 'You really want to Logout?',
                ),
              );
            },
          );
        },
        child: Container(
          height: 50.h,
          width: 120.w,
          decoration: BoxDecoration(
            color: getColorAccountType(
                accountType: accountType,
                businessColor: AppColors.primaryColor,
                personalColor: AppColors.darkGreenGrey),
            borderRadius: BorderRadius.circular(30.r),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgIcon(
                icon: IconStrings.logout,
                color: getColorAccountType(
                  accountType: accountType,
                  businessColor: AppColors.seaShell,
                  personalColor: AppColors.seaMist,
                ),
              ),
              SizedBox(width: 13.w),
              Text(
                'Logout',
                style: GoogleFonts.publicSans(
                  color: AppColors.seaShell,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 33.w, right: 33.w, top: 30.h),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 80.h,
                    width: 80.w,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColors.primaryColor,
                        width: 2.0,
                      ),
                    ),
                    child: ClipOval(
                      child: Image.asset(
                        ImageStrings.logo,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(width: 24.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            'AMTech Design',
                            style: GoogleFonts.publicSans(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w700,
                              color: getColorAccountType(
                                accountType: accountType,
                                businessColor: AppColors.primaryColor,
                                personalColor: AppColors.darkGreenGrey,
                              ),
                            ),
                          ),
                          SizedBox(width: 10.w),
                          const SvgIcon(
                            icon: IconStrings.verifiedUser,
                            color: AppColors.disabledColor,
                          ),
                        ],
                      ),
                      Text(
                        'Business Account',
                        style: GoogleFonts.publicSans(
                          color: getColorAccountType(
                            accountType: accountType,
                            businessColor: AppColors.primaryColor,
                            personalColor: AppColors.darkGreenGrey,
                          ),
                          fontWeight: FontWeight.w400,
                          fontSize: 15.sp,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, Routes.editProfile);
                        },
                        child: Text(
                          'EDIT PROFILE',
                          style: GoogleFonts.publicSans(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w700,
                            // color: AppColors.disabledColor,
                            color: getColorAccountType(
                              accountType: accountType,
                              businessColor: AppColors.disabledColor,
                              personalColor: AppColors.bayLeaf,
                            ),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            SizedBox(height: 29.h),
            Divider(
              height: 2.h,
              indent: 33.w,
              endIndent: 33.w,
              color: getColorAccountType(
                accountType: accountType,
                businessColor: AppColors.disabledColor,
                personalColor: AppColors.bayLeaf,
              ),
            ),
            SizedBox(height: 29.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 33.w),
              child: Column(
                children: [
                  // * Consider tile Index 0
                  Consumer<ProfileProvider>(
                    builder: (context, _, child) => ProfileTile(
                      accountType: accountType,
                      onTap: () {
                        provider.updateTileIndex(0);
                        Navigator.pop(context);
                      },
                      isSelected: provider.selectedTileIndex == 0,
                      title: 'Home',
                      icon: IconStrings.home,
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Consumer<ProfileProvider>(
                    builder: (context, _, child) => ProfileTile(
                      // * Consider tile Index 1
                      accountType: accountType,
                      onTap: () {
                        provider.updateTileIndex(1);
                        Navigator.pushNamed(context, Routes.favoriteItems);
                      },
                      isSelected: provider.selectedTileIndex == 1,
                      title: 'Favorite Products',
                      icon: IconStrings.favorite,
                    ),
                  ),
                  SizedBox(height: 20.h),
                  if (accountType == 'business')
                    Consumer<ProfileProvider>(
                      builder: (context, _, child) => ProfileTile(
                        // * Consider tile Index 2
                        accountType: accountType,
                        onTap: () {
                          provider.updateTileIndex(2);
                          Navigator.pushNamed(context, Routes.authorizedEmp);
                        },
                        isSelected: provider.selectedTileIndex == 2,
                        title: 'Authorized Employees',
                        icon: IconStrings.authorizedEmp,
                      ),
                    ),
                  if (accountType == 'business')
                    SizedBox(
                      height: 20.h,
                    ),
                  Consumer<ProfileProvider>(
                    builder: (context, _, child) => ProfileTile(
                      // * Consider tile Index 3
                      accountType: accountType,
                      onTap: () {
                        provider.updateTileIndex(3);
                        Navigator.pushNamed(context, Routes.feedback);
                      },
                      isSelected: provider.selectedTileIndex == 3,
                      title: 'Feedback',
                      icon: IconStrings.feedback,
                    ),
                  ),
                  SizedBox(height: 20.h),

                  Consumer<ProfileProvider>(
                    builder: (context, _, child) => ProfileTile(
                      // * Consider tile Index 4
                      accountType: accountType,
                      onTap: () {
                        provider.updateTileIndex(4);
                        Navigator.pushNamed(context, Routes.aboutUs);
                      },
                      isSelected: provider.selectedTileIndex == 4,
                      title: 'About Us',
                      icon: IconStrings.aboutUs,
                    ),
                  ),
                  // SizedBox(height: 20.h),

                  // * Ratings view
                  // // ! TEMP
                  // ProfileTile(
                  //   accountType: accountType,
                  //   onTap: () {
                  //     // * showDialog(
                  //     showGeneralDialog(
                  //       context: context,
                  //       // barrierDismissible: true,
                  //       // * builder: (context) => const RatingsPage(),
                  //       pageBuilder: (context, animation, secondaryAnimation) {
                  //         return const RatingsPage();
                  //       },
                  //     );
                  //   },
                  //   title: 'TEMP RATING UI VIEW --> ⭐',
                  //   icon: IconStrings.aboutUs,
                  // ),
                  // // !
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
