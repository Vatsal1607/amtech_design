import 'package:amtech_design/core/utils/constants/keys.dart';
import 'package:amtech_design/custom_widgets/appbar/custom_appbar_with_center_title.dart';
import 'package:amtech_design/services/local/shared_preferences_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/utils/app_colors.dart';

class CreateSubscriptionPlanPage extends StatelessWidget {
  const CreateSubscriptionPlanPage({super.key});

  @override
  Widget build(BuildContext context) {
    final String accountType =
        sharedPrefsService.getString(SharedPrefsKeys.accountType) ?? '';
    return Scaffold(
      appBar: CustomAppbarWithCenterTitle(
        title: 'Create Your Daily Plan',
        leftPadTitle: 35.w,
        accountType: accountType,
      ),
      body: Column(
        children: [
          Divider(
            color: AppColors.primaryColor,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 22.w),
            child: Column(
              children: [
                Row(
                  children: [
                    Column(
                      children: [
                        Text(
                          'Select Units',
                          style: GoogleFonts.publicSans(
                            fontSize: 20.sp,
                            color: AppColors.primaryColor,
                          ),
                        ),
                        Text(
                          "1 Unit = 1 Item",
                          style: GoogleFonts.publicSans(
                            fontSize: 14.sp,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
