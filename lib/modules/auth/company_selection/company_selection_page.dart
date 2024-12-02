import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/strings.dart';
import '../../../custom_widgets/custom_button.dart';
import '../../../custom_widgets/svg_icon.dart';
import '../../../routes.dart';
import 'company_dropdown.dart';

class CompanySelectionPage extends StatelessWidget {
  const CompanySelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    debugPrint('Company selection page called');
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: SvgIcon(
            icon: IconStrings.arrowBack,
          ),
        ),
        centerTitle: false,
        titleSpacing: 0, // Removes extra space
        title: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Text(
            'back'.toUpperCase(),
            style: const TextStyle(
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
                top: 150.0,
                left: 34.w,
                right: 34.w,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Choose Your Company',
                    style: GoogleFonts.publicSans(
                      fontSize: 40.sp,
                      color: AppColors.disabledColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    'SELECT YOUR company or add one.'.toUpperCase(),
                    style: GoogleFonts.publicSans(
                      fontSize: 15.sp,
                      color: AppColors.seaShell,
                    ),
                  ),
                  SizedBox(height: 16.h),

                  /// Dropdown button
                  const CompanyDropdown(),
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
                  debugPrint('Navigate to login page');
                  Navigator.pushNamed(context, Routes.login);
                },
                bgColor: AppColors.disabledColor,
                textColor: AppColors.primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
