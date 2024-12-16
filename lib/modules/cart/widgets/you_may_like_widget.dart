import 'package:amtech_design/core/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/strings.dart';

class YouMayLikeWidget extends StatelessWidget {
  const YouMayLikeWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    String accountType = 'personal'; // Todo imp set dynamic
    // sharedPrefsService.getString(SharedPrefsKeys.accountType) ?? '';
    return Container(
      height: 100.h,
      width: 100.w,
      decoration: BoxDecoration(
        border: Border.all(
            width: 2,
            color: getColorAccountType(
              accountType: accountType,
              businessColor: AppColors.primaryColor,
              personalColor: AppColors.darkGreenGrey,
            )),
        borderRadius: BorderRadius.circular(20.r),
        image: const DecorationImage(
          image: AssetImage(ImageStrings.masalaTea2),
        ),
      ),
      // * Note: this is reference for gradient blur of image
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.r),
        child: Stack(
          children: [
            // * Gradient Overlay // blur effect
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      getColorAccountType(
                        accountType: accountType,
                        businessColor: AppColors.primaryColor.withOpacity(0.1),
                        personalColor: AppColors.darkGreenGrey.withOpacity(0.1),
                      ),
                      getColorAccountType(
                        accountType: accountType,
                        businessColor: AppColors.primaryColor.withOpacity(0.7),
                        personalColor: AppColors.darkGreenGrey.withOpacity(0.7),
                      ),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: const [0.0, 0.5],
                  ),
                ),
              ),
            ),
            // * Foreground Content
            Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Masala Tea',
                    style: GoogleFonts.publicSans(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                      color: getColorAccountType(
                        accountType: accountType,
                        businessColor: AppColors.seaShell,
                        personalColor: AppColors.seaMist,
                      ),
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Container(
                    height: 20.h,
                    width: 72.0,
                    margin: EdgeInsets.only(bottom: 6.h),
                    decoration: BoxDecoration(
                      color: getColorAccountType(
                        accountType: accountType,
                        businessColor: AppColors.disabledColor,
                        personalColor: AppColors.bayLeaf,
                      ),
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Center(
                      child: Text(
                        'ADD +',
                        style: GoogleFonts.publicSans(
                          fontSize: 10.sp,
                          fontWeight: FontWeight.bold,
                          color: getColorAccountType(
                            accountType: accountType,
                            businessColor: AppColors.primaryColor,
                            personalColor: AppColors.darkGreenGrey,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
