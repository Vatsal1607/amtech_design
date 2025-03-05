import 'package:amtech_design/custom_widgets/svg_icon.dart';
import 'package:amtech_design/modules/auth/location_selection/location_selection_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/constant.dart';
import '../../../../core/utils/strings.dart';

class DropdownLocation extends StatefulWidget {
  final String accountType;
  final LocationSelectionProvider provider;
  const DropdownLocation({
    super.key,
    required this.accountType,
    required this.provider,
  });

  @override
  State<DropdownLocation> createState() => _DropdownLocationState();
}

class _DropdownLocationState extends State<DropdownLocation> {
  @override
  Widget build(BuildContext context) {
    //* NEW dropdown
    return Consumer<LocationSelectionProvider>(
      builder: (context, provider, child) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100.r),
            border: Border.all(
              color: AppColors.seaShell,
              width: 2.w,
            ),
          ),
          child: SearchAnchor.bar(
            onTap: provider.onTapSearch,
            searchController: provider.searchController,
            barHintText: 'Select Your Complex',
            barHintStyle: WidgetStateProperty.all(
              GoogleFonts.publicSans(
                color: provider.isSearchOpen
                    ? getColorAccountType(
                        accountType: widget.accountType,
                        businessColor: AppColors.primaryColor,
                        personalColor: AppColors.darkGreenGrey,
                      )
                    : AppColors.seaShell.withOpacity(0.8),
              ),
            ),
            barTextStyle: WidgetStateProperty.all(
              GoogleFonts.publicSans(
                color: provider.isSearchOpen
                    ? getColorAccountType(
                        accountType: widget.accountType,
                        businessColor: AppColors.primaryColor,
                        personalColor: AppColors.darkGreenGrey,
                      )
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
            //* bgColor
            barBackgroundColor: WidgetStateProperty.all(
              provider.isSearchOpen ? Colors.white : Colors.transparent,
            ),
            viewTrailing: [
              Padding(
                padding: EdgeInsets.only(right: 13.w),
                child: SvgIcon(
                  icon: IconStrings.arrowUp,
                  color: getColorAccountType(
                    accountType: widget.accountType,
                    businessColor: AppColors.primaryColor,
                    personalColor: AppColors.darkGreenGrey,
                  ),
                ),
              ),
            ],
            viewLeading: Padding(
              padding: EdgeInsets.only(left: 8.w, right: 8.w),
              child: SvgIcon(
                icon: IconStrings.selectBusiness,
                color: getColorAccountType(
                  accountType: widget.accountType,
                  businessColor: AppColors.primaryColor,
                  personalColor: AppColors.darkGreenGrey,
                ),
              ),
            ),
            barLeading: SvgIcon(
              icon: IconStrings.selectBusiness,
              color: !provider.isSearchOpen
                  ? AppColors.seaShell
                  : getColorAccountType(
                      accountType: widget.accountType,
                      businessColor: AppColors.primaryColor,
                      personalColor: AppColors.darkGreenGrey,
                    ),
            ),
            barTrailing: [
              SvgIcon(
                icon: IconStrings.arrowDropdown,
                color: getColorAccountType(
                  accountType: widget.accountType,
                  businessColor: AppColors.seaShell,
                  personalColor: AppColors.seaMist,
                ),
              ),
            ],

            suggestionsBuilder: (context, controller) {
              final query = controller.text.toLowerCase();
              final filteredLocations = provider.locations
                  .where((location) => location.toLowerCase().contains(query))
                  .toList();
              return filteredLocations.map((location) {
                return ListTile(
                  title: Text(location),
                  onTap: () {
                    provider.onItemTap();
                    controller.closeView(location);
                    FocusManager.instance.primaryFocus
                        ?.unfocus(); // Unfocus text field
                    debugPrint('Selected: $location');
                  },
                );
              }).toList();
            },
            viewShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.r)),
          ),
        );
      },
    );
  }
}
