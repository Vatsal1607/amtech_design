import 'package:amtech_design/core/utils/constant.dart';
import 'package:amtech_design/custom_widgets/appbar/custom_appbar_with_center_title.dart';
import 'package:amtech_design/custom_widgets/buttons/custom_button.dart';
import 'package:amtech_design/modules/feedback/feedback_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../core/utils/app_colors.dart';
import '../../core/utils/constants/keys.dart';
import '../../services/local/shared_preferences_service.dart';

class FeedbackPage extends StatelessWidget {
  const FeedbackPage({super.key});

  @override
  Widget build(BuildContext context) {
    String accountType =
        sharedPrefsService.getString(SharedPrefsKeys.accountType) ?? '';
    final provider = Provider.of<FeedbackProvider>(context, listen: false);
    return Scaffold(
      appBar: CustomAppbarWithCenterTitle(
        title: 'Feedback',
        accountType: accountType,
      ),
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 20.h),
            child: Column(
              children: [
                Text(
                  'Share Your Thoughts With Us! Let Us Know How We Can Improve Your Experience With 135 Degrees. Your Feedback Helps Us Serve You Better.',
                  textAlign: TextAlign.justify,
                  style: GoogleFonts.publicSans(
                    fontSize: 12.sp,
                    color: getColorAccountType(
                      accountType: accountType,
                      businessColor: AppColors.primaryColor,
                      personalColor: AppColors.darkGreenGrey,
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
                TextFormField(
                  controller: provider.feedbackController,
                  maxLines: 7,
                  style: GoogleFonts.publicSans(
                    fontSize: 15.sp,
                    color: getColorAccountType(
                      accountType: accountType,
                      businessColor: AppColors.primaryColor.withOpacity(.5),
                      personalColor: AppColors.darkGreenGrey.withOpacity(.5),
                    ),
                  ),
                  decoration: InputDecoration(
                    hintText: 'Enter Your Feedback Here...',
                    filled: true,
                    fillColor: AppColors.seaShell,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide: BorderSide(
                        color: getColorAccountType(
                          accountType: accountType,
                          businessColor: AppColors.primaryColor,
                          personalColor: AppColors.darkGreenGrey,
                        ),
                        width: 2.w,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide: BorderSide(
                        color: getColorAccountType(
                          accountType: accountType,
                          businessColor: AppColors.primaryColor,
                          personalColor: AppColors.darkGreenGrey,
                        ),
                        width: 2.w,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 50.h,
            left: 32.w,
            right: 32.w,
            child: CustomButton(
              height: 55.h,
              onTap: () {},
              text: 'submit',
              bgColor: getColorAccountType(
                accountType: accountType,
                businessColor: AppColors.primaryColor,
                personalColor: AppColors.darkGreenGrey,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
