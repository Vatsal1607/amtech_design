import 'package:amtech_design/custom_widgets/size_modal_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/constant.dart';
import '../../../core/utils/strings.dart';
import '../../../custom_widgets/svg_icon.dart';

class ProductWidget extends StatelessWidget {
  final String image;
  final String name;
  final int index;
  final String accountType;
  const ProductWidget({
    super.key,
    required this.image,
    required this.name,
    required this.index,
    required this.accountType,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 150.h,
          width: 120.w,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(image),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(30.r),
            border: Border.all(
              color: AppColors.primaryColor, // Border color
              width: 2.w, // Border width
            ),
            // gradient: LinearGradient(
            //   begin: Alignment.topCenter,
            //   end: Alignment.bottomCenter,
            //   colors: [
            //     getColorAccountType(
            //       accountType: accountType,
            //       businessColor: AppColors.primaryColor.withOpacity(.15),
            //       personalColor: AppColors.darkGreenGrey.withOpacity(.3),
            //     ),
            //     getColorAccountType(
            //       accountType: accountType,
            //       businessColor: AppColors.disabledColor.withOpacity(.15),
            //       personalColor: AppColors.mineralGreen.withOpacity(0.3),
            //     ),
            //     AppColors.white.withOpacity(0.2),
            //   ],
            // ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  // Blur effect
                  Container(
                    width: 100.w,
                    height: 30.h,
                    // color: AppColors.white.withOpacity(.8),
                    decoration: const BoxDecoration(
                      // boxShadow: [
                      //   BoxShadow(
                      //     color: Colors.black.withOpacity(0.1),
                      //     blurRadius: 10, // Blur effect
                      //     offset: const Offset(4, 4),
                      //   ),
                      // ],
                      // color: AppColors.seaShell,
                    ),
                  ),
                  Text(
                    name.toUpperCase(),
                    maxLines: 1,
                    overflow: TextOverflow.visible,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.publicSans(
                      fontWeight: FontWeight.bold,
                      fontSize: 12.sp,
                      color: getColorAccountType(
                        accountType: accountType,
                        businessColor: AppColors.primaryColor,
                        personalColor: AppColors.darkGreenGrey,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8.h),
            ],
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Align(
            alignment: Alignment.bottomCenter,
            // Add button of Product widget
            child: GestureDetector(
              onTap: () {
                debugPrint('Add button pressed at index $index');
                // Custom Size bottomsheet
                showSizeModalBottomSheet(context: context);

                /// showSnackbar(context, '{count} ITEMS ADDED');
              },
              child: Container(
                padding: EdgeInsets.symmetric(
                  vertical: 3.h,
                  horizontal: 8.w,
                ),
                decoration: BoxDecoration(
                  color: getColorAccountType(
                    accountType: accountType,
                    businessColor: AppColors.primaryColor,
                    personalColor: AppColors.darkGreenGrey,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'ADD',
                      style: GoogleFonts.publicSans(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.white,
                      ),
                    ),
                    SizedBox(width: 4.w),
                    SvgIcon(icon: IconStrings.add),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
