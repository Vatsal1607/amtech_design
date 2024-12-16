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
    String accountType = 'personal'; // Todo imp set dynamic
    // sharedPrefsService.getString(SharedPrefsKeys.accountType) ?? '';
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
              color: AppColors.primaryColor,
              width: 2.w,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.center,
                children: [
                  // Gradient Overlay at the Bottom
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: 55.h,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            getColorAccountType(
                                accountType: accountType,
                                businessColor:
                                    AppColors.seaShell.withOpacity(0.0),
                                personalColor:
                                    AppColors.seaMist.withOpacity(0.0)),
                            getColorAccountType(
                                accountType: accountType,
                                businessColor:
                                    AppColors.seaShell.withOpacity(0.8),
                                personalColor:
                                    AppColors.seaMist.withOpacity(0.8)),
                            getColorAccountType(
                                accountType: accountType,
                                businessColor: AppColors.seaShell,
                                personalColor: AppColors.seaMist),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          stops: const [0.0, 0.5, 1.0],
                        ),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(30.r),
                          bottomRight: Radius.circular(30.r),
                        ),
                      ),
                    ),
                  ),
                  // * Foreground Content
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
              // SizedBox(height: 8.h),
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
                //* Custom Size bottomsheet
                showSizeModalBottomSheet(
                  context: context,
                  accountType: accountType,
                );
                // showSnackbar(context, '{count} ITEMS ADDED');
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
