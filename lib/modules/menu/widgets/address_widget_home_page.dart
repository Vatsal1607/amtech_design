import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:marquee/marquee.dart';
import 'package:provider/provider.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/constant.dart';
import '../../../core/utils/constants/keys.dart';
import '../../../core/utils/enums/enums.dart';
import '../../../custom_widgets/buttons/small_edit_button.dart';
import '../../../routes.dart';
import '../../../services/local/shared_preferences_service.dart';
import '../menu_provider.dart';

class AddressWidgetHomePage extends StatelessWidget {
  const AddressWidgetHomePage({
    super.key,
    required this.accountType,
    required this.provider,
  });  

  final String accountType;
  final MenuProvider provider;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'Deliver To, ',
              style: GoogleFonts.publicSans(
                fontSize: 12.sp,
                color: getColorAccountType(
                  accountType: accountType,
                  businessColor: AppColors.primaryColor,
                  personalColor: AppColors.darkGreenGrey,
                ),
              ),
            ),
            Text(
              'HOME',
              style: GoogleFonts.publicSans(
                fontSize: 12.sp,
                fontWeight: FontWeight.bold,
                color: getColorAccountType(
                  accountType: accountType,
                  businessColor: AppColors.primaryColor.withOpacity(0.8),
                  personalColor: AppColors.darkGreenGrey.withOpacity(0.8),
                ),
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: provider.addressWidth.w,
              height: 20.h,
              child: Consumer<MenuProvider>(builder: (context, _, child) {
                final address = provider.homeMenuResponse?.data?.address;
                final storedAddress = sharedPrefsService
                    .getString(SharedPrefsKeys.selectedAddress);
                if ((address == null || address.isEmpty) &&
                    (storedAddress == null || storedAddress.isEmpty)) {
                  return SizedBox(
                    child: Text(
                      'Please Select Your Address',
                      style: GoogleFonts.publicSans(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                }
                //* Measure text width Address
                TextPainter textPainter = TextPainter(
                  text: TextSpan(
                    text: provider.selectedAddressType == HomeAddressType.local
                        ? storedAddress
                        : address,
                    style: GoogleFonts.publicSans(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  maxLines: 1,
                  textDirection: TextDirection.ltr,
                )..layout(maxWidth: provider.addressWidth.w);

                // If text overflows, use Marquee, otherwise use normal Text
                bool isOverflowing = textPainter.didExceedMaxLines;
                return isOverflowing
                    ? Marquee(
                        velocity: 20,
                        scrollAxis: Axis.horizontal,
                        blankSpace: 15,
                        pauseAfterRound: const Duration(seconds: 3),
                        text: provider.selectedAddressType ==
                                HomeAddressType.local
                            ? '$storedAddress.'
                            : '$address.',
                        style: GoogleFonts.publicSans(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.bold,
                          color: getColorAccountType(
                            accountType: accountType,
                            businessColor: AppColors.primaryColor,
                            personalColor: AppColors.darkGreenGrey,
                          ),
                        ),
                      )
                    : Text(
                        provider.selectedAddressType == HomeAddressType.local
                            ? storedAddress ?? ''
                            : address ?? '',
                        style: GoogleFonts.publicSans(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.bold,
                          color: getColorAccountType(
                            accountType: accountType,
                            businessColor: AppColors.primaryColor,
                            personalColor: AppColors.darkGreenGrey,
                          ),
                        ),
                      );
              }),
            ),
            SizedBox(width: 4.w),
            //* Small Edit Button
            SizedBox(
              height: 26.h,
              width: 64.w,
              child: SmallEditButton(
                text: 'CHANGE',
                onTap: () {
                  Navigator.pushNamed(context, Routes.savedAddress);
                },
                accountType: accountType,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
