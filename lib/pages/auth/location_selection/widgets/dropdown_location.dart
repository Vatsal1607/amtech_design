import 'package:amtech_design/core/utils/strings.dart';
import 'package:amtech_design/custom_widgets/svg_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../../core/utils/app_colors.dart';
import '../location_selection_provider.dart';

class DropdownLocation extends StatelessWidget {
  const DropdownLocation({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16), // Inner padding
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(100.r), // Rounded corners
          border: Border.all(
            color: AppColors.seaShell, // Border color
            width: 2, // Border width
          ),
        ),
        child: Consumer<LocationSelectionProvider>(
          builder: (context, provider, child) => DropdownButton<String>(
            value: provider.dropdownValue,
            isExpanded: true, // Makes dropdown take full width of container
            underline: const SizedBox(), // Removes default underline
            icon: SvgIcon(icon: IconStrings.arrowDropdown), // Dropdown icon
            style: GoogleFonts.publicSans(
              fontSize: 15.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.white, // Selected text color
            ),
            hint: RichText(
              text: TextSpan(
                text: 'Select Your ',
                style: GoogleFonts.publicSans(
                  fontSize: 14.sp,
                  color: AppColors.white,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: 'Complex',
                    style: GoogleFonts.publicSans(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.white,
                    ),
                  ),
                ],
              ),
            ),

            items: <String>[
              'Titanium City Center',
              'Arista Business Hub',
              'Silp Corporate  Park',
              '323 Corporate Park'
            ].map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(
                  value,
                  style: GoogleFonts.publicSans(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                    // color: AppColors.primaryColor.withOpacity(0.5),
                    color: // White color for the selected item
                        AppColors.primaryColor
                            .withOpacity(0.5), // Default color
                  ),
                ),
              );
            }).toList(),
            onChanged: provider.onChangeDropdown,
          ),
        ),
      ),
    );
  }
}
