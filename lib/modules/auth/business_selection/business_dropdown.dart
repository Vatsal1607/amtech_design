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
import '../../../core/utils/constants/keys.dart';
import '../../../models/business_list_model.dart';
import '../../../services/local/shared_preferences_service.dart';

class BusinessDropdown extends StatelessWidget {
  final BusinessSelectionProvider provider;
  const BusinessDropdown({
    super.key,
    required this.provider,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<BusinessSelectionProvider>(
      builder: (context, _, child) => SearchField<BusinessList>(
        controller: provider.searchController,
        suggestionDirection: SuggestionDirection.down,
        hint: 'Select Your business',
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
        onSuggestionTap: (selectedItem) async {
          provider.selectBusiness(selectedItem.item!);
          if (selectedItem.item!.businessName != null) {
            provider.searchController.text =
                selectedItem.item!.businessName.toString();
          }
          debugPrint(
              'selectedItem is: ${provider.selectedBusiness?.businessName}');
          if (provider.selectedBusiness != null) {
            /// Save selected business's secondaryAccess
            await provider.saveSelectedBusinessSecondaryAccess(
              provider.filteredBusinessList,
              provider.selectedBusiness!.businessName!,
            );

            // Retrieve and print saved secondaryAccess data
            log('locally stored secondaryAccess: ${sharedPrefsService.getString(SharedPrefsKeys.secondaryAccessList)}');
          }
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
  }
}
