import 'package:amtech_design/core/utils/constant.dart';
import 'package:amtech_design/core/utils/validator.dart';
import 'package:amtech_design/custom_widgets/appbar/appbar_with_back_button.dart';
import 'package:amtech_design/custom_widgets/snackbar.dart';
import 'package:amtech_design/custom_widgets/svg_icon.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/constants/shared_prefs_keys.dart';
import '../../../core/utils/strings.dart';
import '../../../custom_widgets/custom_button.dart';
import '../../../custom_widgets/custom_textfield.dart';
import '../../../services/local/shared_preferences_service.dart';
import 'register_provider.dart';
import 'widgets/upload_doc_widget.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<RegisterProvider>(context, listen: false);
    String accountType = 'business'; // static temp
    // String accountType =
    //     sharedPrefsService.getString(SharedPrefsKeys.accountType) ?? '';
    debugPrint(accountType);
    return Scaffold(
      resizeToAvoidBottomInset: false, //image did't move by the keyboard
      backgroundColor: getColorAccountType(
        accountType: accountType,
        businessColor: AppColors.primaryColor,
        personalColor: AppColors.darkGreenGrey,
      ),
      appBar: const AppBarWithBackButton(),
      extendBodyBehindAppBar: true, // show content of body behind appbar
      body: Stack(
        children: [
          Image.asset(
            width: 1.sw,
            height: 1.sh,
            ImageStrings.locationSelectionBg,
          ),
          Positioned.fill(
            child: Padding(
              padding: EdgeInsets.only(
                top: 100.h,
                left: 34.w,
                right: 34.w,
              ),
              //! Personal register column
              child: accountType == 'personal'
                  ? Form(
                      key: provider.personalFormKey,
                      child: SingleChildScrollView(
                        // physics: const ClampingScrollPhysics(),
                        child: Padding(
                          padding: EdgeInsets.only(top: 30.h),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Register',
                                style: GoogleFonts.publicSans(
                                  fontSize: 28.sp,
                                  fontWeight: FontWeight.bold,
                                  color: getColorAccountType(
                                    accountType: accountType,
                                    businessColor: AppColors.disabledColor,
                                    personalColor: AppColors.seaMist,
                                  ),
                                ),
                              ),
                              SizedBox(height: 18.h),
                              CustomTextField(
                                hint: 'Enter First Name',
                                validator: Validator.validateName,
                                prefixIcon: IconStrings.person,
                                iconColor: AppColors.seaMist,
                                controller: provider.firstNameController,
                              ),
                              SizedBox(height: 20.h),
                              CustomTextField(
                                hint: 'Enter Last Name',
                                validator: Validator.validateName,
                                prefixIcon: IconStrings.person,
                                iconColor: AppColors.seaMist,
                                controller: provider.lastNameController,
                              ),
                              SizedBox(height: 20.h),
                              CustomTextField(
                                hint: 'Enter Full Address',
                                validator: Validator.validateAddress,
                                prefixIcon: IconStrings.locationWhite,
                                iconColor: AppColors.seaMist,
                                controller: provider.personalAddressController,
                              ),
                              SizedBox(height: 20.h),
                              Consumer<RegisterProvider>(
                                builder: (context, _, child) => CustomTextField(
                                  hint: 'Enter Mobile Number',
                                  errorText: provider.personalMobileErrorText,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                    LengthLimitingTextInputFormatter(10),
                                  ],
                                  validator: Validator.validatePhoneNumber,
                                  onChanged: provider.onChangePersonalNumber,
                                  prefixIcon: IconStrings.phone,
                                  iconColor: AppColors.seaMist,
                                  controller: provider.personalMobileController,
                                ),
                              ),
                              SizedBox(height: 20.h),
                              // Upoad Adhar (doc)
                              // GestureDetector(
                              //   onTap: () {
                              //     debugPrint('Upload doc pressed (personal)');
                              //   },
                              //   child: Container(
                              //     height: 54.h,
                              //     padding: EdgeInsets.symmetric(horizontal: 18.w),
                              //     decoration: BoxDecoration(
                              //       color: Colors.transparent,
                              //       borderRadius: BorderRadius.circular(100.r),
                              //       border: Border.all(
                              //         color: AppColors.seaShell,
                              //         width: 2.w,
                              //       ),
                              //     ),
                              //     child: Row(
                              //       mainAxisAlignment:
                              //           MainAxisAlignment.spaceBetween,
                              //       children: [
                              //         Row(
                              //           children: [
                              //             SvgIcon(
                              //               icon: IconStrings.doc,
                              //               color: AppColors.seaMist,
                              //             ),
                              //             SizedBox(width: 12.w),
                              //             Text(
                              //               'Same Height as TextFormField',
                              //               textAlign: TextAlign.start,
                              //               style: GoogleFonts.publicSans(
                              //                 fontSize: 14.sp,
                              //                 color: AppColors.white,
                              //               ),
                              //             ),
                              //           ],
                              //         ),
                              //         SvgIcon(
                              //           icon: IconStrings.upload,
                              //           color: AppColors.seaMist,
                              //         ),
                              //       ],
                              //     ),
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                      ),
                    )
                  :
                  //! Business register column
                  SingleChildScrollView(
                      // physics: const ClampingScrollPhysics(),
                      child: Form(
                        key: provider.businessFormKey,
                        child: Padding(
                          padding: EdgeInsets.only(top: 40.h),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Register Your Business',
                                style: GoogleFonts.publicSans(
                                  fontSize: 28.sp,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.disabledColor,
                                ),
                              ),
                              SizedBox(height: 18.h),
                              CustomTextField(
                                hint: 'Enter Business Name',
                                prefixIcon: IconStrings.business,
                                controller: provider.businessNameController,
                                validator: Validator.validateName,
                              ),
                              SizedBox(height: 20.h),
                              CustomTextField(
                                controller: provider.businessOwnerController,
                                hint: 'Enter Business Owner\'s Name',
                                prefixIcon: IconStrings.owner,
                                validator: Validator.validateName,
                              ),
                              SizedBox(height: 20.h),
                              CustomTextField(
                                controller: provider.businessAddressController,
                                hint: 'Enter Business Address',
                                prefixIcon: IconStrings.locationWhite,
                                validator: Validator.validateAddress,
                              ),
                              SizedBox(height: 20.h),
                              Consumer<RegisterProvider>(
                                builder: (context, _, child) => CustomTextField(
                                  controller: provider.businessMobileController,
                                  hint: 'Enter Mobile Number',
                                  errorText: provider.businessMobileErrorText,
                                  prefixIcon: IconStrings.phone,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                    LengthLimitingTextInputFormatter(10),
                                  ],
                                  validator: Validator.validatePhoneNumber,
                                  onChanged: provider.onChangeBusinessNumber,
                                ),
                              ),
                              SizedBox(height: 20.h),
                              //* Dropdown business type
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: AppColors.seaShell,
                                    width: 2.w,
                                  ),
                                  borderRadius: BorderRadius.circular(100.r),
                                ),
                                child: Row(
                                  children: [
                                    // Leading Icon (Outside the Dropdown)
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 15.0),
                                      child: SvgIcon(
                                        icon: IconStrings.property,
                                      ),
                                    ),
                                    Expanded(
                                      child: Consumer<RegisterProvider>(
                                        builder: (context, value, child) =>
                                            DropdownButton2<String>(
                                          dropdownStyleData: DropdownStyleData(
                                            decoration: BoxDecoration(
                                              color: AppColors.seaShell,
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      10), // Rounded corners
                                              border: Border.all(
                                                color:
                                                    Colors.grey, // Border color
                                                width: 1, // Border width
                                              ),
                                            ),
                                          ),
                                          value: provider.selectedBusinessType,
                                          isExpanded: true,
                                          style: GoogleFonts.publicSans(
                                            fontSize: 14.sp,
                                            color: AppColors.white,
                                          ),
                                          hint: Text(
                                            'Business Type',
                                            style: GoogleFonts.publicSans(
                                              fontSize: 14.sp,
                                              color: AppColors.white,
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
                                                  color: AppColors.primaryColor,
                                                ),
                                              ),
                                            );
                                          }).toList(),
                                          underline: const SizedBox.shrink(),
                                          onChanged:
                                              provider.onChangeBusinessType,
                                          iconStyleData: IconStyleData(
                                            icon: Padding(
                                              padding:
                                                  EdgeInsets.only(right: 20.w),
                                              child: SvgIcon(
                                                icon: IconStrings.dropdown,
                                              ),
                                            ),
                                          ),
                                          selectedItemBuilder:
                                              (BuildContext context) {
                                            return provider.businessTypeItems
                                                .map<Widget>((String value) {
                                              return Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  value,
                                                  style: const TextStyle(
                                                    fontSize: 14,
                                                    color: Colors
                                                        .white, // Style for the selected item
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

                              //* Dropdown of Business property status
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: AppColors.seaShell,
                                    width: 2.w,
                                  ),
                                  borderRadius: BorderRadius.circular(100.r),
                                ),
                                child: Row(
                                  children: [
                                    // Leading Icon (Outside the Dropdown)
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 15.0),
                                      child: SvgIcon(
                                        icon: IconStrings.property,
                                      ),
                                    ),
                                    Expanded(
                                      child: Consumer<RegisterProvider>(
                                        builder: (context, value, child) =>
                                            DropdownButton2<String>(
                                          dropdownStyleData: DropdownStyleData(
                                            decoration: BoxDecoration(
                                              color: AppColors.seaShell,
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      10), // Rounded corners
                                              border: Border.all(
                                                color:
                                                    Colors.grey, // Border color
                                                width: 1, // Border width
                                              ),
                                            ),
                                          ),
                                          value:
                                              provider.selectedPropertyStatus,
                                          isExpanded: true,
                                          style: GoogleFonts.publicSans(
                                            fontSize: 14.sp,
                                            color: AppColors.white,
                                          ),
                                          hint: Text(
                                            'Business Property Status',
                                            style: GoogleFonts.publicSans(
                                              fontSize: 14.sp,
                                              color: AppColors.white,
                                            ),
                                          ),
                                          items: provider.propertyStatusItems
                                              .map<DropdownMenuItem<String>>(
                                                  (String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(
                                                value,
                                                style: GoogleFonts.publicSans(
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.bold,
                                                  color: AppColors.primaryColor,
                                                ),
                                              ),
                                            );
                                          }).toList(),
                                          underline: const SizedBox.shrink(),
                                          onChanged:
                                              provider.onChangePropertyStatus,
                                          iconStyleData: IconStyleData(
                                            icon: Padding(
                                              padding:
                                                  EdgeInsets.only(right: 20.w),
                                              child: SvgIcon(
                                                icon: IconStrings.dropdown,
                                              ),
                                            ),
                                          ),
                                          selectedItemBuilder:
                                              (BuildContext context) {
                                            return provider.propertyStatusItems
                                                .map<Widget>((String value) {
                                              return Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  value,
                                                  style: const TextStyle(
                                                    fontSize: 14,
                                                    color: Colors
                                                        .white, // Style for the selected item
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

                              // Consumer<RegisterProvider>(
                              //   builder: (context, _, child) {
                              //     // Upoad lightbill & rent agreement condition
                              //     return provider.selectedPropertyStatus ==
                              //             'Owner'
                              //         ? Padding(
                              //             padding: EdgeInsets.only(top: 20.h),
                              //             child: UploadDocWidget(
                              //               onTap: () {
                              //                 debugPrint(
                              //                     'Upload lightbill pressed');
                              //                 //! lightbill upload
                              //                 provider.pickAndAddImageToLists();
                              //               },
                              //               leadingIcon: IconStrings.bill,
                              //               title: 'Upload Owner\'s Light Bill',
                              //             ),
                              //           )
                              //         : provider.selectedPropertyStatus ==
                              //                 'Rental'
                              //             ? Padding(
                              //                 padding:
                              //                     EdgeInsets.only(top: 20.h),
                              //                 child: UploadDocWidget(
                              //                   onTap: () {
                              //                     //! agreement upload
                              //                     provider
                              //                         .pickAndAddImageToLists();
                              //                     debugPrint(
                              //                         'Upload Rent pressed');
                              //                   },
                              //                   leadingIcon: IconStrings.bill,
                              //                   title: 'Upload Rent Agreement',
                              //                 ),
                              //               )
                              //             : const SizedBox();
                              //   },
                              // ),
                              SizedBox(height: 20.h),
                              // Todo add GST number field:

                              //! Adhar upload
                              // UploadDocWidget(
                              //   onTap: () {
                              //     provider.pickAndAddImageToLists();
                              //     debugPrint('Upload doc pressed');
                              //   },
                              //   title: 'Upload Owner\'s Aadhaar Card',
                              // ),
                              // SizedBox(height: 20.h),
                              // UploadDocWidget(
                              //   onTap: () {
                              //     provider.pickAndAddImageToLists();
                              //     debugPrint('GST card pressed');
                              //   },
                              //   title: 'Upload GST Document',
                              // ),
                              SizedBox(height: 150.h), //* bottom space business
                            ],
                          ),
                        ),
                      ),
                    ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(
                bottom: 70.h,
                left: 34.w,
                right: 34.w,
              ),
              child: Consumer<RegisterProvider>(
                builder: (context, rProvider, child) => CustomButton(
                  height: 48.h,
                  isLoading: rProvider.isLoading,
                  onTap: () {
                    debugPrint('Business register called');
                    if (accountType == 'personal') {
                      if (provider.personalFormKey.currentState!.validate()) {
                        // If the form is valid (personal)
                        //! Api call personal register
                        provider.personalRegister(context);
                      } else {
                        debugPrint('Personal form is not valid');
                      }
                    } else if (accountType == 'business') {
                      // Validate business fields
                      if (provider.businessFormKey.currentState!.validate()) {
                        //! Api call business register
                        provider.businessRegister(context);
                        debugPrint('Business form is valid');
                      } else {
                        debugPrint('Business form is not valid');
                      }
                    }
                  },
                  bgColor: getColorAccountType(
                    accountType: accountType,
                    businessColor: AppColors.disabledColor,
                    personalColor: AppColors.seaMist,
                  ),
                  textColor: AppColors.primaryColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
