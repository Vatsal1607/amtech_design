import 'package:amtech_design/custom_widgets/appbar/custom_sliver_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/utils/app_colors.dart';
import '../../core/utils/constant.dart';
import '../../core/utils/strings.dart';

class BlogPage extends StatelessWidget {
  const BlogPage({super.key});

  @override
  Widget build(BuildContext context) {
    String accountType = 'business'; // Todo imp set dynamic
    // sharedPrefsService.getString(SharedPrefsKeys.accountType) ?? '';
    return Scaffold(
      backgroundColor: getColorAccountType(
          accountType: accountType,
          businessColor: AppColors.seaShell,
          personalColor: AppColors.seaMist),
      body: CustomScrollView(
        slivers: [
          CustomSliverAppbar(accountType: accountType),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 1.sh / 1.3,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 105.h,
                      width: 105.w,
                      child: Image.asset(
                        ImageStrings.blogPng,
                        color: AppColors.primaryColor,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    SizedBox(
                      width: 270.w,
                      height: 120.h,
                      child: Text(
                        'Blogs',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.publicSans(
                          fontSize: 40.sp,
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
