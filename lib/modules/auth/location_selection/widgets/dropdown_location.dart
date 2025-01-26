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
    /// NEW dropdown (Working on dynamic)
    // return SearchField<String>(
    //   controller: provider.locationSearchController,
    //   suggestions: provider.locations
    //       .map((location) => SearchFieldListItem<String>(location))
    //       .toList(),
    //   suggestionState: Suggestion.expand,
    //   textInputAction: TextInputAction.done,
    //   hint: 'Search location',
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
    //   maxSuggestionsInViewPort: 4,
    //   itemHeight: 50,
    //   onSuggestionTap: (SearchFieldListItem<String> item) {
    //     // Update the controller's text to reflect the selected value
    //     provider.locationSearchController.text = item.searchKey;
    //     debugPrint('Selected: ${item.searchKey}');
    //   },
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
