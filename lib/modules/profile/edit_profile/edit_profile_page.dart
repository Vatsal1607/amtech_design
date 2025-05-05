import 'package:amtech_design/core/utils/constant.dart';
import 'package:amtech_design/custom_widgets/appbar/custom_appbar_with_center_title.dart';
import 'package:amtech_design/custom_widgets/buttons/custom_button.dart';
import 'package:amtech_design/custom_widgets/custom_textfield.dart';
import 'package:amtech_design/custom_widgets/loader/custom_loader.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/constants/keys.dart';
import '../../../core/utils/strings.dart';
import '../../../custom_widgets/svg_icon.dart';
import '../../../services/local/shared_preferences_service.dart';
import 'edit_profile_provider.dart';
import 'widgets/edit_icon_widget.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      String accountType =
          sharedPrefsService.getString(SharedPrefsKeys.accountType) ?? '';
      final provider = Provider.of<EditProfileProvider>(context, listen: false);
      if (accountType == 'business') {
        provider.getBusinessDetails(); //* API call
      } else {
        provider.getPersonalDetails(); //* API call
      }
    });
    super.initState();
  }

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
          Consumer<EditProfileProvider>(
            builder: (context, _, child) => provider.isDetailsLoading
                ? const Center(
                    child: CustomLoader(
                    backgroundColor: AppColors.black,
                  ))
                : Positioned.fill(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 32.w, vertical: 20.h),
                      child: SingleChildScrollView(
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
                                          personalColor:
                                              AppColors.darkGreenGrey,
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
                                    child: GestureDetector(
                                      onTap: () {
                                        //Todo set dynamic accountType (business & personal)
                                        provider.pickBusinessImage();
                                      },
                                      child: EditIconWidget(
                                        accountType: accountType,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 20.h),
                              //! Fields start
                              if (accountType == 'personal')
                                CustomTextField(
                                  controller:
                                      provider.personalFirstNameController,
                                  hint: '',
                                  prefixIcon: IconStrings.business,
                                  iconColor: getColorAccountType(
                                    accountType: accountType,
                                    businessColor: AppColors.primaryColor,
                                    personalColor: AppColors.darkGreenGrey,
                                  ),
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
                              if (accountType == 'personal')
                                SizedBox(height: 20.h),
                              if (accountType == 'personal')
                                CustomTextField(
                                  controller:
                                      provider.personalLastNameController,
                                  hint: '',
                                  prefixIcon: IconStrings.business,
                                  iconColor: getColorAccountType(
                                    accountType: accountType,
                                    businessColor: AppColors.primaryColor,
                                    personalColor: AppColors.darkGreenGrey,
                                  ),
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
                              if (accountType == 'personal')
                                SizedBox(height: 20.h),
                              if (accountType == 'business')
                                CustomTextField(
                                  controller: provider.businessNameController,
                                  hint: '',
                                  prefixIcon: IconStrings.business,
                                  iconColor: getColorAccountType(
                                    accountType: accountType,
                                    businessColor: AppColors.primaryColor,
                                    personalColor: AppColors.darkGreenGrey,
                                  ),
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
                              if (accountType == 'business')
                                SizedBox(height: 20.h),
                              if (accountType == 'business')
                                CustomTextField(
                                  controller: provider.businessOwnerController,
                                  hint: '',
                                  prefixIcon: IconStrings.owner,
                                  iconColor: getColorAccountType(
                                    accountType: accountType,
                                    businessColor: AppColors.primaryColor,
                                    personalColor: AppColors.darkGreenGrey,
                                  ),
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
                              if (accountType == 'business')
                                SizedBox(height: 20.h),
                              CustomTextField(
                                controller: provider.addressController,
                                hint: '',
                                prefixIcon: IconStrings.locationWhite,
                                iconColor: getColorAccountType(
                                  accountType: accountType,
                                  businessColor: AppColors.primaryColor,
                                  personalColor: AppColors.darkGreenGrey,
                                ),
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
                                controller: provider.mobileController,
                                hint: '',
                                prefixIcon: IconStrings.phone,
                                iconColor: getColorAccountType(
                                  accountType: accountType,
                                  businessColor: AppColors.primaryColor,
                                  personalColor: AppColors.darkGreenGrey,
                                ),
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
                              if (accountType == 'business')
                                SizedBox(height: 20.h),
                              if (accountType == 'business')
                                CustomTextField(
                                  controller: provider.businessEmailController,
                                  hint: '',
                                  prefixIcon: IconStrings.email,
                                  iconColor: getColorAccountType(
                                    accountType: accountType,
                                    businessColor: AppColors.primaryColor,
                                    personalColor: AppColors.darkGreenGrey,
                                  ),
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
                              //! Fields end
                              //* business type textfield
                              // SizedBox(height: 20.h),
                              // CustomTextField(
                              //   hint: '',
                              //   prefixIcon: IconStrings.property,
                              //   iconColor: getColorAccountType(
                              //     accountType: accountType,
                              //     businessColor: AppColors.primaryColor,
                              //     personalColor: AppColors.darkGreenGrey,
                              //   ),
                              //   controller: provider.businessTypeController,
                              //   borderColor: getColorAccountType(
                              //     accountType: accountType,
                              //     businessColor: AppColors.primaryColor,
                              //     personalColor: AppColors.darkGreenGrey,
                              //   ),
                              //   textColor: getColorAccountType(
                              //     accountType: accountType,
                              //     businessColor: AppColors.primaryColor,
                              //     personalColor: AppColors.darkGreenGrey,
                              //   ),
                              //   suffixWidget: Padding(
                              //     padding: EdgeInsets.all(9.w),
                              //     child: EditIconWidget(
                              //       accountType: accountType,
                              //     ),
                              //   ),
                              // ),
                              SizedBox(height: 20.h),
                              //* Dropdown business type
                              if (accountType == 'business')
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: AppColors.black,
                                      width: 2.w,
                                    ),
                                    borderRadius: BorderRadius.circular(100.r),
                                  ),
                                  child: Row(
                                    children: [
                                      // Leading Icon (Outside the Dropdown)
                                      const Padding(
                                        padding: EdgeInsets.only(left: 15.0),
                                        child: SvgIcon(
                                          icon: IconStrings.property,
                                          color: AppColors.black,
                                        ),
                                      ),
                                      Expanded(
                                        child: Consumer<EditProfileProvider>(
                                          builder: (context, _, child) =>
                                              DropdownButton2<String>(
                                            dropdownStyleData:
                                                DropdownStyleData(
                                              decoration: BoxDecoration(
                                                color: AppColors.seaShell,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        10), // Rounded corners
                                                border: Border.all(
                                                  color: Colors
                                                      .grey, // Border color
                                                  width: 1, // Border width
                                                ),
                                              ),
                                            ),
                                            value:
                                                provider.selectedBusinessType,
                                            isExpanded: true,
                                            style: GoogleFonts.publicSans(
                                              fontSize: 14.sp,
                                              color: AppColors.black,
                                            ),
                                            hint: Text(
                                              'Business Type',
                                              style: GoogleFonts.publicSans(
                                                fontSize: 14.sp,
                                                color: AppColors.black,
                                              ),
                                            ),
                                            items: provider.businessTypeItems
                                                .map<DropdownMenuItem<String>>(
                                                    (String value) {
                                              return DropdownMenuItem<String>(
                                                value: value,
                                                child: Text(
                                                  value,
                                                  style: GoogleFonts.publicSans(
                                                    fontSize: 14.sp,
                                                    fontWeight: FontWeight.bold,
                                                    color:
                                                        AppColors.primaryColor,
                                                  ),
                                                ),
                                              );
                                            }).toList(),
                                            underline: const SizedBox.shrink(),
                                            onChanged:
                                                provider.onChangeBusinessType,
                                            iconStyleData: IconStyleData(
                                              icon: Padding(
                                                padding: EdgeInsets.all(9.w),
                                                child: EditIconWidget(
                                                  accountType: accountType,
                                                ),
                                              ),
                                            ),
                                            selectedItemBuilder:
                                                (BuildContext context) {
                                              return provider.businessTypeItems
                                                  .map<Widget>((String value) {
                                                return Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    value,
                                                    style:
                                                        GoogleFonts.publicSans(
                                                      fontSize: 14,
                                                      color: Colors
                                                          .black, // Style for the selected item
                                                    ),
                                                  ),
                                                );
                                              }).toList();
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              SizedBox(height: 20.h),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
          ),
          Positioned.fill(
            bottom: 48.h,
            left: 32.w,
            right: 32.w,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Consumer<EditProfileProvider>(
                builder: (context, _, child) => CustomButton(
                  height: 55.h,
                  onTap: () {
                    if (accountType == 'business') {
                      provider.editProfile(context);
                    } else if (accountType == 'personal') {
                      provider.editPersonalProfile(context);
                    }
                  },
                  isLoading: provider.isEditProfileLoading,
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
              ),
            ),
          )
        ],
      ),
    );
  }
}
