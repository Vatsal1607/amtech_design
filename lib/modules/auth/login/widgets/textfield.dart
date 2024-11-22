import 'package:amtech_design/modules/auth/login/login_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../../core/utils/app_colors.dart';

class Textfield extends StatelessWidget {
  const Textfield({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Country Code Selection
        Container(
          decoration: const BoxDecoration(
            color: AppColors.white,
            shape: BoxShape.circle,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Consumer<LoginProvider>(
            builder: (context, provider, child) => DropdownButton<String>(
              value: provider.selectedCountryCode,
              items: provider.countryCodes
                  .map(
                    (code) => DropdownMenuItem(
                      value: code,
                      child: Text(
                        code,
                        style: GoogleFonts.publicSans(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ),
                  )
                  .toList(),
              onChanged: provider.onChangeCountryCode,
              underline: const SizedBox(),
            ),
          ),
        ),
        SizedBox(width: 11.w),
        // Mobile Number Text Field
        Expanded(
          child: Consumer<LoginProvider>(
            builder: (context, provider, child) => TextFormField(
              controller: provider.phoneController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                filled: true,
                fillColor: AppColors.white,
                hintText: 'Enter mobile number',
                hintStyle: GoogleFonts.publicSans(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryColor.withOpacity(0.5),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(100.r),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 12),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
