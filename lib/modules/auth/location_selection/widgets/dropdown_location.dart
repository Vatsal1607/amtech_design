import 'package:amtech_design/custom_widgets/svg_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/strings.dart';
import '../location_selection_provider.dart';

class DropdownLocation extends StatelessWidget {
  final String accountType;
  const DropdownLocation({
    super.key,
    required this.accountType,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 17.w),
        decoration: BoxDecoration(
          color: Colors.transparent, // Background color for the dropdown
          borderRadius: BorderRadius.circular(100), // Circular border
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
              child: Consumer<LocationSelectionProvider>(
                builder: (context, provider, child) => DropdownButton<String>(
                  value: provider.dropdownValue,
                  isExpanded: true,
                  // Dropdown color
                  dropdownColor: accountType != '' && accountType == 'business'
                      ? AppColors.seaShell
                      : accountType != '' && accountType == 'personal'
                          ? AppColors.seaMist
                          : AppColors.white,

                  underline: const SizedBox(),
                  icon: const Icon(
                    Icons.keyboard_arrow_down,
                    color: Colors.white,
                  ),
                  // Dropdown icon
                  style: const TextStyle(
                    fontSize: 15,
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

                  items: provider.dropdownItems
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryColor
                              .withOpacity(0.5), // Default color
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: provider.onChangeDropdown,
                  selectedItemBuilder: (BuildContext context) {
                    return provider.dropdownItems.map<Widget>((String value) {
                      return Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          value,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.white, // Style for the selected item
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
      // old dropdown
      // child: Container(
      //   padding: const EdgeInsets.symmetric(horizontal: 16), // Inner padding
      //   decoration: BoxDecoration(
      //     color: Colors.transparent,
      //     borderRadius: BorderRadius.circular(100.r), // Rounded corners
      //     border: Border.all(
      //       color: AppColors.seaShell, // Border color
      //       width: 2, // Border width
      //     ),
      //   ),
      //   child: Consumer<LocationSelectionProvider>(
      //     builder: (context, provider, child) => DropdownButton<String>(
      //       value: provider.dropdownValue,
      //       isExpanded: true, // Makes dropdown take full width of container
      //       underline: const SizedBox(), // Removes default underline
      //       icon: SvgIcon(icon: IconStrings.arrowDropdown), // Dropdown icon
      //       style: GoogleFonts.publicSans(
      //         fontSize: 15.sp,
      //         fontWeight: FontWeight.bold,
      //         color: AppColors.white, // Selected text color
      //       ),
      //       hint: RichText(
      //         text: TextSpan(
      //           text: 'Select Your ',
      //           style: GoogleFonts.publicSans(
      //             fontSize: 14.sp,
      //             color: AppColors.white,
      //           ),
      //           children: <TextSpan>[
      //             TextSpan(
      //               text: 'Complex',
      //               style: GoogleFonts.publicSans(
      //                 fontSize: 14.sp,
      //                 fontWeight: FontWeight.bold,
      //                 color: AppColors.white,
      //               ),
      //             ),
      //           ],
      //         ),
      //       ),
      //       items: <String>[
      //         'Titanium City Center',
      //         'Arista Business Hub',
      //         'Silp Corporate  Park',
      //         '323 Corporate Park'
      //       ].map<DropdownMenuItem<String>>((String value) {
      //         return DropdownMenuItem<String>(
      //           value: value,
      //           child: Text(
      //             value,
      //             style: GoogleFonts.publicSans(
      //               fontSize: 14.sp,
      //               fontWeight: FontWeight.bold,
      //               // color: AppColors.primaryColor.withOpacity(0.5),
      //               color: // White color for the selected item
      //                   AppColors.primaryColor
      //                       .withOpacity(0.5), // Default color
      //             ),
      //           ),
      //         );
      //       }).toList(),
      //       onChanged: provider.onChangeDropdown,
      //     ),
      //   ),
      // ),
    );
  }
}
