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
  final BusinessSelectionProvider provider;
  const BusinessDropdown({
    super.key,
    required this.provider,
  });

  @override
  Widget build(BuildContext context) {
    // debugPrint('Selected Business: ${provider.selectedBusiness?.businessName}');
    // debugPrint(
    //     'filteredBusinessList: ${provider.filteredBusinessList.map((e) => e.businessName).toList()}');
    // * New2 dropdown
    return Consumer<BusinessSelectionProvider>(
      builder: (context, _, child) => SearchField<BusinessList>(
        controller: provider.searchController,
        suggestionDirection: SuggestionDirection.down,
        hint: 'Select Your business',
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
          prefixIcon: const SvgIcon(icon: IconStrings.selectBusiness),
          suffixIcon: const SvgIcon(icon: IconStrings.dropdown),
        ),
        suggestions: provider.filteredBusinessList
            .map(
              (business) => SearchFieldListItem<BusinessList>(
                business.businessName!,
                item: business,
              ),
            )
            .toList(),
        onSearchTextChanged: (query) {
          provider.filterBusinesses(query);
          // * Fetch from API if the query meets the criteria
          if (query.isNotEmpty && query.length % 3 == 0) {
            provider.getBusinessList(searchText: query);
          } else if (query.isEmpty) {
            provider.selectBusiness(null); // Clear selected business
          }
          if (provider.filteredBusinessList.isEmpty) {
            // Handle non-matching input
            provider.selectBusiness(null);
          }
        },
        // * old
        // onSearchTextChanged: (query) {
        //   provider.filterBusinesses(query);
        //   if (query.isNotEmpty && query.length % 3 == 0) {
        //     provider.getBusinessList(searchText: query); // * api call
        //     return provider.filteredBusinessList
        //         .map((business) => SearchFieldListItem<BusinessList>(
        //               business.businessName!,
        //               item: business,
        //             ))
        //         .toList();
        //   }
        // },
        onScroll: (scrollOffset, maxScrollExtent) {
          if (scrollOffset == maxScrollExtent &&
              !provider.isLoading &&
              provider.suggestionList.length < provider.totalRecords) {
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

        // * Ensure the selectedValue is either null or exists in the suggestions list
        selectedValue: provider.selectedBusiness != null &&
                provider.filteredBusinessList.any((business) =>
                    business.businessName ==
                    provider.selectedBusiness?.businessName)
            ? SearchFieldListItem<BusinessList>(
                // ! Note: dont use Null check operator here (it can be nullable)
                provider.selectedBusiness!.businessName ?? '',
                item: provider.selectedBusiness,
              )
            : null,
        // * Old selected value with suggestionList
        // selectedValue: provider.selectedBusiness != null &&
        //         provider.suggestionList.any((business) =>
        //             business.businessName ==
        //             provider.selectedBusiness?.businessName)
        //     ? SearchFieldListItem<BusinessList>(
        //         provider.selectedBusiness!.businessName!,
        //         item: provider.selectedBusiness,
        //       )
        //     : null,
        suggestionState: Suggestion.expand,
        onSuggestionTap: (selectedItem) {
          provider.selectBusiness(selectedItem.item!);
          debugPrint('selectedItem is: $selectedItem');
        },
        validator: (value) {
          debugPrint('$value from validator');
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
      ),
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
  }
}
