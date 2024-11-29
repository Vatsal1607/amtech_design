import 'package:amtech_design/core/utils/app_colors.dart';
import 'package:amtech_design/core/utils/strings.dart';
import 'package:amtech_design/custom_widgets/svg_icon.dart';
import 'package:amtech_design/modules/menu/menu_provider.dart';
import 'package:amtech_design/modules/menu/widgets/banner_view.dart';
import 'package:amtech_design/modules/menu/widgets/divider_label.dart';
import 'package:amtech_design/modules/menu/widgets/pinned_header.dart';
import 'package:amtech_design/modules/menu/widgets/product_widget.dart';
import 'package:amtech_design/modules/product_page/product_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gradient_slider/gradient_slider.dart';
import 'package:provider/provider.dart';
import '../../core/utils/constant.dart';
import '../../core/utils/constants/keys.dart';
import '../../routes.dart';
import '../../services/local/shared_preferences_service.dart';
import 'widgets/custom_slider_track_shape.dart';
import 'widgets/slider_details_widget.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    String accountType =
        sharedPreferencesService.getString(SharedPreferencesKeys.accountType) ??
            '';
    debugPrint('$accountType is from menu page (build)');

    return Scaffold(
      backgroundColor: getColorAccountType(
        accountType: accountType,
        businessColor: AppColors.seaShell,
        personalColor: AppColors.seaMist,
      ),

      // appBar: CustomAppBar(
      //   backgroundColor: AppColors.seaShell.withOpacity(0.4),
      //   title: 'Good Afternoon,',
      //   subTitle: 'AMTech Design',
      //   leading: Container(
      //     height: 48.h,
      //     width: 48.w,
      //     decoration: BoxDecoration(
      //       shape: BoxShape.circle,
      //       border: Border.all(
      //         color: AppColors.primaryColor,
      //         width: 2.w,
      //       ), // Border color and width
      //     ),
      //     child: ClipOval(
      //       child: Image.asset(
      //         ImageStrings.logo,
      //         height: 48.h,
      //         width: 48.w,
      //       ),
      //     ),
      //   ),
      //   actions: [
      //     Container(
      //       height: 45.h,
      //       width: 45.w,
      //       margin: const EdgeInsets.only(right: 15.0),
      //       decoration: const BoxDecoration(
      //         color: AppColors.primaryColor,
      //         shape: BoxShape.circle,
      //       ),
      //       child: Stack(
      //         children: [
      //           const Positioned.fill(
      //             child: Icon(
      //               Icons.notifications_outlined,
      //               color: AppColors.white,
      //             ),
      //           ),
      //           Positioned.fill(
      //             top: 2,
      //             child: Align(
      //               alignment: Alignment.topRight,
      //               child: Container(
      //                 height: 12.h,
      //                 width: 12.w,
      //                 decoration: const BoxDecoration(
      //                   shape: BoxShape.circle,
      //                   color: AppColors.red,
      //                 ),
      //               ),
      //             ),
      //           ),
      //         ],
      //       ),
      //     ),
      //   ],
      // ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: getColorAccountType(
          accountType: accountType,
          businessColor: AppColors.primaryColor,
          personalColor: AppColors.darkGreenGrey,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.r),
        ),
        onPressed: () {
          debugPrint('Menu pressed');
        },
        icon: SvgIcon(icon: IconStrings.cup),
        label: Text(
          'MENU',
          style: GoogleFonts.publicSans(
            color: AppColors.white,
            fontSize: 12.sp,
          ),
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: getColorAccountType(
              accountType: accountType,
              businessColor: AppColors.seaShell,
              personalColor: AppColors.seaMist,
            ),
            centerTitle: true,

            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              // mainAxisSize: MainAxisSize.max,
              children: [
                /// leading icon
                Container(
                  height: 48.h,
                  width: 48.w,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColors.primaryColor,
                      width: 2.0,
                    ),
                  ),
                  child: ClipOval(
                    child: Image.asset(
                      ImageStrings.logo,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                /// center title content
                Column(
                  children: [
                    Text(
                      'Good Afternoon,',
                      style: GoogleFonts.publicSans(
                        color: getColorAccountType(
                          accountType: accountType,
                          businessColor: AppColors.primaryColor,
                          personalColor: AppColors.darkGreenGrey,
                        ),
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      'AMTech Design',
                      style: GoogleFonts.publicSans(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: getColorAccountType(
                          accountType: accountType,
                          businessColor: AppColors.primaryColor,
                          personalColor: AppColors.darkGreenGrey,
                        ),
                      ),
                    ),
                  ],
                ),

                /// trailing(action) icon
                Container(
                  height: 48.h,
                  width: 48.w,
                  decoration: BoxDecoration(
                    color: getColorAccountType(
                      accountType: accountType,
                      businessColor: AppColors.primaryColor,
                      personalColor: AppColors.darkGreenGrey,
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: Stack(
                    children: [
                      const Positioned.fill(
                        // child: SvgIcon(
                        //   icon: IconStrings.notification,
                        //   color: AppColors.white,
                        // ),
                        // Todo: Replace with svg icon (above commented) // ReLaunch
                        child: Icon(
                          Icons.notifications_outlined,
                          color: AppColors.white,
                        ),
                      ),
                      Positioned(
                        top: 2,
                        right: 2,
                        child: Container(
                          height: 12,
                          width: 12,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.red,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            automaticallyImplyLeading: false,
            // leading: Container(
            //   height: 48.h,
            //   width: 48.w,
            //   margin: const EdgeInsets.all(8),
            //   decoration: BoxDecoration(
            //     color: Colors.black,
            //     shape: BoxShape.circle,
            //     border: Border.all(
            //       color: AppColors.primaryColor,
            //       width: 2.0,
            //     ),
            //   ),
            //   child: ClipOval(
            //     child: Image.asset(
            //       ImageStrings.logo,
            //       fit: BoxFit.cover,
            //     ),
            //   ),
            // ),
            // actions: [
            //   Container(
            //     height: 48.h,
            //     width: 48.w,
            //     margin: const EdgeInsets.only(right: 20.0),
            //     decoration: BoxDecoration(
            //       color: getColorAccountType(
            //         accountType: accountType,
            //         businessColor: AppColors.primaryColor,
            //         personalColor: AppColors.darkGreenGrey,
            //       ),
            //       shape: BoxShape.circle,
            //     ),
            //     child: Stack(
            //       children: [
            //         const Positioned.fill(
            //           // child: SvgIcon(
            //           //   icon: IconStrings.notification,
            //           //   color: AppColors.white,
            //           // ),
            //           // Todo: Replace with svg icon (above commented) // ReLaunch
            //           child: Icon(
            //             Icons.notifications_outlined,
            //             color: AppColors.white,
            //           ),
            //         ),
            //         Positioned(
            //           top: 2,
            //           right: 2,
            //           child: Container(
            //             height: 12,
            //             width: 12,
            //             decoration: const BoxDecoration(
            //               shape: BoxShape.circle,
            //               color: AppColors.red,
            //             ),
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
            // ],
          ),

          // Initial data in Sliver
          SliverToBoxAdapter(
            child: Column(
              children: [
                SizedBox(height: 10.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          overflow: TextOverflow.fade,
                          text: TextSpan(
                            text: 'Deliver to, ',
                            style: GoogleFonts.publicSans(
                              fontSize: 12.sp,
                              color: getColorAccountType(
                                accountType: accountType,
                                businessColor:
                                    AppColors.primaryColor.withOpacity(0.8),
                                personalColor:
                                    AppColors.darkGreenGrey.withOpacity(0.8),
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
                                    personalColor: AppColors.darkGreenGrey
                                        .withOpacity(0.8),
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
                                    personalColor: AppColors.darkGreenGrey
                                        .withOpacity(0.8),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      ///* Address change button old
                      // Container(
                      //   height: 24.h,
                      //   width: 65.w,
                      //   decoration: BoxDecoration(
                      //     color: getColorAccountType(
                      //       accountType: accountType,
                      //       businessColor: AppColors.primaryColor,
                      //       personalColor: AppColors.darkGreenGrey,
                      //     ),
                      //     // color: AppColors.primaryColor,
                      //     borderRadius: BorderRadius.circular(10.r),
                      //   ),
                      //   child: Center(
                      //     child: Text(
                      //       'CHANGE',
                      //       style: GoogleFonts.publicSans(
                      //         fontSize: 10.sp,
                      //         fontWeight: FontWeight.bold,
                      //         color: getColorAccountType(
                      //           accountType: accountType,
                      //           businessColor: AppColors.seaShell,
                      //           personalColor: AppColors.seaMist,
                      //         ),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ),
                SizedBox(height: 15.h),

                //* Slider details widget
                SliderDetailsWidget(
                  accountType: accountType,
                  filledValue: '₹ 135',
                  totalValue: '₹ 2,000',
                  label: 'credits used',
                  icon: IconStrings.rupee,
                ),
                SizedBox(height: 13.h),

                // Credit Slider widget
                Consumer<MenuProvider>(
                  builder: (BuildContext context, provider, Widget? child) =>
                      GradientSlider(
                    // thumbAsset: ImageStrings.transparent,
                    thumbAsset: '',
                    thumbHeight: 0,
                    thumbWidth: 0,
                    trackHeight: 3,
                    trackBorderColor: Colors.transparent,
                    activeTrackGradient: const LinearGradient(
                      colors: [
                        AppColors.lightGreen,
                        AppColors.lightGreen,
                      ],
                    ),
                    inactiveTrackGradient: LinearGradient(
                      colors: [
                        AppColors.lightGreen.withOpacity(0.5),
                        AppColors.red.withOpacity(0.5),
                      ],
                    ),
                    inactiveTrackColor: Colors.transparent,
                    slider: Slider(
                      value: provider.sliderCreditValue,
                      min: 1,
                      max: 2000,
                      onChanged: provider.onChangeCreditSlider,
                    ),
                  ),
                ),

                // SizedBox(height: 18.h),

                //* Slider details widget
                SliderDetailsWidget(
                  accountType: accountType,
                  filledValue: '140',
                  totalValue: '200',
                  label: 'reward points',
                  icon: IconStrings.reward,
                ),
                SizedBox(height: 13.h),

                /// Slider widget REWARD points
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
            ),
          ),

          // Pinned or Sticky Search field in Sliver
          SliverPersistentHeader(
            pinned: true,
            delegate: PinnedHeaderDelegate(
              minExtent: 50.0, // Height when pinned
              maxExtent: 50.0, // Height when scrolling
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 20.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100.r),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      offset: Offset(0, 4),
                      blurRadius: 6,
                    ),
                  ],
                ),
                child: TextFormField(
                  style: GoogleFonts.publicSans(
                    color: getColorAccountType(
                      accountType: accountType,
                      businessColor: AppColors.disabledColor,
                      personalColor: AppColors.white,
                    ),
                    fontSize: 14.0,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Search for Tea, Coffee or Snacks',
                    hintStyle: GoogleFonts.publicSans(
                      color: getColorAccountType(
                        accountType: accountType,
                        businessColor: AppColors.disabledColor,
                        personalColor: AppColors.white,
                      ),
                      fontSize: 14.0,
                    ),

                    border: textFieldBorderStyle,
                    enabledBorder: textFieldBorderStyle,
                    focusedBorder: textFieldBorderStyle,
                    filled: true, // To add a background color
                    fillColor: getColorAccountType(
                      accountType: accountType,
                      businessColor: AppColors.primaryColor.withOpacity(0.8),
                      personalColor: AppColors.darkGreenGrey.withOpacity(0.8),
                    ),
                    prefixIcon: SvgIcon(icon: IconStrings.search),
                  ),
                ),
              ),
            ),
          ),

          // Rest of the data in Sliver
          SliverToBoxAdapter(
            child: Stack(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 20.h),
                  child: Column(
                    children: [
                      //* BannerView
                      BannerView(
                        accountType: accountType,
                      ),
                      const SizedBox(height: 10.0),

                      // Best Seller Divider
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: DividerLabel(
                          label: 'BEST SELLER',
                          accountType: accountType,
                        ),
                      ),
                      const SizedBox(height: 15.0),

                      // Best seller horizontal view
                      SizedBox(
                        height: 157.h,
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
                                  debugPrint('Product item pressed $index');

                                  /// TODO: Uncomment navigation
                                  Navigator.pushNamed(
                                      context, Routes.productPage);
                                },
                                child: ProductWidget(
                                  image: provider.productImage[index],
                                  name: provider.productName[index],
                                  index: index,
                                  accountType: accountType,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(height: 18.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: DividerLabel(
                          label: 'TEA',
                          accountType: accountType,
                        ),
                      ),
                      const SizedBox(height: 15),
                      // TEA seller horizontal view
                      SizedBox(
                        height: 157.h,
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
                                  index: index,
                                  accountType: accountType,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 20.0),

                      Stack(
                        children: [
                          ClipRect(
                            child: Image.asset(
                              ImageStrings.bottomWatermark,
                              fit: BoxFit.cover,
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
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      getColorAccountType(
                                        accountType: accountType,
                                        businessColor: AppColors.seaShell,
                                        personalColor: AppColors.seaMist,
                                      ), // Your background color
                                      getColorAccountType(
                                        accountType: accountType,
                                        businessColor:
                                            AppColors.seaShell.withOpacity(0),
                                        personalColor:
                                            AppColors.seaMist.withOpacity(0),
                                      ), // Fades to transparent
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
                                      getColorAccountType(
                                        accountType: accountType,
                                        businessColor: AppColors.seaShell,
                                        personalColor: AppColors.seaMist,
                                      ), // Your background color
                                      getColorAccountType(
                                        accountType: accountType,
                                        businessColor:
                                            AppColors.seaShell.withOpacity(0),
                                        personalColor:
                                            AppColors.seaMist.withOpacity(0),
                                      ), // Fades to transparent
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
                                      getColorAccountType(
                                        accountType: accountType,
                                        businessColor: AppColors.seaShell,
                                        personalColor: AppColors.seaMist,
                                      ), // Your background color
                                      getColorAccountType(
                                        accountType: accountType,
                                        businessColor:
                                            AppColors.seaShell.withOpacity(0),
                                        personalColor:
                                            AppColors.seaMist.withOpacity(0),
                                      ), // Fades to transparent
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
                                      getColorAccountType(
                                        accountType: accountType,
                                        businessColor: AppColors.seaShell,
                                        personalColor: AppColors.seaMist,
                                      ), // Your background color
                                      getColorAccountType(
                                        accountType: accountType,
                                        businessColor:
                                            AppColors.seaShell.withOpacity(0),
                                        personalColor:
                                            AppColors.seaMist.withOpacity(0),
                                      ), // Fades to transparent
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

                //* Added for blur effect on page (left, right, bottom)
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
                            // AppColors.seaShell, // Your background color
                            // AppColors.seaShell.withOpacity(0.0),
                            getColorAccountType(
                              accountType: accountType,
                              businessColor: AppColors.seaShell,
                              personalColor: AppColors.seaMist,
                            ), // Your background color
                            getColorAccountType(
                              accountType: accountType,
                              businessColor: AppColors.seaShell.withOpacity(0),
                              personalColor: AppColors.seaMist.withOpacity(0),
                            ), // Fades to transparent
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
                            getColorAccountType(
                              accountType: accountType,
                              businessColor: AppColors.seaShell,
                              personalColor: AppColors.seaMist,
                            ), // Your background color
                            getColorAccountType(
                              accountType: accountType,
                              businessColor: AppColors.seaShell.withOpacity(0),
                              personalColor: AppColors.seaMist.withOpacity(0),
                            ), // Fades to transparent
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
                            getColorAccountType(
                              accountType: accountType,
                              businessColor: AppColors.seaShell,
                              personalColor: AppColors.seaMist,
                            ), // Your background color
                            getColorAccountType(
                              accountType: accountType,
                              businessColor: AppColors.seaShell.withOpacity(0),
                              personalColor: AppColors.seaMist.withOpacity(0),
                            ), // Fades to transparent
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
