import 'dart:ui';

import 'package:amtech_design/core/utils/app_colors.dart';
import 'package:amtech_design/core/utils/strings.dart';
import 'package:amtech_design/custom_widgets/custom_appbar.dart';
import 'package:amtech_design/custom_widgets/svg_icon.dart';
import 'package:amtech_design/modules/menu/menu_provider.dart';
import 'package:amtech_design/modules/menu/widgets/banner_view.dart';
import 'package:amtech_design/modules/menu/widgets/divider_label.dart';
import 'package:amtech_design/modules/menu/widgets/product_widget.dart';
import 'package:amtech_design/modules/product_page/product_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../core/utils/constant.dart';
import '../../routes.dart';
import 'widgets/custom_slider_track_shape.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.seaShell.withOpacity(0.4),
      // extendBodyBehindAppBar: true, // Ensures content goes behind the AppBar
      appBar: CustomAppBar(
        backgroundColor: AppColors.seaShell.withOpacity(0.4),
        title: 'Good Afternoon,',
        subTitle: 'AMTech Design',
        leading: Container(
          height: 48.h,
          width: 48.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: AppColors.primaryColor,
              width: 2.w,
            ), // Border color and width
          ),
          child: ClipOval(
            child: Image.asset(
              ImageStrings.logo,
              height: 48.h,
              width: 48.w,
            ),
          ),
        ),
        actions: [
          Container(
            height: 45.h,
            width: 45.w,
            margin: const EdgeInsets.only(right: 15.0),
            decoration: const BoxDecoration(
              color: AppColors.primaryColor,
              shape: BoxShape.circle,
            ),
            child: Stack(
              children: [
                const Positioned.fill(
                  child: Icon(
                    Icons.notifications_outlined,
                    color: AppColors.white,
                  ),
                ),
                Positioned.fill(
                  top: 2,
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      height: 12.h,
                      width: 12.w,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.red,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: AppColors.primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.r),
        ),
        onPressed: () {},
        icon: SvgIcon(icon: IconStrings.cup),
        label: Text(
          'MENU',
          style: GoogleFonts.publicSans(
            color: AppColors.white,
            fontSize: 12.sp,
          ),
        ),
      ),
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 20.h),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SvgIcon(
                          icon: IconStrings.address,
                          color: AppColors.primaryColor,
                        ),
                        SizedBox(width: 3.w),
                        SizedBox(
                          width: 280.w,
                          child: RichText(
                            maxLines: 1,
                            overflow: TextOverflow.clip,
                            text: TextSpan(
                              text: 'Deliver to, ',
                              style: GoogleFonts.publicSans(
                                fontSize: 12.sp,
                                color: AppColors.primaryColor.withOpacity(0.8),
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                  text: 'AMTECH DESIGN, TITANIUM CIT',
                                  style: GoogleFonts.publicSans(
                                    fontSize: 10.sp,
                                    fontWeight: FontWeight.bold,
                                    color:
                                        AppColors.primaryColor.withOpacity(0.8),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          height: 24.h,
                          width: 65.w,
                          decoration: BoxDecoration(
                            color: AppColors.primaryColor,
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          child: Center(
                            child: Text(
                              'CHANGE',
                              style: GoogleFonts.publicSans(
                                fontSize: 10.sp,
                                fontWeight: FontWeight.bold,
                                color: AppColors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 15.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RichText(
                          text: TextSpan(
                            text: '140 / 200 ',
                            style: GoogleFonts.publicSans(
                              color: AppColors.primaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 15.sp,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text: 'POINTS',
                                style: GoogleFonts.publicSans(
                                  color: AppColors.primaryColor,
                                  fontSize: 10.sp,
                                ),
                              )
                            ],
                          ),
                        ),
                        SvgIcon(
                          icon: IconStrings.reward,
                          color: AppColors.black,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 13.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.h),
                    child: Consumer<MenuProvider>(
                      builder:
                          (BuildContext context, provider, Widget? child) =>
                              SliderTheme(
                        data: SliderTheme.of(context).copyWith(
                          thumbShape: SliderComponentShape.noThumb,
                          overlayShape: SliderComponentShape
                              .noOverlay, // Remove thumb shadow overlay
                          activeTrackColor: AppColors.primaryColor,
                          inactiveTrackColor: AppColors.disabledColor,
                          // rangeTrackShape: RoundedRectRangeSliderTrackShape(),
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
                      color: AppColors.primaryColor,
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
                  const SizedBox(height: 22.0),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20.0),
                    decoration: BoxDecoration(
                      // color: Colors.white, // Background color of the TextFormField
                      borderRadius: BorderRadius.circular(100.0),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          offset: Offset(0, 4),
                          blurRadius: 6,
                        ),
                      ],
                    ),
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Search for Tea, Coffee or Snacks',
                        hintStyle: GoogleFonts.publicSans(
                          color: AppColors.disabledColor,
                          fontSize: 14.0,
                        ),
                        // border: InputBorder.none, // Removes the border
                        border: textFieldBorderStyle,
                        enabledBorder: textFieldBorderStyle,
                        focusedBorder: textFieldBorderStyle,
                        filled: true, // To add a background color
                        fillColor: AppColors.primaryColor.withOpacity(0.7),
                        prefixIcon: SvgIcon(icon: IconStrings.search),
                      ),
                    ),
                  ),
                  const SizedBox(height: 21.0),

                  // BannerView
                  const BannerView(),
                  const SizedBox(height: 10.0),

                  // Best Seller Divider
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: DividerLabel(
                      label: 'BEST SELLER',
                    ),
                  ),
                  const SizedBox(height: 15.0),

                  // Best seller horizontal view
                  SizedBox(
                    height: 157,
                    child: ListView.separated(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      shrinkWrap: true,
                      itemCount: 4,
                      scrollDirection: Axis.horizontal,
                      separatorBuilder: (context, index) =>
                          const SizedBox(width: 10),
                      itemBuilder: (context, index) {
                        return Consumer<MenuProvider>(
                          builder: (context, provider, child) =>
                              GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, Routes.productPage);
                            },
                            child: ProductWidget(
                              image: provider.productImage[index],
                              name: provider.productName[index],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 18),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: DividerLabel(
                      label: 'TEA',
                    ),
                  ),
                  const SizedBox(height: 15),
                  // TEA seller horizontal view
                  SizedBox(
                    height: 157,
                    child: ListView.separated(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      shrinkWrap: true,
                      itemCount: 4,
                      scrollDirection: Axis.horizontal,
                      separatorBuilder: (context, index) =>
                          const SizedBox(width: 10),
                      itemBuilder: (context, index) {
                        return Consumer<MenuProvider>(
                          builder: (context, provider, child) =>
                              GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                ProductPage.route(),
                              );
                            },
                            child: ProductWidget(
                              image: provider.productImage[index],
                              name: provider.productName[index],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),

                  Stack(
                    children: [
                      ClipRect(
                        child: Image.asset(
                          ImageStrings.bottomWatermark,
                          fit: BoxFit.cover,
                          // color: Colors.transparent,
                        ),
                      ),
                      // Top edge gradient
                      Positioned(
                        left: 0,
                        right: 0,
                        top: -15, // Changed from `bottom: 0` to `top: 0`
                        height: 150, // Adjust the height of the blur effect
                        child: IgnorePointer(
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment
                                    .topCenter, // Changed from `Alignment.bottomCenter`
                                end: Alignment
                                    .bottomCenter, // Changed from `Alignment.topCenter`
                                colors: [
                                  Colors.white, // Your background color
                                  Colors.white
                                      .withOpacity(0.0), // Fades to transparent
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),

                      // Left edge gradient
                      Positioned(
                        top: 0,
                        bottom: 0,
                        left: 0,
                        width: 50, // Adjust the width of the blur effect
                        child: IgnorePointer(
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: [
                                  Colors.white, // Your background color
                                  Colors.white.withOpacity(0.0),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      // Right edge gradient
                      Positioned(
                        top: 0,
                        bottom: 0,
                        right: 0,
                        width: 50, // Adjust the width of the blur effect
                        child: IgnorePointer(
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.centerRight,
                                end: Alignment.centerLeft,
                                colors: [
                                  Colors.white,
                                  Colors.white.withOpacity(0.0),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      // Bottom edge gradient
                      Positioned(
                        left: 0,
                        right: 0,
                        bottom: 0,
                        height: 150, // Adjust the height of the blur effect
                        child: IgnorePointer(
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                colors: [
                                  Colors.white, // Your background color
                                  Colors.white.withOpacity(0.0),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          // Added for blur effect on page (left, right, bottom)
          // Left edge gradient
          Positioned(
            top: 0,
            bottom: 0,
            left: 0,
            width: 20, // Adjust the width of the blur effect
            child: IgnorePointer(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      Colors.white, // Your background color
                      Colors.white.withOpacity(0.0),
                    ],
                  ),
                ),
              ),
            ),
          ),
          // Right edge gradient
          Positioned(
            top: 0,
            bottom: 0,
            right: 0,
            width: 20, // Adjust the width of the blur effect
            child: IgnorePointer(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.centerRight,
                    end: Alignment.centerLeft,
                    colors: [
                      Colors.white,
                      Colors.white.withOpacity(0.0),
                    ],
                  ),
                ),
              ),
            ),
          ),
          // Bottom edge gradient
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            height: 20, // Adjust the height of the blur effect
            child: IgnorePointer(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Colors.white, // Your background color
                      Colors.white.withOpacity(0.0),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
