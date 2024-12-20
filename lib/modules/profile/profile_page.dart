import 'package:amtech_design/core/utils/strings.dart';
import 'package:amtech_design/custom_widgets/appbar/custom_appbar_with_center_title.dart';
import 'package:amtech_design/custom_widgets/svg_icon.dart';
import 'package:amtech_design/modules/profile/widgets/profile_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/utils/app_colors.dart';
import '../../core/utils/constant.dart';
import '../../routes.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    String accountType = 'business'; // Todo imp set dynamic
    // sharedPrefsService.getString(SharedPrefsKeys.accountType) ?? '';
    return Scaffold(
      backgroundColor: getColorAccountType(
        accountType: accountType,
        businessColor: AppColors.seaShell,
        personalColor: AppColors.seaMist,
      ),
      appBar: CustomAppbarWithCenterTitle(
        title: 'Account',
        backgroundColor: getColorAccountType(
          accountType: accountType,
          businessColor: AppColors.seaShell,
          personalColor: AppColors.seaMist,
        ),
      ),
      floatingActionButton: Container(
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
                fontSize: 12.sp,
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 33.w, right: 33.w, top: 30.h),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 80.h,
                  width: 80.w,
                  decoration: BoxDecoration(
                    // boxShadow: kDropShadow,
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
                    Text(
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
                ProfileTile(
                  accountType: accountType,
                  onTap: () {
                    debugPrint('pressed');
                  },
                  title: 'Home',
                  icon: IconStrings.home,
                  bgColor: getColorAccountType(
                    accountType: accountType,
                    businessColor: AppColors.primaryColor,
                    personalColor: AppColors.darkGreenGrey,
                  ),
                ),
                SizedBox(height: 20.h),
                ProfileTile(
                  accountType: accountType,
                  onTap: () {
                    debugPrint('pressed');
                  },
                  title: 'Favorite Products',
                  icon: IconStrings.favorite,
                ),
                SizedBox(height: 20.h),
                ProfileTile(
                  accountType: accountType,
                  onTap: () {
                    Navigator.pushNamed(context, Routes.authorizedEmp);
                  },
                  title: 'Authorized Employees',
                  icon: IconStrings.authorizedEmp,
                ),
                SizedBox(height: 20.h),
                ProfileTile(
                  accountType: accountType,
                  onTap: () {
                    debugPrint('pressed');
                  },
                  title: 'Feedback',
                  icon: IconStrings.feedback,
                ),
                SizedBox(height: 20.h),
                ProfileTile(
                  accountType: accountType,
                  onTap: () {
                    debugPrint('pressed');
                  },
                  title: 'About Us',
                  icon: IconStrings.aboutUs,
                ),
                SizedBox(height: 20.h),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
