import 'package:amtech_design/custom_widgets/snackbar.dart';
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

  // Bottomsheet // TODO: Reformat code (Move method in seprate file)
  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.primaryColor,
      builder: (context) {
        return Container(
          padding: EdgeInsets.only(top: 19.h),
          height: 300.h,
          width: 1.sw,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'select size'.toUpperCase(),
                style: GoogleFonts.publicSans(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.seaShell,
                ),
              ),
              SizedBox(height: 17.h),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 32.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40.r),
                  color: AppColors.disabledColor,
                ),
                child: ListTile(
                  // tileColor: AppColors.disabledColor,
                  leading: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'regular'.toUpperCase(),
                        style: GoogleFonts.publicSans(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryColor,
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            '₹ 10 '.toUpperCase(),
                            style: GoogleFonts.publicSans(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primaryColor,
                            ),
                          ),
                          Text(
                            '( 65 ml )'.toUpperCase(),
                            style: GoogleFonts.publicSans(
                              fontSize: 12.sp,
                              color: AppColors.primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 150.h,
          width: 118.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            border: Border.all(
              color: AppColors.primaryColor, // Border color
              width: 2.0, // Border width
            ),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                getColorAccountType(
                  accountType: accountType,
                  businessColor: AppColors.primaryColor.withOpacity(.15),
                  personalColor: AppColors.darkGreenGrey.withOpacity(.3),
                ),
                getColorAccountType(
                  accountType: accountType,
                  businessColor: AppColors.disabledColor.withOpacity(.15),
                  personalColor: AppColors.mineralGreen.withOpacity(0.3),
                ),
                AppColors.white.withOpacity(0.2),
              ],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(image),
              Text(
                name.toUpperCase(),
                style: GoogleFonts.publicSans(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  color: getColorAccountType(
                    accountType: accountType,
                    businessColor: AppColors.primaryColor,
                    personalColor: AppColors.darkGreenGrey,
                  ),
                ),
              ),
              const SizedBox(height: 8),
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
                _showBottomSheet(context);

                /// showSnackbar(context, '{count} ITEMS ADDED');
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 3,
                  horizontal: 8,
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
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: AppColors.white,
                      ),
                    ),
                    const SizedBox(width: 4),
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
