import 'package:amtech_design/core/utils/constant.dart';
import 'package:amtech_design/custom_widgets/appbar/custom_appbar.dart';
import 'package:amtech_design/custom_widgets/custom_button.dart';
import 'package:amtech_design/custom_widgets/size_modal_bottom_sheet.dart';
import 'package:amtech_design/custom_widgets/svg_icon.dart';
import 'package:amtech_design/modules/product_page/widgets/bottomsheet_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/utils/app_colors.dart';
import '../../core/utils/strings.dart';

class ProductDetailsPage extends StatelessWidget {
  const ProductDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    String accountType = 'personal'; // Todo imp set dynamic
    // sharedPrefsService.getString(SharedPrefsKeys.accountType) ?? '';
    return Scaffold(
      extendBodyBehindAppBar: true, // Ensures content goes behind the AppBar
      backgroundColor: getColorAccountType(
        accountType: accountType,
        businessColor: AppColors.primaryColor,
        personalColor: AppColors.darkGreenGrey,
      ),
      appBar: CustomAppBar(
        backgroundColor: Colors.transparent,
        title: '',
        onTapLeading: () {
          Navigator.pop(context);
        },
        leading: Container(
          height: 48.h,
          width: 48.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: getColorAccountType(
              accountType: accountType,
              businessColor: AppColors.seaShell,
              personalColor: AppColors.seaMist,
            ),
          ),
          child: ClipOval(
            child: SvgIcon(
              icon: IconStrings.arrowBack,
              color: getColorAccountType(
                accountType: accountType,
                businessColor: AppColors.primaryColor,
                personalColor: AppColors.darkGreenGrey,
              ),
            ),
          ),
        ),
        actions: [
          Container(
            height: 45.h,
            width: 45.w,
            margin: EdgeInsets.only(right: 15.w),
            decoration: BoxDecoration(
              color: getColorAccountType(
                accountType: accountType,
                businessColor: AppColors.primaryColor,
                personalColor: AppColors.darkGreenGrey,
              ),
              shape: BoxShape.circle,
            ),
            child: const SvgIcon(
              icon: IconStrings.heart,
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          // * Top content above the DraggableScrollableSheet
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                height: 439.h,
                width: double.infinity,
                ImageStrings.teaImg,
                fit: BoxFit.cover,
              ),
              // Expanded(
              //   child: DraggableScrollableSheet(
              //     initialChildSize: 0.7,
              //     minChildSize: 0.7,
              //     maxChildSize: 0.9,
              //     expand: true, // set true for scrollable sheet itself
              //     builder:
              //         (BuildContext context, ScrollController scrollController) {
              //       return SingleChildScrollView(
              //         controller: scrollController,
              //         child:
              //       );
              //     },
              //   ),
              // ),
            ],
          ),
          // * DraggableScrollableSheet at the bottom
          Align(
            alignment: Alignment.bottomCenter,
            child: DraggableScrollableSheet(
              expand: false, // doesn’t take over the entire screen
              initialChildSize: 0.55, // Initial height of BottomSheet
              minChildSize: 0.55, // Minimum height of BottomSheet
              maxChildSize: 0.8, // Maximum height of BottomSheet
              shouldCloseOnMinExtent: false,
              builder: (context, scrollController) {
                return Container(
                  decoration: BoxDecoration(
                    color: getColorAccountType(
                      accountType: accountType,
                      businessColor: AppColors.seaShell,
                      personalColor: AppColors.seaMist,
                    ),
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(16.r)),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Handle to indicate dragging
                      Container(
                        width: 40.w,
                        height: 6.h,
                        margin: EdgeInsets.only(top: 8.h),
                        decoration: BoxDecoration(
                          color: AppColors.shipGrey.withOpacity(.3),
                          borderRadius: BorderRadius.circular(3.r),
                        ),
                      ),
                      Expanded(
                        child: Stack(
                          children: [
                            SingleChildScrollView(
                              controller: scrollController,
                              physics: const ClampingScrollPhysics(),
                              child: BottomsheetContent(
                                accountType: accountType,
                              ),
                            ),
                            // Add to cart button
                            Positioned(
                              bottom: 50.h,
                              left: 34.w,
                              right: 34.w,
                              child: CustomButton(
                                height: 55.h,
                                onTap: () {
                                  showSizeModalBottomSheet(
                                      context: context,
                                      accountType: accountType);
                                },
                                text: 'ADD TO CART',
                                textColor: getColorAccountType(
                                  accountType: accountType,
                                  businessColor: AppColors.seaShell,
                                  personalColor: AppColors.seaMist,
                                ),
                                bgColor: getColorAccountType(
                                  accountType: accountType,
                                  businessColor: AppColors.primaryColor,
                                  personalColor: AppColors.darkGreenGrey,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
