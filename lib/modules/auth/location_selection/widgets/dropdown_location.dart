import 'package:amtech_design/custom_widgets/svg_icon.dart';
import 'package:amtech_design/modules/auth/location_selection/location_selection_provider.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:searchfield/searchfield.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/constant.dart';
import '../../../../core/utils/strings.dart';

class DropdownLocation extends StatelessWidget {
  final String accountType;
  final LocationSelectionProvider provider;
  const DropdownLocation({
    super.key,
    required this.accountType,
    required this.provider,
  });

  @override
  Widget build(BuildContext context) {
    /// NEW dropdown
    // return SearchField<String>(
    //   controller: provider.locationSearchController,
    //   suggestionDirection: SuggestionDirection.down,
    //   hint: 'Select Location',
    //   searchInputDecoration: SearchInputDecoration(
    //     cursorColor: AppColors.seaShell,
    //     hintStyle:
    //         GoogleFonts.publicSans(color: AppColors.seaShell.withOpacity(.8)),
    //     searchStyle:
    //         GoogleFonts.publicSans(color: AppColors.seaShell.withOpacity(.8)),
    //     border: kDropdownBorderStyle,
    //     enabledBorder: kDropdownBorderStyle,
    //     focusedBorder: kDropdownBorderStyle,
    //     prefixIcon: const SvgIcon(icon: IconStrings.selectBusiness),
    //     suffixIcon: const SvgIcon(icon: IconStrings.dropdown),
    //   ),
    //   suggestions: [
    //     'Titanium City Center',
    //     'Arista Business Hub',
    //     'Silp Corporate Park',
    //     '323 Corporate Park',
    //   ].map((location) => SearchFieldListItem<String>(location)).toList(),
    //   // onSearchTextChanged: (query) {
    //   //   provider.filterLocations(query); // Filter logic in provider
    //   //   if (query.isEmpty) {
    //   //     provider.selectLocation(null); // Clear selected location
    //   //   }
    //   // },
    //   selectedValue: provider.selectedLocation != null
    //       ? SearchFieldListItem<String>(provider.selectedLocation!)
    //       : null,
    //   // selectedValue: provider.selectedLocation != null &&
    //   //         [
    //   //           'Titanium City Center',
    //   //           'Arista Business Hub',
    //   //           'Silp Corporate Park',
    //   //           '323 Corporate Park'
    //   //         ].contains(provider.selectedLocation)
    //   //     ? SearchFieldListItem<String>(provider.selectedLocation!)
    //   //     : null,
    //   onSuggestionTap: (selectedItem) {
    //     debugPrint(selectedItem.item);
    //     if (selectedItem.item != null) {
    //       provider.selectLocation(selectedItem.item!);
    //       provider.locationSearchController.text = selectedItem.item!;
    //     }
    //     debugPrint('Selected Location: ${provider.selectedLocation}');
    //   },
    //   // validator: (value) {
    //   //   debugPrint('$value from validator');
    //   //   if (value == null ||
    //   //       ![
    //   //         'Titanium City Center',
    //   //         'Arista Business Hub',
    //   //         'Silp Corporate Park',
    //   //         '323 Corporate Park'
    //   //       ].contains(value.trim())) {
    //   //     return 'Enter a valid location';
    //   //   }
    //   //   return null;
    //   // },
    //   suggestionStyle: GoogleFonts.publicSans(
    //     fontSize: 14.sp,
    //     fontWeight: FontWeight.bold,
    //     color: AppColors.primaryColor,
    //   ),
    //   suggestionsDecoration: SuggestionDecoration(
    //     borderRadius: BorderRadius.circular(25.r),
    //     color: AppColors.seaShell,
    //   ),
    //   suggestionState: Suggestion.expand,
    // );

    /// OLD dropdown
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
            const SvgIcon(icon: IconStrings.location), // Prefix icon
            const SizedBox(width: 8), // Spacing between icon and dropdown
            Expanded(
              child: Consumer<LocationSelectionProvider>(
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
                    value: provider.selectedLocation,
                    isExpanded: true,
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
                          style: GoogleFonts.publicSans(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryColor,
                          ),
                        ),
                      );
                    }).toList(),
                    underline: const SizedBox.shrink(),
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
  }
}
