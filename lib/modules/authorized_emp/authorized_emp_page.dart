import 'package:amtech_design/core/utils/constant.dart';
import 'package:amtech_design/core/utils/strings.dart';
import 'package:amtech_design/core/utils/validator.dart';
import 'package:amtech_design/custom_widgets/appbar/custom_appbar_with_center_title.dart';
import 'package:amtech_design/custom_widgets/buttons/custom_button.dart';
import 'package:amtech_design/custom_widgets/custom_confirm_dialog.dart';
import 'package:amtech_design/custom_widgets/custom_textfield.dart';
import 'package:amtech_design/modules/authorized_emp/widgets/otp_verify_bottomsheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../core/utils/app_colors.dart';
import 'authorized_emp_provider.dart';

class AuthorizedEmpPage extends StatelessWidget {
  AuthorizedEmpPage({super.key});

  final TextEditingController otpController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    String accountType = 'business'; // Todo imp set dynamic
    // sharedPrefsService.getString(SharedPrefsKeys.accountType) ?? '';
    final provider = Provider.of<AuthorizedEmpProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: getColorAccountType(
        accountType: accountType,
        businessColor: AppColors.seaShell,
        personalColor: AppColors.seaMist,
      ),
      appBar: CustomAppbarWithCenterTitle(
        accountType: accountType,
        title: 'Authorized Employees',
        leftPadTitle: 50.w,
      ),
      body: Form(
        key: provider.formKey,
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 32.w, right: 32.w, bottom: 120.h),
              child: SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
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
                            color: getColorAccountType(
                              accountType: accountType,
                              businessColor: AppColors.primaryColor,
                              personalColor: AppColors.darkGreenGrey,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return CustomConfirmDialog(
                                  accountType: accountType,
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
                                  color: getColorAccountType(
                                    accountType: accountType,
                                    businessColor: AppColors.seaShell,
                                    personalColor: AppColors.seaMist,
                                  ),
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
                      validator: Validator.validateName,
                      prefixIcon: IconStrings.fullname,
                      controller: provider.fullNameController,
                      borderColor: getColorAccountType(
                        accountType: accountType,
                        businessColor: AppColors.primaryColor,
                        personalColor: AppColors.darkGreenGrey,
                      ),
                      iconColor: getColorAccountType(
                        accountType: accountType,
                        businessColor: AppColors.primaryColor,
                        personalColor: AppColors.darkGreenGrey,
                      ),
                      textColor: getColorAccountType(
                        accountType: accountType,
                        businessColor: AppColors.primaryColor,
                        personalColor: AppColors.darkGreenGrey,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    CustomTextField(
                      cursorColor: AppColors.primaryColor,
                      hint: 'Position',
                      validator: Validator.validateName,
                      prefixIcon: IconStrings.position,
                      controller: provider.positionController,
                      borderColor: getColorAccountType(
                        accountType: accountType,
                        businessColor: AppColors.primaryColor,
                        personalColor: AppColors.darkGreenGrey,
                      ),
                      iconColor: getColorAccountType(
                        accountType: accountType,
                        businessColor: AppColors.primaryColor,
                        personalColor: AppColors.darkGreenGrey,
                      ),
                      textColor: getColorAccountType(
                        accountType: accountType,
                        businessColor: AppColors.primaryColor,
                        personalColor: AppColors.darkGreenGrey,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    CustomTextField(
                      cursorColor: AppColors.primaryColor,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(10),
                      ],
                      hint: 'Mobile Number',
                      validator: Validator.validatePhoneNumber,
                      prefixIcon: IconStrings.phone,
                      controller: provider.mobileController,
                      borderColor: getColorAccountType(
                        accountType: accountType,
                        businessColor: AppColors.primaryColor,
                        personalColor: AppColors.darkGreenGrey,
                      ),
                      iconColor: getColorAccountType(
                        accountType: accountType,
                        businessColor: AppColors.primaryColor,
                        personalColor: AppColors.darkGreenGrey,
                      ),
                      textColor: getColorAccountType(
                        accountType: accountType,
                        businessColor: AppColors.primaryColor,
                        personalColor: AppColors.darkGreenGrey,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    CustomButton(
                      height: 50.h,
                      onTap: () {
                        if (provider.formKey.currentState!.validate()) {
                          otpVerifyBottomSheeet(
                            context: context,
                            accountType: accountType,
                            controller: otpController,
                          );
                        } else {
                          debugPrint('form is not validate');
                        }
                      },
                      text: 'verify',
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
                    SizedBox(height: 10.h),
                    CustomButton(
                      height: 50.h,
                      onTap: () {},
                      text: '+ ADD MORE',
                      bgColor: getColorAccountType(
                        accountType: accountType,
                        businessColor: AppColors.disabledColor,
                        personalColor: AppColors.bayLeaf,
                      ),
                      textColor: getColorAccountType(
                        accountType: accountType,
                        businessColor: AppColors.primaryColor,
                        personalColor: AppColors.darkGreenGrey,
                      ),
                    ),
                    SizedBox(height: 13.h),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Note:',
                        style: GoogleFonts.publicSans(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.bold,
                          color: getColorAccountType(
                            accountType: accountType,
                            businessColor: AppColors.primaryColor,
                            personalColor: AppColors.darkGreenGrey,
                          ),
                        ),
                      ),
                    ),
                    RichText(
                      textAlign: TextAlign.justify,
                      text: TextSpan(
                          text: 'You can authorize up to ',
                          style: GoogleFonts.publicSans(
                            fontSize: 12.sp,
                            color: getColorAccountType(
                              accountType: accountType,
                              businessColor: AppColors.primaryColor,
                              personalColor: AppColors.darkGreenGrey,
                            ),
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: 'Three Employees ',
                              style: GoogleFonts.publicSans(
                                fontSize: 12.sp,
                                color: getColorAccountType(
                                  accountType: accountType,
                                  businessColor: AppColors.primaryColor,
                                  personalColor: AppColors.darkGreenGrey,
                                ),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(
                              text:
                                  'to act on behalf of the business owner. These authorized employees will have the ability to place orders, manage billing details, view and track order history, reorder past items, and handle subscriptions for the account. This ensures smooth and efficient operations while maintaining secure access control. Please select your authorized employees carefully to avoid any misuse.',
                              style: GoogleFonts.publicSans(
                                fontSize: 12.sp,
                                color: getColorAccountType(
                                  accountType: accountType,
                                  businessColor: AppColors.primaryColor,
                                  personalColor: AppColors.darkGreenGrey,
                                ),
                              ),
                            ),
                          ]),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              child: Padding(
                padding: EdgeInsets.only(bottom: 50.h, left: 32.w, right: 32.w),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: CustomButton(
                    height: 55.h,
                    onTap: () {},
                    text: 'Done',
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
