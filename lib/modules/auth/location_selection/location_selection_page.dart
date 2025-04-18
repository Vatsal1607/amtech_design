import 'package:amtech_design/core/utils/app_colors.dart';
import 'package:amtech_design/core/utils/constants/keys.dart';
import 'package:amtech_design/core/utils/strings.dart';
import 'package:amtech_design/custom_widgets/buttons/custom_button.dart';
import 'package:amtech_design/custom_widgets/snackbar.dart';
import 'package:amtech_design/custom_widgets/svg_icon.dart';
import 'package:amtech_design/modules/auth/location_selection/location_selection_provider.dart';
import 'package:amtech_design/modules/auth/location_selection/widgets/dropdown_location.dart';
import 'package:amtech_design/routes.dart';
import 'package:amtech_design/services/local/shared_preferences_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class LocationSelectionPage extends StatelessWidget {
  const LocationSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    final String accountType =
        context.read<LocationSelectionProvider>().accountType ?? '';
    final provider =
        Provider.of<LocationSelectionProvider>(context, listen: false);
    return Scaffold(
      resizeToAvoidBottomInset: false, //image did't move by the keyboard
      backgroundColor: accountType != '' && accountType == 'business'
          ? AppColors.primaryColor
          : accountType != '' && accountType == 'personal'
              ? AppColors.darkGreenGrey
              : AppColors
                  .white, // NOTE: when selected account is 'null' or '' then default color is white
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const SvgIcon(
            icon: IconStrings.arrowBack,
          ),
        ),
        centerTitle: false,
        titleSpacing: 0, // Removes extra space
        title: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Text(
            'back'.toUpperCase(),
            style: GoogleFonts.publicSans(
              color: AppColors.white,
            ),
          ),
        ),
      ),
      extendBodyBehindAppBar: true, // show content of body behind appbar
      body: Stack(
        children: [
          Image.asset(
            width: 1.sw,
            height: 1.sh,
            ImageStrings.locationSelectionBg,
            // fit: BoxFit.cover,
          ),
          Positioned.fill(
            child: Padding(
              padding: EdgeInsets.only(
                top: 130.h,
                left: 34.w,
                right: 34.w,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Choose Store',
                    style: GoogleFonts.publicSans(
                      fontSize: 40.sp,
                      color: accountType != '' && accountType == 'business'
                          ? AppColors.disabledColor
                          : accountType != '' && accountType == 'personal'
                              ? AppColors.seaMist
                              : AppColors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    'SELECT YOUR complex, business park or working space.'
                        .toUpperCase(),
                    style: GoogleFonts.publicSans(
                      fontSize: 15.sp,
                      color: accountType != '' && accountType == 'business'
                          ? AppColors.seaShell
                          : accountType != '' && accountType == 'personal'
                              ? AppColors.seaMist
                              : AppColors.white,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  //* Dropdown button
                  Consumer<LocationSelectionProvider>(
                    builder: (context, _, child) => DropdownLocation(
                      accountType: accountType,
                      provider: provider,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(
                bottom: 70.h,
                left: 34.w,
                right: 34.w,
              ),
              child: CustomButton(
                height: 48.h,
                onTap: () {
                  //* store locaton localy
                  sharedPrefsService.setString(
                    SharedPrefsKeys.location,
                    provider.searchController.text,
                  );
                  if (provider.searchController.text.isNotEmpty &&
                      provider.locations.any((location) =>
                          location == provider.searchController.text)) {
                    if (accountType != '' && accountType == 'business') {
                      Navigator.pushNamed(context, Routes.companySelection);
                      provider.clearSelectedLocation();
                    } else if (accountType != '' && accountType == 'personal') {
                      Navigator.pushNamed(context, Routes.login);
                      provider.clearSelectedLocation();
                    }
                  } else {
                    customSnackBar(
                      context: context,
                      message: 'Please Select Location',
                      backgroundColor: AppColors.seaShell,
                      textColor: AppColors.primaryColor,
                    );
                  }
                },
                bgColor: accountType != '' && accountType == 'business'
                    ? AppColors.disabledColor
                    : accountType != '' && accountType == 'personal'
                        ? AppColors.seaMist
                        : AppColors.white,
                textColor: accountType != '' && accountType == 'business'
                    ? AppColors.primaryColor
                    : accountType != '' && accountType == 'personal'
                        ? AppColors.darkGreenGrey
                        : AppColors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
