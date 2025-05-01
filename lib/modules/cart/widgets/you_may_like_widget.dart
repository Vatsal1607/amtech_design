import 'package:amtech_design/core/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/utils/app_colors.dart';
import '../../../models/home_menu_model.dart';

class YouMayLikeWidget extends StatelessWidget {
  final String accountType;
  final MenuItems item;
  const YouMayLikeWidget({
    super.key,
    required this.accountType,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.h,
      width: 100.w,
      decoration: BoxDecoration(
        border: Border.all(
            width: 2.w,
            color: getColorAccountType(
              accountType: accountType,
              businessColor: AppColors.primaryColor,
              personalColor: AppColors.darkGreenGrey,
            )),
        borderRadius: BorderRadius.circular(20.r),
        image: DecorationImage(
          image: NetworkImage(item.images?[0] ?? ''),
          fit: BoxFit.cover,
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
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(bottom: 10.h, left: 1.w, right: 1.w),
                child: Text(
                  '${item.itemName}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//* Add button UI (below of itemName)
// Container(
//   height: 20.h,
//   width: 72.0,
//   margin: EdgeInsets.only(bottom: 6.h),
//   decoration: BoxDecoration(
//     color: getColorAccountType(
//       accountType: accountType,
//       businessColor: AppColors.disabledColor,
//       personalColor: AppColors.bayLeaf,
//     ),
//     borderRadius: BorderRadius.circular(10.r),
//   ),
//   child: Center(
//     child: Text(
//       'ADD +',
//       style: GoogleFonts.publicSans(
//         fontSize: 10.sp,
//         fontWeight: FontWeight.bold,
//         color: getColorAccountType(
//           accountType: accountType,
//           businessColor: AppColors.primaryColor,
//           personalColor: AppColors.darkGreenGrey,
//         ),
//       ),
//     ),
//   ),
// )`
