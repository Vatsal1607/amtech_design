import 'package:amtech_design/core/utils/strings.dart';
import 'package:amtech_design/custom_widgets/appbar/custom_appbar_with_center_title.dart';
import 'package:amtech_design/custom_widgets/appbar/custom_sliver_appbar_center_title.dart';
import 'package:amtech_design/custom_widgets/custom_button.dart';
import 'package:amtech_design/custom_widgets/custom_confirm_dialog.dart';
import 'package:amtech_design/custom_widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../core/utils/app_colors.dart';
import 'authorized_emp_provider.dart';

class AuthorizedEmpPage extends StatelessWidget {
  const AuthorizedEmpPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AuthorizedEmpProvider>(context, listen: false);
    return Scaffold(
      // appBar: CustomAppbarWithCenterTitle(
      //   title: 'Authorized Employees',
      //   leftPadTitle: 50.w,
      // ),
      body: Stack(
        children: [
          CustomScrollView(
            physics: const ClampingScrollPhysics(),
            slivers: [
              CustomSliverAppbarWithCenterTitle(
                title: 'Authorized Employees',
                leftPadTitle: 50.w,
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding:
                      EdgeInsets.only(left: 32.w, right: 32.w, bottom: 120.h),
                  child: Column(
                    children: [
                      SizedBox(height: 35.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '1st Employee\'s Details',
                            style: GoogleFonts.publicSans(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primaryColor,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return CustomConfirmDialog(
                                    onTapCancel: () => Navigator.pop(context),
                                    onTapYes: () => Navigator.pop(context),
                                    title: "ARE YOU SURE?",
                                    subTitle:
                                        "You Really Want To Remove\nThe Authorized Employee?",
                                  );
                                },
                              );
                            },
                            child: Container(
                              width: 60.w,
                              height: 22.h,
                              decoration: BoxDecoration(
                                color: AppColors.red,
                                borderRadius: BorderRadius.circular(100.r),
                              ),
                              child: Center(
                                child: Text(
                                  'REMOVE',
                                  style: GoogleFonts.publicSans(
                                    fontSize: 10.sp,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.seaShell,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 13.h),
                      CustomTextField(
                        cursorColor: AppColors.primaryColor,
                        hint: 'Full Name',
                        prefixIcon: IconStrings.fullname,
                        controller: provider.fullNameController,
                        borderColor: AppColors.primaryColor,
                        iconColor: AppColors.primaryColor,
                        textColor: AppColors.primaryColor,
                      ),
                      SizedBox(height: 10.h),
                      CustomTextField(
                        cursorColor: AppColors.primaryColor,
                        hint: 'Position',
                        prefixIcon: IconStrings.position,
                        controller: provider.fullNameController,
                        borderColor: AppColors.primaryColor,
                        iconColor: AppColors.primaryColor,
                        textColor: AppColors.primaryColor,
                      ),
                      SizedBox(height: 10.h),
                      CustomTextField(
                        cursorColor: AppColors.primaryColor,
                        hint: 'Mobile Number',
                        prefixIcon: IconStrings.phone,
                        controller: provider.fullNameController,
                        borderColor: AppColors.primaryColor,
                        iconColor: AppColors.primaryColor,
                        textColor: AppColors.primaryColor,
                      ),
                      SizedBox(height: 10.h),
                      CustomButton(
                        height: 50.h,
                        onTap: () {},
                        text: 'verify',
                        bgColor: AppColors.primaryColor,
                      ),
                      SizedBox(height: 10.h),
                      CustomButton(
                        height: 50.h,
                        onTap: () {},
                        text: '+ ADD MORE',
                        bgColor: AppColors.disabledColor,
                        textColor: AppColors.primaryColor,
                      ),
                      SizedBox(height: 200.h),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Note:',
                          style: GoogleFonts.publicSans(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ),
                      RichText(
                        textAlign: TextAlign.justify,
                        text: TextSpan(
                            text: 'You can authorize up to ',
                            style: GoogleFonts.publicSans(
                              fontSize: 12.sp,
                              color: AppColors.primaryColor,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text: 'Three Employees ',
                                style: GoogleFonts.publicSans(
                                  fontSize: 12.sp,
                                  color: AppColors.primaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextSpan(
                                text:
                                    'to act on behalf of the business owner. These authorized employees will have the ability to place orders, manage billing details, view and track order history, reorder past items, and handle subscriptions for the account. This ensures smooth and efficient operations while maintaining secure access control. Please select your authorized employees carefully to avoid any misuse.',
                                style: GoogleFonts.publicSans(
                                  fontSize: 12.sp,
                                  color: AppColors.primaryColor,
                                ),
                              ),
                            ]),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            child: Padding(
              padding: EdgeInsets.only(bottom: 50.h, left: 32.w, right: 32.w),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: CustomButton(
                  height: 55.h,
                  onTap: () {},
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
