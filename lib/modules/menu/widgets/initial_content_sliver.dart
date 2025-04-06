import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/constant.dart';
import '../../../core/utils/strings.dart';
import '../../../custom_widgets/svg_icon.dart';
import '../menu_provider.dart';
import 'custom_slider_track_shape.dart';
import 'slider_details_widget.dart';

class InitialContentSliver extends StatelessWidget {
  final String accountType;
  const InitialContentSliver({
    super.key,
    required this.accountType,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 10.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Row(
            children: [
              SvgIcon(
                icon: IconStrings.address,
                color: getColorAccountType(
                  accountType: accountType,
                  businessColor: AppColors.primaryColor,
                  personalColor: AppColors.darkGreenGrey,
                ),
              ),
              SizedBox(width: 5.w),
              SizedBox(
                width: 360.w,
                child: RichText(
                  maxLines: 1,
                  overflow: TextOverflow.visible,
                  text: TextSpan(
                    text: 'Deliver to, ',
                    style: GoogleFonts.publicSans(
                      fontSize: 12.sp,
                      color: getColorAccountType(
                        accountType: accountType,
                        businessColor: AppColors.primaryColor.withOpacity(0.8),
                        personalColor: AppColors.darkGreenGrey.withOpacity(0.8),
                      ),
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: 'AMTECH DESIGN, TITANIUM CIT',
                        style: GoogleFonts.publicSans(
                          fontSize: 10.sp,
                          fontWeight: FontWeight.bold,
                          color: getColorAccountType(
                            accountType: accountType,
                            businessColor:
                                AppColors.primaryColor.withOpacity(0.8),
                            personalColor:
                                AppColors.darkGreenGrey.withOpacity(0.8),
                          ),
                        ),
                      ),
                      TextSpan(
                        text: 'AMTECH DESIGN, TITANIUM CIT',
                        style: GoogleFonts.publicSans(
                          fontSize: 10.sp,
                          fontWeight: FontWeight.bold,
                          color: getColorAccountType(
                            accountType: accountType,
                            businessColor:
                                AppColors.primaryColor.withOpacity(0.8),
                            personalColor:
                                AppColors.darkGreenGrey.withOpacity(0.8),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 15.h),

        //* Slider details widget
        ProgressDetailsWidget(
          accountType: accountType,
          filledValue: '₹ 135',
          totalValue: '₹ 2,000',
          label: 'credits used',
          icon: IconStrings.rupee,
        ),
        SizedBox(height: 13.h),

        // Linear progress indicator:
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22.0),
          child: Container(
            height: 6.h, // Height of the credit progress bar
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.lightGreen.withOpacity(.5),
                  AppColors.red.withOpacity(.5),
                ], // Gradient for background
              ),
              borderRadius: BorderRadius.circular(5.0), // Rounded corners
            ),
            child: Stack(
              children: [
                FractionallySizedBox(
                  widthFactor: 0.4, // Width based on progress
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppColors.lightGreen.withOpacity(.5),
                          AppColors.lightGreen.withOpacity(.5),
                        ], // Gradient for active
                      ),
                      borderRadius:
                          BorderRadius.circular(5.0), // Rounded corners
                    ),
                  ),
                ),
              ],
            ),
          ),
          // child: LinearProgressIndicator(
          //   value: 0.2,
          //   backgroundColor: AppColors.red.withOpacity(0.5),
          //   valueColor: AlwaysStoppedAnimation<Color>(
          //     AppColors.lightGreen.withOpacity(0.5),
          //   ),
          // ),
        ),
        SizedBox(height: 10.h),

        /// Credit Slider widget old
        // Consumer<MenuProvider>(
        //   builder:
        //       (BuildContext context, provider, Widget? child) =>
        //           GradientSlider(
        //     thumbAsset: '',
        //     thumbHeight: 0,
        //     thumbWidth: 0,
        //     trackHeight: 3,
        //     trackBorderColor: Colors.transparent,
        //     activeTrackGradient: const LinearGradient(
        //       colors: [
        //         AppColors.lightGreen,
        //         AppColors.lightGreen,
        //       ],
        //     ),
        //     inactiveTrackGradient: LinearGradient(
        //       colors: [
        //         AppColors.lightGreen.withOpacity(0.5),
        //         AppColors.red.withOpacity(0.5),
        //       ],
        //     ),
        //     inactiveTrackColor: Colors.transparent,
        //     slider: Slider(
        //       value: provider.sliderCreditValue,
        //       min: 1,
        //       max: 2000,
        //       thumbColor: Colors.transparent,
        //       onChanged: provider.onChangeCreditSlider,
        //     ),
        //   ),
        // ),

        // SizedBox(height: 18.h),

        //* Slider details widget
        ProgressDetailsWidget(
          accountType: accountType,
          filledValue: '140',
          totalValue: '200',
          label: 'reward points',
          icon: IconStrings.reward,
        ),
        SizedBox(height: 13.h),
        // Slider widget REWARD points
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.h),
          child: Consumer<MenuProvider>(
            builder: (BuildContext context, provider, Widget? child) =>
                SliderTheme(
              data: SliderTheme.of(context).copyWith(
                thumbShape: SliderComponentShape.noThumb,
                overlayShape: SliderComponentShape
                    .noOverlay, // Remove thumb shadow overlay
                activeTrackColor: getColorAccountType(
                  accountType: accountType,
                  businessColor: AppColors.primaryColor,
                  personalColor: AppColors.darkGreenGrey,
                ),
                inactiveTrackColor: getColorAccountType(
                  accountType: accountType,
                  businessColor: AppColors.disabledColor,
                  personalColor: AppColors.bayLeaf,
                ),
                trackShape: CustomTrackShape(),
              ),
              child: Slider(
                // value: provider.currentSliderValue,
                value: 140,
                max: 200,
                onChanged: provider.onChangeSlider,
              ),
            ),
          ),
        ),
        const SizedBox(height: 13.0),
        Container(
          height: 28.0,
          margin: const EdgeInsets.symmetric(horizontal: 20.0),
          decoration: BoxDecoration(
            color: getColorAccountType(
              accountType: accountType,
              businessColor: AppColors.primaryColor,
              personalColor: AppColors.darkGreenGrey,
            ),
            borderRadius: BorderRadius.circular(100.0),
          ),
          child: Center(
            child: RichText(
              text: TextSpan(
                text: '60 points left '.toUpperCase(),
                style: GoogleFonts.publicSans(
                  fontSize: 10.0,
                  fontWeight: FontWeight.bold,
                  color: AppColors.white,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: 'to your next reward'.toUpperCase(),
                    style: GoogleFonts.publicSans(
                      fontSize: 10.0,
                      color: AppColors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(height: 22.h),
      ],
    );
  }
}
