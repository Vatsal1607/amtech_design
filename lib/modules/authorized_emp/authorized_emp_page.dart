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
import 'widgets/authorized_emp_widget.dart';

class AuthorizedEmpPage extends StatelessWidget {
  AuthorizedEmpPage({super.key});

  final TextEditingController otpController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AuthorizedEmpProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: AppColors.seaShell,
      appBar: CustomAppbarWithCenterTitle(
        accountType: 'business', // ! static
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
                    Consumer<AuthorizedEmpProvider>(
                      builder: (context, _, child) => provider.accessList ==
                              null
                          ? const SizedBox()
                          : ListView.builder(
                              shrinkWrap: true,
                              // padding: EdgeInsets.only(bottom: 10.h),
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: provider.accessList?.length ?? 0,
                              itemBuilder: (context, index) {
                                final accessList = provider.accessList?[index];
                                return AuthorizedEmpWidget(
                                  authorizedId:
                                      accessList?.sId.toString() ?? '',
                                  name: accessList?.name ?? '',
                                  position: accessList?.position ?? '',
                                  contact: accessList?.contact.toString() ?? '',
                                );
                              },
                            ),
                    ),
                    // SizedBox(height: 10.h),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Add Authorized Employees:'.toUpperCase(),
                        style: GoogleFonts.publicSans(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ),
                    SizedBox(height: 13.h),
                    CustomTextField(
                      cursorColor: AppColors.primaryColor,
                      hint: 'Full Name',
                      validator: Validator.validateName,
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
                      validator: Validator.validateName,
                      prefixIcon: IconStrings.position,
                      controller: provider.positionController,
                      borderColor: AppColors.primaryColor,
                      iconColor: AppColors.primaryColor,
                      textColor: AppColors.primaryColor,
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
                      prefixText: '+91 ',
                      validator: Validator.validatePhoneNumber,
                      prefixIcon: IconStrings.phone,
                      controller: provider.mobileController,
                      borderColor: AppColors.primaryColor,
                      iconColor: AppColors.primaryColor,
                      textColor: AppColors.primaryColor,
                    ),
                    SizedBox(height: 10.h),
                    Consumer<AuthorizedEmpProvider>(
                      builder: (context, _, child) => CustomButton(
                        height: 50.h,
                        isLoading: provider.isLoading,
                        loaderColor: AppColors.seaShell,
                        onTap: () {
                          if (provider.formKey.currentState!.validate()) {
                            // * API call
                            provider
                                .createAccess(context: context)
                                .then((isSuccess) {
                              if (isSuccess == true) {
                                provider
                                    .sendOtp(
                                  context: context,
                                  secondaryMobile:
                                      provider.mobileController.text,
                                )
                                    .then((isSuccess) {
                                  // * show bottomsheet (verify otp)
                                  otpVerifyBottomSheeet(
                                    context: context,
                                    accountType: 'business', // ! static
                                    otpController: otpController,
                                    authorizeMobileController:
                                        provider.mobileController,
                                  );
                                });
                              }
                            });
                          } else {
                            debugPrint('form is not validate');
                          }
                        },
                        text: 'verify',
                        textColor: AppColors.seaShell,
                        bgColor: AppColors.primaryColor,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    CustomButton(
                      height: 50.h,
                      onTap: () {},
                      text: '+ ADD MORE',
                      bgColor: AppColors.disabledColor,
                      textColor: AppColors.primaryColor,
                    ),
                    SizedBox(height: 13.h),
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
            Positioned(
              child: Padding(
                padding: EdgeInsets.only(bottom: 50.h, left: 32.w, right: 32.w),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: CustomButton(
                    height: 55.h,
                    onTap: () {
                      if (provider.formKey.currentState!.validate()) {
                        Navigator.pop(context);
                      } else {
                        debugPrint('form is not validate');
                      }
                    },
                    text: 'Done',
                    textColor: AppColors.seaShell,
                    bgColor: AppColors.primaryColor,
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
