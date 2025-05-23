import 'dart:developer';
import 'package:amtech_design/core/utils/strings.dart';
import 'package:amtech_design/custom_widgets/appbar/custom_appbar_with_center_title.dart';
import 'package:amtech_design/custom_widgets/custom_confirm_dialog.dart';
import 'package:amtech_design/custom_widgets/svg_icon.dart';
import 'package:amtech_design/modules/auth/login/login_provider.dart';
import 'package:amtech_design/modules/menu/menu_provider.dart';
import 'package:amtech_design/modules/profile/profile_provider.dart';
import 'package:amtech_design/modules/profile/widgets/profile_tile.dart';
import 'package:cached_network_image/cached_network_image.dart';
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
    String accountType =
        sharedPrefsService.getString(SharedPrefsKeys.accountType) ?? '';
    String userContact =
        sharedPrefsService.getString(SharedPrefsKeys.userContact) ?? '';
    final provider = Provider.of<ProfileProvider>(context, listen: false);
    final loginProvider = Provider.of<LoginProvider>(context, listen: false);

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
                    provider.logout(context: context); // * LogOut
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
                      child: Consumer<MenuProvider>(
                          builder: (context, menuProvider, child) {
                        final imageUrl =
                            menuProvider.homeMenuResponse?.data?.profileImage;
                        return (imageUrl == null || imageUrl.isEmpty)
                            ? SizedBox(
                                height: 30.h,
                                width: 30.w,
                                child: Image.asset(
                                  ImageStrings.defaultAvatar,
                                  color: AppColors.white,
                                  fit: BoxFit.contain,
                                ),
                              )
                            : CachedNetworkImage(
                                imageUrl: imageUrl ?? '',
                                fit: BoxFit.cover,
                                placeholder: (context, url) =>
                                    CircularProgressIndicator(
                                  color: getColorAccountType(
                                    accountType: accountType,
                                    businessColor: AppColors.primaryColor,
                                    personalColor: AppColors.darkGreenGrey,
                                  ),
                                ),
                                errorWidget: (context, url, error) =>
                                    const Icon(
                                  Icons.account_circle,
                                  size: 48,
                                  color: Colors.grey,
                                ),
                              );
                      }),
                    ),
                  ),
                  SizedBox(width: 24.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Consumer<MenuProvider>(
                            builder: (context, menuProvider, child) {
                              final businessName = menuProvider
                                      .homeMenuResponse?.data?.businessName ??
                                  '';
                              final firstName = menuProvider
                                      .homeMenuResponse?.data?.firstName ??
                                  '';
                              final lastName = menuProvider
                                      .homeMenuResponse?.data?.lastName ??
                                  '';
                              return Text(
                                accountType == 'business'
                                    ? businessName
                                    : '$firstName $lastName',
                                style: GoogleFonts.publicSans(
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w700,
                                  color: getColorAccountType(
                                    accountType: accountType,
                                    businessColor: AppColors.primaryColor,
                                    personalColor: AppColors.darkGreenGrey,
                                  ),
                                ),
                              );
                            },
                          ),
                          SizedBox(width: 10.w),
                          const SvgIcon(
                            icon: IconStrings.verifiedUser,
                            color: AppColors.disabledColor,
                          ),
                        ],
                      ),
                      Text(
                        accountType == 'business'
                            ? 'Business Account'
                            : 'Personal Account',
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
                        /// * validateContactInSecondaryAccess
                        onTap: userContact.isNotEmpty &&
                                !loginProvider.validateContactInSecondaryAccess(
                                    int.parse(userContact))
                            ? () {
                                Navigator.pushNamed(
                                    context, Routes.editProfile);
                              }
                            : () {
                                log('NOT AUTHORIZED');
                              },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 3.w),
                          child: Text(
                            'EDIT PROFILE',
                            style: GoogleFonts.publicSans(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w700,
                              color: getColorAccountType(
                                accountType: accountType,
                                businessColor: AppColors.disabledColor,
                                personalColor: AppColors.bayLeaf,
                              ),
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
                  if (accountType == 'business' &&
                      userContact.isNotEmpty &&
                      !loginProvider.validateContactInSecondaryAccess(
                          int.parse(userContact)))
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
                  if (accountType == 'business' &&
                      userContact.isNotEmpty &&
                      !loginProvider.validateContactInSecondaryAccess(
                          int.parse(userContact)))
                    SizedBox(height: 20.h),
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
