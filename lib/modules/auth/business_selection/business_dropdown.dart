import 'package:amtech_design/custom_widgets/loader/custom_loader.dart';
import 'package:amtech_design/custom_widgets/svg_icon.dart';
import 'package:amtech_design/modules/auth/business_selection/business_selection_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/strings.dart';

class BusinessDropdown extends StatelessWidget {
  final BusinessSelectionProvider provider;
  const BusinessDropdown({
    super.key,
    required this.provider,
  });

  @override
  Widget build(BuildContext context) {
    //* NEW dropdown (Searchanchor.bar)
    return Consumer<BusinessSelectionProvider>(
      builder: (context, _, child) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100.r),
            border: Border.all(
              color: AppColors.seaShell,
              width: 2.w,
            ),
          ),
          child: SearchAnchor.bar(
            onTap: () async {
              provider.onTapSearch();
              //* API call
              await provider.getBusinessList(
                currentPage: 1,
              ); // You can add other parameters here
              // ✅ Force refresh of the search suggestions
              // WidgetsBinding.instance.addPostFrameCallback((_) {
              //   provider.businessSearchController.notifyListeners();
              // });
            },
            searchController: provider.businessSearchController,
            barHintText: 'Select Your Business',
            barHintStyle: WidgetStateProperty.all(
              GoogleFonts.publicSans(
                color: provider.isSearchOpen
                    ? AppColors.primaryColor
                    : AppColors.seaShell.withOpacity(0.8),
              ),
            ),
            barTextStyle: WidgetStateProperty.all(
              GoogleFonts.publicSans(
                color: provider.isSearchOpen
                    ? AppColors.primaryColor
                    : AppColors.seaShell.withOpacity(0.8),
              ),
            ),
            isFullScreen: false,
            viewConstraints: const BoxConstraints(
              minHeight: kToolbarHeight,
              maxHeight: kToolbarHeight * 5,
            ),
            dividerColor: Colors.transparent,
            barElevation: WidgetStateProperty.all(0.0),
            barBackgroundColor: WidgetStateProperty.all(
              provider.isSearchOpen ? Colors.white : Colors.transparent,
              // Colors.transparent,
            ),
            viewTrailing: [
              Padding(
                padding: EdgeInsets.only(right: 13.w),
                child: const SvgIcon(
                  icon: IconStrings.arrowUp,
                  color: AppColors.primaryColor,
                ),
              ),
            ],
            viewLeading: Padding(
              padding: EdgeInsets.only(left: 8.w, right: 8.w),
              child: const SvgIcon(
                icon: IconStrings.selectBusiness,
                color: AppColors.primaryColor,
              ),
            ),
            barLeading: SvgIcon(
              icon: IconStrings.selectBusiness,
              color: !provider.isSearchOpen
                  ? AppColors.seaShell
                  : AppColors.primaryColor,
            ),
            barTrailing: [
              SvgIcon(
                icon: IconStrings.arrowDropdown,
                color: !provider.isSearchOpen
                    ? AppColors.seaShell
                    : AppColors.primaryColor,
              ),
            ],
            suggestionsBuilder: (context, controller) {
              // if (provider.isLoading) {
              if (provider.filteredBusinessList.isEmpty) {
                return const [
                  Center(
                    child: CustomLoader(
                      backgroundColor: AppColors.primaryColor,
                    ),
                  )
                ];
              }
              final query = controller.text.toLowerCase();
              final filteredBusinesses = provider.filteredBusinessList
                  .where((business) =>
                      business.businessName!.toLowerCase().contains(query))
                  .toList();

              return filteredBusinesses.map((business) {
                return ListTile(
                  title: Text(business.businessName!),
                  onTap: () {
                    provider.onItemTap();
                    provider.selectBusiness(business);
                    controller.closeView(business.businessName);
                    provider.businessSearchController.text =
                        business.businessName!;
                    debugPrint('Selected Business: ${business.businessName}');
                    // Optionally save selected business
                    provider.saveSelectedBusinessSecondaryAccess(
                      provider.filteredBusinessList,
                      business.businessName!,
                    );
                  },
                );
              }).toList();
            },
            viewShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25.r),
            ),
          ),
        );
      },
    );

    //* OLD dropdown (Searchfield)
    //! Keep this: It is in Working functionality
    // return Consumer<BusinessSelectionProvider>(
    //   builder: (context, _, child) => SearchField<BusinessList>(
    //     controller: provider.searchController,
    //     suggestionDirection: SuggestionDirection.down,
    //     hint: 'Select Your business',
    //     onTap: () {
    //       provider.getBusinessList(currentPage: 1);
    //     },
    //     searchInputDecoration: SearchInputDecoration(
    //       cursorColor: AppColors.seaShell,
    //       hintStyle:
    //           GoogleFonts.publicSans(color: AppColors.seaShell.withOpacity(.8)),
    //       searchStyle:
    //           GoogleFonts.publicSans(color: AppColors.seaShell.withOpacity(.8)),
    //       border: kDropdownBorderStyle,
    //       enabledBorder: kDropdownBorderStyle,
    //       focusedBorder: kDropdownBorderStyle,
    //       prefixIcon: const SvgIcon(icon: IconStrings.selectBusiness),
    //       suffixIcon: const SvgIcon(icon: IconStrings.dropdown),
    //     ),
    //     suggestions: provider.filteredBusinessList
    //         .map(
    //           (business) => SearchFieldListItem<BusinessList>(
    //             business.businessName!,
    //             item: business,
    //           ),
    //         )
    //         .toList(),
    //     onSearchTextChanged: (query) {
    //       provider.filterBusinesses(query);
    //       // * Fetch from API if the query meets the criteria
    //       if (query.isNotEmpty && query.length % 3 == 0) {
    //         provider.getBusinessList(searchText: query, currentPage: 1);
    //       } else if (query.isEmpty) {
    //         provider.selectBusiness(null); // Clear selected business
    //       }
    //       if (provider.filteredBusinessList.isEmpty) {
    //         provider.selectBusiness(null);
    //       }
    //     },
    //     onScroll: (scrollOffset, maxScrollExtent) {
    //       if (scrollOffset == maxScrollExtent &&
    //           !provider.isLoading &&
    //           provider.suggestionList.length < provider.totalRecords) {
    //         debugPrint('Api called from scrolling');
    //         provider.getBusinessList(
    //           currentPage: provider.currentPage + 1,
    //         );
    //       }
    //     },
    //     suggestionsDecoration: SuggestionDecoration(
    //       borderRadius: BorderRadius.circular(25.r),
    //       color: AppColors.seaShell,
    //     ),

    //     // * Ensure the selectedValue is either null or exists in the suggestions list
    //     selectedValue: provider.selectedBusiness != null &&
    //             provider.filteredBusinessList.any((business) =>
    //                 business.businessName ==
    //                 provider.selectedBusiness?.businessName)
    //         ? SearchFieldListItem<BusinessList>(
    //             // ! Note: dont use Null check operator here (it can be nullable)
    //             provider.selectedBusiness?.businessName ?? '',
    //             item: provider.selectedBusiness,
    //           )
    //         : null,
    //     suggestionState: Suggestion.expand,
    //     onSuggestionTap: (selectedItem) async {
    //       provider.selectBusiness(selectedItem.item!);
    //       if (selectedItem.item?.businessName != null) {
    //         provider.searchController.text =
    //             selectedItem.item!.businessName.toString();
    //       }
    //       debugPrint(
    //           'selectedItem is: ${provider.selectedBusiness?.businessName}');
    //       if (provider.selectedBusiness != null &&
    //           provider.selectedBusiness?.businessName != null) {
    //         /// Save selected business's secondaryAccess
    //         await provider.saveSelectedBusinessSecondaryAccess(
    //           provider.filteredBusinessList,
    //           provider.selectedBusiness!.businessName!,
    //         );
    //         // Retrieve and print saved secondaryAccess data
    //         log('locally stored secondaryAccess: ${sharedPrefsService.getString(SharedPrefsKeys.secondaryAccessList)}');
    //       }
    //     },
    //     validator: (value) {
    //       debugPrint('$value from validator');
    //       if (value == null ||
    //           !provider.suggestionList
    //               .any((business) => business.businessName == value.trim())) {
    //         return 'Enter a valid company name';
    //       }
    //       return null;
    //     },
    //     suggestionStyle: GoogleFonts.publicSans(
    //       fontSize: 14.sp,
    //       fontWeight: FontWeight.bold,
    //       color: AppColors.primaryColor,
    //     ),
    //   ),
    // );
  }
}
