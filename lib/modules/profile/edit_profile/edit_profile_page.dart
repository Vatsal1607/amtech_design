import 'package:amtech_design/core/utils/constant.dart';
import 'package:amtech_design/custom_widgets/appbar/custom_appbar_with_center_title.dart';
import 'package:amtech_design/custom_widgets/buttons/custom_button.dart';
import 'package:amtech_design/custom_widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/constants/keys.dart';
import '../../../core/utils/strings.dart';
import '../../../services/local/shared_preferences_service.dart';
import 'edit_profile_provider.dart';
import 'widgets/edit_icon_widget.dart';

class EditProfilePage extends StatelessWidget {
  const EditProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    String accountType =
        sharedPrefsService.getString(SharedPrefsKeys.accountType) ?? '';
    final provider = Provider.of<EditProfileProvider>(context, listen: false);

    return Scaffold(
      backgroundColor: getColorAccountType(
        accountType: accountType,
        businessColor: AppColors.seaShell,
        personalColor: AppColors.seaMist,
      ),
      appBar: CustomAppbarWithCenterTitle(
        title: 'Edit Profile',
        accountType: accountType,
      ),
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 20.h),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Stack(
                    children: [
                      Container(
                        height: 120.h,
                        width: 120.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: getColorAccountType(
                              accountType: accountType,
                              businessColor: AppColors.primaryColor,
                              personalColor: AppColors.darkGreenGrey,
                            ),
                            width: 2.w,
                          ),
                        ),
                        child: ClipOval(
                          child: Image.asset(
                            ImageStrings.logo,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: EditIconWidget(
                          accountType: accountType,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  CustomTextField(
                    hint: 'AMTech Design',
                    prefixIcon: IconStrings.business,
                    iconColor: getColorAccountType(
                      accountType: accountType,
                      businessColor: AppColors.primaryColor,
                      personalColor: AppColors.darkGreenGrey,
                    ),
                    controller: provider.businessNameController,
                    borderColor: getColorAccountType(
                      accountType: accountType,
                      businessColor: AppColors.primaryColor,
                      personalColor: AppColors.darkGreenGrey,
                    ),
                    textColor: getColorAccountType(
                      accountType: accountType,
                      businessColor: AppColors.primaryColor,
                      personalColor: AppColors.darkGreenGrey,
                    ),
                    suffixWidget: Padding(
                      padding: EdgeInsets.all(9.w),
                      child: EditIconWidget(
                        accountType: accountType,
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  CustomTextField(
                    hint: 'Anup Parekh',
                    prefixIcon: IconStrings.owner,
                    iconColor: getColorAccountType(
                      accountType: accountType,
                      businessColor: AppColors.primaryColor,
                      personalColor: AppColors.darkGreenGrey,
                    ),
                    controller: provider.businessOwnerController,
                    borderColor: getColorAccountType(
                      accountType: accountType,
                      businessColor: AppColors.primaryColor,
                      personalColor: AppColors.darkGreenGrey,
                    ),
                    textColor: getColorAccountType(
                      accountType: accountType,
                      businessColor: AppColors.primaryColor,
                      personalColor: AppColors.darkGreenGrey,
                    ),
                    suffixWidget: Padding(
                      padding: EdgeInsets.all(9.w),
                      child: EditIconWidget(
                        accountType: accountType,
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  CustomTextField(
                    hint: 'E-1102, 11th Floor, Titanium City C',
                    prefixIcon: IconStrings.locationWhite,
                    iconColor: getColorAccountType(
                      accountType: accountType,
                      businessColor: AppColors.primaryColor,
                      personalColor: AppColors.darkGreenGrey,
                    ),
                    controller: provider.businessAddressController,
                    borderColor: getColorAccountType(
                      accountType: accountType,
                      businessColor: AppColors.primaryColor,
                      personalColor: AppColors.darkGreenGrey,
                    ),
                    textColor: getColorAccountType(
                      accountType: accountType,
                      businessColor: AppColors.primaryColor,
                      personalColor: AppColors.darkGreenGrey,
                    ),
                    suffixWidget: Padding(
                      padding: EdgeInsets.all(9.w),
                      child: EditIconWidget(
                        accountType: accountType,
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  CustomTextField(
                    hint: '+91 12345 67890',
                    prefixIcon: IconStrings.phone,
                    iconColor: getColorAccountType(
                      accountType: accountType,
                      businessColor: AppColors.primaryColor,
                      personalColor: AppColors.darkGreenGrey,
                    ),
                    controller: provider.businessMobileController,
                    borderColor: getColorAccountType(
                      accountType: accountType,
                      businessColor: AppColors.primaryColor,
                      personalColor: AppColors.darkGreenGrey,
                    ),
                    textColor: getColorAccountType(
                      accountType: accountType,
                      businessColor: AppColors.primaryColor,
                      personalColor: AppColors.darkGreenGrey,
                    ),
                    suffixWidget: Padding(
                      padding: EdgeInsets.all(9.w),
                      child: EditIconWidget(
                        accountType: accountType,
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  CustomTextField(
                    hint: 'email@example.com',
                    prefixIcon: IconStrings.email,
                    iconColor: getColorAccountType(
                      accountType: accountType,
                      businessColor: AppColors.primaryColor,
                      personalColor: AppColors.darkGreenGrey,
                    ),
                    controller: provider.businessEmailController,
                    borderColor: getColorAccountType(
                      accountType: accountType,
                      businessColor: AppColors.primaryColor,
                      personalColor: AppColors.darkGreenGrey,
                    ),
                    textColor: getColorAccountType(
                      accountType: accountType,
                      businessColor: AppColors.primaryColor,
                      personalColor: AppColors.darkGreenGrey,
                    ),
                    suffixWidget: Padding(
                      padding: EdgeInsets.all(9.w),
                      child: EditIconWidget(
                        accountType: accountType,
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  CustomTextField(
                    hint: 'Owned',
                    prefixIcon: IconStrings.property,
                    iconColor: getColorAccountType(
                      accountType: accountType,
                      businessColor: AppColors.primaryColor,
                      personalColor: AppColors.darkGreenGrey,
                    ),
                    controller: provider.businessOwnerController,
                    borderColor: getColorAccountType(
                      accountType: accountType,
                      businessColor: AppColors.primaryColor,
                      personalColor: AppColors.darkGreenGrey,
                    ),
                    textColor: getColorAccountType(
                      accountType: accountType,
                      businessColor: AppColors.primaryColor,
                      personalColor: AppColors.darkGreenGrey,
                    ),
                    suffixWidget: Padding(
                      padding: EdgeInsets.all(9.w),
                      child: EditIconWidget(
                        accountType: accountType,
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 48.h,
            left: 32.w,
            right: 32.w,
            child: CustomButton(
              height: 55.h,
              onTap: () {},
              text: 'done',
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
          )
        ],
      ),
    );
  }
}
