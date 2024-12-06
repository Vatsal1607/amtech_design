import 'package:amtech_design/custom_widgets/svg_icon.dart';
import 'package:amtech_design/modules/auth/business_selection/business_selection_provider.dart';
import 'package:amtech_design/routes.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/strings.dart';

class BusinessDropdown extends StatelessWidget {
  const BusinessDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    /// New dropdown:
    return Center(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 17.w),
        decoration: BoxDecoration(
          color: Colors.transparent, // Background color for the dropdown
          borderRadius: BorderRadius.circular(100.r), // Circular border
          border: Border.all(
            color: AppColors.seaShell, // Border color
            width: 2, // Border width
          ),
        ),
        child: Row(
          children: [
            SvgIcon(icon: IconStrings.location), // Prefix icon
            const SizedBox(width: 8), // Spacing between icon and dropdown
            Expanded(
              child: Consumer<BusinessSelectionProvider>(
                builder: (context, provider, child) =>
                    DropdownButtonHideUnderline(
                  child: DropdownButton2<String>(
                    dropdownStyleData: DropdownStyleData(
                      decoration: BoxDecoration(
                        color: AppColors.seaShell,
                        borderRadius:
                            BorderRadius.circular(10), // Rounded corners
                        border: Border.all(
                          color: Colors.grey, // Border color
                          width: 1, // Border width
                        ),
                      ),
                    ),
                    value: provider.dropdownValue,
                    isExpanded: true,
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    hint: RichText(
                      text: const TextSpan(
                        text: 'Select Your ',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Complex',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    items: [
                      ...provider.dropdownItems
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primaryColor,
                            ),
                          ),
                        );
                      }).toList(),
                      DropdownMenuItem<String>(
                        enabled: false, // non-selectadble
                        child: GestureDetector(
                          onTap: () {
                            // Navigate to business register page
                            Navigator.pushNamed(
                              context,
                              Routes.register,
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.all(10.w),
                            decoration: BoxDecoration(
                              color: AppColors.primaryColor,
                              borderRadius: BorderRadius.circular(25.r),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Can’t find your business? ',
                                  style: GoogleFonts.publicSans(
                                    fontSize: 13.sp,
                                    color: AppColors.seaShell,
                                  ),
                                ),
                                Text(
                                  'Register Now',
                                  style: GoogleFonts.publicSans(
                                    fontSize: 13.sp,
                                    color: AppColors.disabledColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                    onChanged: provider.onChangeDropdown,
                    selectedItemBuilder: (BuildContext context) {
                      return provider.dropdownItems.map<Widget>((String value) {
                        return Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            value,
                            style: const TextStyle(
                              fontSize: 14,
                              color:
                                  Colors.white, // Style for the selected item
                            ),
                          ),
                        );
                      }).toList();
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );

    /// Old dropdown
    // return Center(
    //   child: Container(
    //     padding: EdgeInsets.symmetric(horizontal: 17.w),
    //     decoration: BoxDecoration(
    //       color: Colors.transparent, // Background color for the dropdown
    //       borderRadius: BorderRadius.circular(100), // Circular border
    //       border: Border.all(
    //         color: AppColors.seaShell, // Border color
    //         width: 2, // Border width
    //       ),
    //     ),
    //     child: Row(
    //       children: [
    //         SvgIcon(icon: IconStrings.location), // Prefix icon
    //         const SizedBox(width: 8), // Spacing between icon and dropdown
    //         Expanded(
    //           child: Consumer<CompanySelectionProvider>(
    //             builder: (context, provider, child) => DropdownButton<String>(
    //               value: provider.dropdownValue,
    //               isExpanded: true,
    //               // Dropdown color
    //               dropdownColor: AppColors.seaShell,

    //               underline: const SizedBox(),
    //               icon: const Icon(
    //                 Icons.keyboard_arrow_down,
    //                 color: Colors.white,
    //               ),
    //               // Dropdown icon
    //               style: const TextStyle(
    //                 fontSize: 15,
    //                 fontWeight: FontWeight.bold,
    //                 color: Colors.white,
    //               ),
    //               hint: RichText(
    //                 text: const TextSpan(
    //                   text: 'Select Your ',
    //                   style: TextStyle(
    //                     fontSize: 14,
    //                     color: Colors.white,
    //                   ),
    //                   children: <TextSpan>[
    //                     TextSpan(
    //                       text: 'Company',
    //                       style: TextStyle(
    //                         fontSize: 14,
    //                         fontWeight: FontWeight.bold,
    //                         color: Colors.white,
    //                       ),
    //                     ),
    //                   ],
    //                 ),
    //               ),

    //               items: provider.dropdownItems
    //                   .map<DropdownMenuItem<String>>((String value) {
    //                 return DropdownMenuItem<String>(
    //                   value: value,
    //                   child: Text(
    //                     value,
    //                     style: TextStyle(
    //                       fontSize: 14,
    //                       fontWeight: FontWeight.bold,
    //                       color: AppColors.primaryColor
    //                           .withOpacity(0.5), // Default color
    //                     ),
    //                   ),
    //                 );
    //               }).toList(),
    //               onChanged: provider.onChangeDropdown,
    //               selectedItemBuilder: (BuildContext context) {
    //                 return provider.dropdownItems.map<Widget>((String value) {
    //                   return Align(
    //                     alignment: Alignment.centerLeft,
    //                     child: Text(
    //                       value,
    //                       style: const TextStyle(
    //                         fontSize: 14,
    //                         color: Colors.white, // Style for the selected item
    //                       ),
    //                     ),
    //                   );
    //                 }).toList();
    //               },
    //             ),
    //           ),
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }
}
