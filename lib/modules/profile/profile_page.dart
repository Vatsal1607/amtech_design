import 'package:amtech_design/core/utils/strings.dart';
import 'package:amtech_design/custom_widgets/appbar/custom_appbar.dart';
import 'package:amtech_design/custom_widgets/svg_icon.dart';
import 'package:amtech_design/modules/profile/widgets/profile_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/utils/app_colors.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.seaShell,
      appBar: AppBar(
        backgroundColor: AppColors.seaShell,
        leading: Container(
          height: 48.h,
          width: 48.w,
          margin: EdgeInsets.only(left: 20.w),
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.primaryColor,
          ),
          child: SvgIcon(icon: IconStrings.arrowBack),
        ),
        title: Text(
          'Account',
          style: GoogleFonts.publicSans(
            fontSize: 24.sp,
            fontWeight: FontWeight.w700,
            color: AppColors.primaryColor,
          ),
        ),
        centerTitle: true,
      ),
      floatingActionButton: Container(
            height: 50.h,
            width: 100.w,
            decoration: BoxDecoration(
              color: AppColors.primaryColor,
              
              borderRadius: BorderRadius.circular(30.r),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgIcon(
                  icon:
                       IconStrings.logout,
                ),
                SizedBox(width: 8.w),
                Text(
                   'Logout',
                  style: GoogleFonts.publicSans(
                    color: AppColors.white,
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
                            color: AppColors.primaryColor,
                          ),
                        ),
                        SizedBox(width: 10.w),
                        SvgIcon(
                          icon: IconStrings.verifiedUser,
                          color: AppColors.disabledColor,
                        ),
                      ],
                    ),
                    Text(
                      'Business Account',
                      style: GoogleFonts.publicSans(
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.w400,
                        fontSize: 15.sp,
                      ),
                    ),
                    Text(
                      'EDIT PROFILE',
                      style: GoogleFonts.publicSans(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w700,
                        color: AppColors.disabledColor,
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
            color: AppColors.disabledColor,
          ),
          SizedBox(height: 29.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 33.w),
            child: Column(
              children: [
                ProfileTile(
                  title: 'Home',
                  icon: IconStrings.home,
                ),
                SizedBox(height: 20.h),
                ProfileTile(
                  title: 'Favorite Products',
                  icon: IconStrings.favorite,
                ),
                SizedBox(height: 20.h),
                ProfileTile(
                  title: 'Authorized Employees',
                  icon: IconStrings.authorizedEmp,
                ),
                SizedBox(height: 20.h),
                ProfileTile(
                  title: 'Feedback',
                  icon: IconStrings.feedback,
                ),
                SizedBox(height: 20.h),
                ProfileTile(
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
