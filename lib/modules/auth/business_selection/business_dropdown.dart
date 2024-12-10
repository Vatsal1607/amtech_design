import 'dart:developer';

import 'package:amtech_design/custom_widgets/svg_icon.dart';
import 'package:amtech_design/modules/auth/business_selection/business_selection_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:searchfield/searchfield.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/strings.dart';
import '../../../core/utils/constant.dart';
import '../../../models/business_list_model.dart';

class BusinessDropdown extends StatelessWidget {
  const BusinessDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    final provider =
        Provider.of<BusinessSelectionProvider>(context, listen: false);
    Widget searchChild(x, {bool isSelected = false}) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text(x,
              style: TextStyle(
                  fontSize: 18,
                  color: isSelected ? Colors.green : Colors.black)),
        );

    // * New2 dropdown
    return Consumer<BusinessSelectionProvider>(
      builder: (context, _, child) {
        return SearchField<BusinessList>(
          suggestionDirection: SuggestionDirection.down,
          hint: 'Select Your Company',
          // onTap: () {
          //   provider.filterBusinesses('');
          // },
          searchInputDecoration: SearchInputDecoration(
            cursorColor: AppColors.seaShell,
            hintStyle:
                GoogleFonts.publicSans(color: AppColors.seaShell.withOpacity(.8)),
            searchStyle:
                GoogleFonts.publicSans(color: AppColors.seaShell.withOpacity(.8)),
            border: kDropdownBorderStyle,
            enabledBorder: kDropdownBorderStyle,
            focusedBorder: kDropdownBorderStyle,
            prefixIcon: SvgIcon(icon: IconStrings.selectBusiness),
            suffixIcon: SvgIcon(icon: IconStrings.dropdown),
          ),
          suggestions: [
            ...provider.suggestionList
                .map(
                  (business) => SearchFieldListItem<BusinessList>(
                    business.businessName!,
                    item: business,
                  ),
                )
                .toList(),
          ],
          onScroll: (scrollOffset, maxScrollExtent) {
            log('scrollOffset: $scrollOffset');
            log('scrollOffset: $maxScrollExtent');
            if (scrollOffset == maxScrollExtent && !provider.isLoading) {
              debugPrint('Api called from scrolling');
              provider.getBusinessList(
                currentPage: provider.currentPage + 1,
              );
            }
          },
          suggestionsDecoration: SuggestionDecoration(
            borderRadius: BorderRadius.circular(25.r),
            color: AppColors.seaShell,
          ),
          onSearchTextChanged: (query) {
            provider.getBusinessList(searchText: query); // api call
            provider.filterBusinesses(query);
            return provider.filteredBusinessList
                .map((business) => SearchFieldListItem<BusinessList>(
                      business.businessName!,
                      item: business,
                    ))
                .toList();
          },
          // Ensure the selectedValue is either null or exists in the suggestions list
          selectedValue: provider.selectedBusiness != null &&
                  provider.suggestionList.any((business) =>
                      business.businessName ==
                      provider.selectedBusiness?.businessName)
              ? SearchFieldListItem<BusinessList>(
                  provider.selectedBusiness!.businessName!,
                  item: provider.selectedBusiness,
                )
              : null,
          // old selected value
          // selectedValue: provider.selectedBusiness != null
          //     ? SearchFieldListItem<BusinessList>(
          //         provider.selectedBusiness!.businessName!,
          //         item: provider.selectedBusiness,
          //       )
          //     : null,
          suggestionState: Suggestion.expand,
          onSuggestionTap: (selectedItem) {
            provider.selectBusiness(selectedItem.item!);
          },
          validator: (value) {
            if (value == null ||
                !provider.suggestionList
                    .any((business) => business.businessName == value.trim())) {
              return 'Enter a valid company name';
            }
            return null;
          },
          suggestionStyle: GoogleFonts.publicSans(
            fontSize: 14.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.primaryColor,
          ),
        );
      },
    );

    // * New dropdown (searchable)
    // return SearchField<BusinessList>(
    //   suggestionDirection: SuggestionDirection.flex,
    //   onSearchTextChanged: (query) {
    //     // Filter the suggestionList based on the query
    //     final filter = provider.suggestionList
    //         .where((business) =>
    //             business.businessName != null &&
    //             business.businessName!
    //                 .toLowerCase()
    //                 .contains(query.toLowerCase()))
    //         .toList();

    //     // Return filtered suggestions
    //     return filter
    //         .map((business) => SearchFieldListItem<BusinessList>(
    //               business.businessName!,
    //               item: business,
    //               child: searchChild(business.businessName!),
    //             ))
    //         .toList();
    //   },
    //   selectedValue: provider.selectedValue != null
    //       ? SearchFieldListItem<BusinessList>(
    //           provider.selectedValue!.businessName!,
    //           item: provider.selectedValue.o,
    //         )
    //       : null,
    //   autovalidateMode: AutovalidateMode.onUserInteraction,
    //   validator: (value) {
    //     if (value == null ||
    //         !provider.suggestionList.any(
    //           (business) => business.businessName?.trim() == value.trim(),
    //         )) {
    //       return 'Enter a valid company name';
    //     }
    //     return null;
    //   },
    //   onSubmit: (value) {
    //     // Handle value submission if required
    //   },
    //   autofocus: false,
    //   key: const Key('searchfield'),
    //   hint: 'Select Your Company',
    //   itemHeight: 50,
    //   scrollbarDecoration: ScrollbarDecoration(
    //     thickness: 12,
    //     radius: Radius.circular(6),
    //     trackColor: AppColors.seaShell,
    //     trackBorderColor: AppColors.seaShell,
    //   ),
    //   suggestionStyle: GoogleFonts.publicSans(
    //     fontSize: 14.sp,
    //     fontWeight: FontWeight.bold,
    //     color: AppColors.primaryColor,
    //   ),
    //   suggestionItemDecoration: BoxDecoration(
    //     color: AppColors.seaShell,
    //     border: Border(
    //       bottom: BorderSide(
    //         width: 2,
    //         color: AppColors.seaShell,
    //       ),
    //     ),
    //   ),
    //   searchInputDecoration: SearchInputDecoration(
    //     hintStyle: GoogleFonts.publicSans(
    //       fontSize: 14.sp,
    //       fontWeight: FontWeight.w400,
    //       color: AppColors.white,
    //     ),
    //     prefixIcon: SvgIcon(icon: IconStrings.selectBusiness),
    //     enabledBorder: kSearchDropDownBorder,
    //     focusedBorder: kSearchDropDownBorder,
    //     border: OutlineInputBorder(
    //       borderRadius: BorderRadius.circular(24),
    //       borderSide: const BorderSide(
    //         width: 2,
    //         color: AppColors.seaShell,
    //         style: BorderStyle.solid,
    //       ),
    //     ),
    //     contentPadding: const EdgeInsets.symmetric(
    //       horizontal: 20,
    //     ),
    //   ),
    //   suggestionsDecoration: SuggestionDecoration(
    //     elevation: 8.0,
    //     selectionColor: Colors.grey.shade100,
    //     hoverColor: Colors.purple.shade100,
    //     borderRadius: BorderRadius.only(
    //       bottomLeft: Radius.circular(10),
    //       bottomRight: Radius.circular(10),
    //     ),
    //   ),
    //   suggestions: provider.suggestionList
    //       .map((business) => SearchFieldListItem<BusinessList>(
    //             business.businessName!,
    //             item: business,
    //           ))
    //       .toList(),
    //   suggestionState: Suggestion.expand,
    //   onSuggestionTap: (SearchFieldListItem<BusinessList> selectedItem) {
    //     provider.selectedValue = selectedItem.item.toString();
    //     // Trigger additional actions if needed
    //   },
    // );

    //! Old dropdown: keep it for ref.
    // return Center(
    //   child: Container(
    //     padding: EdgeInsets.symmetric(horizontal: 17.w),
    //     decoration: BoxDecoration(
    //       color: Colors.transparent, // Background color for the dropdown
    //       borderRadius: BorderRadius.circular(100.r), // Circular border
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
    //           child: Consumer<BusinessSelectionProvider>(
    //             builder: (context, provider, child) =>
    //                 DropdownButtonHideUnderline(
    //               child: DropdownButton2<String>(
    //                 dropdownStyleData: DropdownStyleData(
    //                   decoration: BoxDecoration(
    //                     color: AppColors.seaShell,
    //                     borderRadius:
    //                         BorderRadius.circular(10), // Rounded corners
    //                     border: Border.all(
    //                       color: Colors.grey, // Border color
    //                       width: 1, // Border width
    //                     ),
    //                   ),
    //                 ),
    //                 value: provider.dropdownValue,
    //                 isExpanded: true,
    //                 style: TextStyle(
    //                   fontSize: 15.sp,
    //                   fontWeight: FontWeight.bold,
    //                   color: Colors.white,
    //                 ),
    //                 hint: RichText(
    //                   text: const TextSpan(
    //                     text: 'Select Your ',
    //                     style: TextStyle(
    //                       fontSize: 14,
    //                       color: Colors.white,
    //                     ),
    //                     children: <TextSpan>[
    //                       TextSpan(
    //                         text: 'Complex',
    //                         style: TextStyle(
    //                           fontSize: 14,
    //                           fontWeight: FontWeight.bold,
    //                           color: Colors.white,
    //                         ),
    //                       ),
    //                     ],
    //                   ),
    //                 ),
    //                 items: [
    //                   ...provider.dropdownItems
    //                       .map<DropdownMenuItem<String>>((String value) {
    //                     return DropdownMenuItem<String>(
    //                       value: value,
    //                       child: Text(
    //                         value,
    //                         style: TextStyle(
    //                           fontSize: 14.sp,
    //                           fontWeight: FontWeight.bold,
    //                           color: AppColors.primaryColor,
    //                         ),
    //                       ),
    //                     );
    //                   }).toList(),
    //                   DropdownMenuItem<String>(
    //                     enabled: false, // non-selectadble
    //                     child: GestureDetector(
    //                       onTap: () {
    //                         // Navigate to business register page
    //                         Navigator.pushNamed(
    //                           context,
    //                           Routes.register,
    //                         );
    //                       },
    //                       child: Container(
    //                         padding: EdgeInsets.all(10.w),
    //                         decoration: BoxDecoration(
    //                           color: AppColors.primaryColor,
    //                           borderRadius: BorderRadius.circular(25.r),
    //                         ),
    //                         child: Row(
    //                           mainAxisSize: MainAxisSize.min,
    //                           mainAxisAlignment: MainAxisAlignment.center,
    //                           children: [
    //                             Text(
    //                               'Can\'t find your business? '.toUpperCase(),
    //                               style: GoogleFonts.publicSans(
    //                                 fontSize: 12.sp,
    //                                 color: AppColors.seaShell,
    //                               ),
    //                             ),
    //                             Text(
    //                               'Register Now'.toUpperCase(),
    //                               style: GoogleFonts.publicSans(
    //                                 fontSize: 12.sp,
    //                                 color: AppColors.disabledColor,
    //                                 fontWeight: FontWeight.bold,
    //                               ),
    //                             ),
    //                           ],
    //                         ),
    //                       ),
    //                     ),
    //                   ),
    //                 ],
    //                 underline: const SizedBox.shrink(),
    //                 onChanged: provider.onChangeDropdown,
    //                 selectedItemBuilder: (BuildContext context) {
    //                   return provider.dropdownItems.map<Widget>((String value) {
    //                     return Align(
    //                       alignment: Alignment.centerLeft,
    //                       child: Text(
    //                         value,
    //                         style: const TextStyle(
    //                           fontSize: 14,
    //                           color:
    //                               Colors.white, // Style for the selected item
    //                         ),
    //                       ),
    //                     );
    //                   }).toList();
    //                 },
    //               ),
    //             ),
    //           ),
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }
}
