import 'package:amtech_design/core/utils/app_colors.dart';
import 'package:amtech_design/core/utils/strings.dart';
import 'package:amtech_design/custom_widgets/svg_icon.dart';
import 'package:amtech_design/modules/menu/menu_provider.dart';
import 'package:amtech_design/modules/menu/widgets/banner_view.dart';
import 'package:amtech_design/modules/menu/widgets/divider_label.dart';
import 'package:amtech_design/modules/menu/widgets/pinned_header.dart';
import 'package:amtech_design/modules/menu/widgets/product_widget.dart';
import 'package:amtech_design/modules/product_page/product_details_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../core/utils/constant.dart';
import '../../custom_widgets/appbar/custom_sliver_appbar.dart';
import '../../routes.dart';
import 'widgets/slider_details_widget.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    String accountType = 'business'; // Todo imp set dynamic
    // sharedPrefsService.getString(SharedPrefsKeys.accountType) ?? '';
    final provider = Provider.of<MenuProvider>(context);

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

      floatingActionButton: Consumer<MenuProvider>(
        builder: (context, _, child) => PopupMenuButton(
          offset: provider.menuItemsName.length == 1
              ? Offset(-10, -70)
              : Offset(-10, -180),
          onSelected: provider.onSelectedMenuItem,
          onCanceled: provider.onCanceledMenuItem,
          onOpened: provider.onOpenedMenuItem,
          icon: Container(
            height: 50.h,
            width: 100.w,
            decoration: BoxDecoration(
              color: provider.isMenuOpen
                  ? AppColors.red
                  : getColorAccountType(
                      accountType: accountType,
                      businessColor: AppColors.primaryColor,
                      personalColor: AppColors.darkGreenGrey,
                    ),
              borderRadius: BorderRadius.circular(30.r),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgIcon(
                  icon:
                      provider.isMenuOpen ? IconStrings.close : IconStrings.cup,
                ),
                SizedBox(width: 8.w),
                Text(
                  provider.isMenuOpen ? 'CLOSE' : 'MENU',
                  style: GoogleFonts.publicSans(
                    color: AppColors.white,
                    fontSize: 12.sp,
                  ),
                ),
              ],
            ),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.r),
          ),
          color: AppColors.primaryColor,
          itemBuilder: (context) {
            return provider.menuItemsName.map<PopupMenuEntry<String>>(
              (item) {
                return PopupMenuItem(
                  value: item,
                  child: Container(
                    width: double.infinity,
                    padding:
                        EdgeInsets.symmetric(vertical: 15.h, horizontal: 23.w),
                    decoration: BoxDecoration(
                      color: provider.selectedValue == item
                          ? AppColors.disabledColor
                          : null,
                      borderRadius: BorderRadius.circular(30.r),
                    ),
                    child: Text(
                      item.toUpperCase(),
                      textAlign: TextAlign.center,
                      style: provider.selectedValue == item
                          ? GoogleFonts.publicSans(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primaryColor,
                            )
                          : GoogleFonts.publicSans(
                              fontSize: 15.sp,
                              color: AppColors.seaShell,
                            ),
                    ),
                  ),
                );
              },
            ).toList();
          },
        ),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: NotificationListener(
              onNotification: provider.onNotification,
              child: CustomScrollView(
                slivers: [
                  CustomSliverAppbar(
                    accountType: accountType,
                  ),

                  // Initial data in Sliver
                  SliverToBoxAdapter(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
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
                                        businessColor: AppColors.primaryColor
                                            .withOpacity(0.8),
                                        personalColor: AppColors.darkGreenGrey
                                            .withOpacity(0.8),
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
                                            businessColor: AppColors
                                                .primaryColor
                                                .withOpacity(0.8),
                                            personalColor: AppColors
                                                .darkGreenGrey
                                                .withOpacity(0.8),
                                          ),
                                        ),
                                      ),
                                      TextSpan(
                                        text: ' AMTECH DESIGN, TITANIUM CIT',
                                        style: GoogleFonts.publicSans(
                                          fontSize: 10.sp,
                                          fontWeight: FontWeight.bold,
                                          color: getColorAccountType(
                                            accountType: accountType,
                                            businessColor: AppColors
                                                .primaryColor
                                                .withOpacity(0.8),
                                            personalColor: AppColors
                                                .darkGreenGrey
                                                .withOpacity(0.8),
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
                        SliderDetailsWidget(
                          isShowRecharge: true,
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
                                  AppColors.lightGreen.withOpacity(.2),
                                  AppColors.red.withOpacity(.2),
                                ], // Gradient for background
                              ),
                              borderRadius:
                                  BorderRadius.circular(5.0), // Rounded corners
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
                                      borderRadius: BorderRadius.circular(
                                          5.0), // Rounded corners
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
                        // SizedBox(height: 10.h),

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

                        //* Slider details widget
                        // SliderDetailsWidget(
                        //   accountType: accountType,
                        //   filledValue: '140',
                        //   totalValue: '200',
                        //   label: 'reward points',
                        //   icon: IconStrings.reward,
                        // ),
                        // Slider widget REWARD points
                        // Padding(
                        //   padding: EdgeInsets.symmetric(horizontal: 20.h),
                        //   child: Consumer<MenuProvider>(
                        //     builder: (BuildContext context, provider,
                        //             Widget? child) =>
                        //         SliderTheme(
                        //       data: SliderTheme.of(context).copyWith(
                        //         thumbShape: SliderComponentShape.noThumb,
                        //         overlayShape: SliderComponentShape
                        //             .noOverlay, // Remove thumb shadow overlay
                        //         activeTrackColor: getColorAccountType(
                        //           accountType: accountType,
                        //           businessColor: AppColors.primaryColor,
                        //           personalColor: AppColors.darkGreenGrey,
                        //         ),
                        //         inactiveTrackColor: getColorAccountType(
                        //           accountType: accountType,
                        //           businessColor: AppColors.disabledColor,
                        //           personalColor: AppColors.bayLeaf,
                        //         ),
                        //         trackShape: CustomTrackShape(),
                        //       ),
                        //       child: Slider(
                        //         // value: provider.currentSliderValue,
                        //         value: 140,
                        //         max: 200,
                        //         onChanged: provider.onChangeSlider,
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        // const SizedBox(height: 13.0),
                        // Container(
                        //   height: 28.0,
                        //   margin: const EdgeInsets.symmetric(horizontal: 20.0),
                        //   decoration: BoxDecoration(
                        //     color: getColorAccountType(
                        //       accountType: accountType,
                        //       businessColor: AppColors.primaryColor,
                        //       personalColor: AppColors.darkGreenGrey,
                        //     ),
                        //     borderRadius: BorderRadius.circular(100.0),
                        //   ),
                        //   child: Center(
                        //     child: RichText(
                        //       text: TextSpan(
                        //         text: '60 points left '.toUpperCase(),
                        //         style: GoogleFonts.publicSans(
                        //           fontSize: 10.0,
                        //           fontWeight: FontWeight.bold,
                        //           color: AppColors.white,
                        //         ),
                        //         children: <TextSpan>[
                        //           TextSpan(
                        //             text: 'to your next reward'.toUpperCase(),
                        //             style: GoogleFonts.publicSans(
                        //               fontSize: 10.0,
                        //               color: AppColors.white,
                        //             ),
                        //           ),
                        //         ],
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        // SizedBox(height: 22.h),
                      ],
                    ),
                  ),

                  // Space above pinned content:
                  provider.isVisibleSearchSpaceTop == true
                      ? SliverPersistentHeader(
                          pinned: true,
                          delegate: PinnedHeaderDelegate(
                            child: SizedBox(height: 80.h),
                            minExtent: 80.h,
                            maxExtent: 80.h,
                          ),
                        )
                      : SliverPersistentHeader(
                          pinned: true,
                          delegate: PinnedHeaderDelegate(
                            minExtent: 30.h,
                            maxExtent: 30.h,
                            child: SizedBox(height: 30.h),
                          ),
                        ),
                  // Pinned or Sticky Search field in Sliver
                  SliverPersistentHeader(
                    pinned: true,
                    delegate: PinnedHeaderDelegate(
                      // Hint: Change min/max height incase of sliver size issue
                      minExtent: 51.h, // Height when pinned
                      maxExtent: 51.h, // Height when scrolling
                      child: Container(
                        margin: EdgeInsets.only(
                          left: 20.h,
                          right: 20.h,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100.r),
                          boxShadow: kDropShadow,
                        ),
                        child: TextFormField(
                          textAlignVertical: TextAlignVertical.bottom,
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
                              businessColor:
                                  AppColors.primaryColor.withOpacity(0.8),
                              personalColor:
                                  AppColors.darkGreenGrey.withOpacity(0.8),
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
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
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
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0),
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
                                          debugPrint(
                                              'Product item pressed $index');
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
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0),
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
                                            ProductDetailsPage.route(),
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
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20.w),
                                child: DividerLabel(
                                  label: 'Coffee',
                                  accountType: accountType,
                                ),
                              ),
                              const SizedBox(height: 15),
                              // TEA seller horizontal view
                              SizedBox(
                                height: 157.h,
                                child: ListView.separated(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0),
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
                                            ProductDetailsPage.route(),
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
                                  Container(
                                    height: 210.h,
                                    width: double.infinity,
                                    margin: EdgeInsets.symmetric(
                                      horizontal: 10.w,
                                    ),
                                    decoration: BoxDecoration(
                                      color: AppColors.lightGreen.withOpacity(
                                        .4,
                                      ),
                                      borderRadius: BorderRadius.circular(30.r),
                                    ),
                                  ),
                                  Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 20.w, vertical: 10.h),
                                        child: DividerLabel(
                                          label: 'Health first',
                                          accountType: accountType,
                                        ),
                                      ),
                                      // const SizedBox(height: 8),
                                      // Health first horizontal view
                                      SizedBox(
                                        height: 157.h,
                                        child: ListView.separated(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20.0),
                                          shrinkWrap: true,
                                          itemCount: 4,
                                          scrollDirection: Axis.horizontal,
                                          separatorBuilder: (context, index) =>
                                              const SizedBox(width: 10),
                                          itemBuilder: (context, index) {
                                            return Consumer<MenuProvider>(
                                              builder:
                                                  (context, provider, child) =>
                                                      GestureDetector(
                                                onTap: () {
                                                  Navigator.push(
                                                    context,
                                                    ProductDetailsPage.route(),
                                                  );
                                                },
                                                child: ProductWidget(
                                                  image: provider
                                                      .productImage[index],
                                                  name: provider
                                                      .productName[index],
                                                  index: index,
                                                  accountType: accountType,
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),

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
                                    top:
                                        -15, // Changed from `bottom: 0` to `top: 0`
                                    height:
                                        150, // Adjust the height of the blur effect
                                    child: IgnorePointer(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                            colors: [
                                              getColorAccountType(
                                                accountType: accountType,
                                                businessColor:
                                                    AppColors.seaShell,
                                                personalColor:
                                                    AppColors.seaMist,
                                              ), // Your background color
                                              getColorAccountType(
                                                accountType: accountType,
                                                businessColor: AppColors
                                                    .seaShell
                                                    .withOpacity(0),
                                                personalColor: AppColors.seaMist
                                                    .withOpacity(0),
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
                                    width:
                                        50, // Adjust the width of the blur effect
                                    child: IgnorePointer(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            begin: Alignment.centerLeft,
                                            end: Alignment.centerRight,
                                            colors: [
                                              getColorAccountType(
                                                accountType: accountType,
                                                businessColor:
                                                    AppColors.seaShell,
                                                personalColor:
                                                    AppColors.seaMist,
                                              ), // Your background color
                                              getColorAccountType(
                                                accountType: accountType,
                                                businessColor: AppColors
                                                    .seaShell
                                                    .withOpacity(0),
                                                personalColor: AppColors.seaMist
                                                    .withOpacity(0),
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
                                    width:
                                        50, // Adjust the width of the blur effect
                                    child: IgnorePointer(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            begin: Alignment.centerRight,
                                            end: Alignment.centerLeft,
                                            colors: [
                                              getColorAccountType(
                                                accountType: accountType,
                                                businessColor:
                                                    AppColors.seaShell,
                                                personalColor:
                                                    AppColors.seaMist,
                                              ), // Your background color
                                              getColorAccountType(
                                                accountType: accountType,
                                                businessColor: AppColors
                                                    .seaShell
                                                    .withOpacity(0),
                                                personalColor: AppColors.seaMist
                                                    .withOpacity(0),
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
                                    height:
                                        150, // Adjust the height of the blur effect
                                    child: IgnorePointer(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            begin: Alignment.bottomCenter,
                                            end: Alignment.topCenter,
                                            colors: [
                                              getColorAccountType(
                                                accountType: accountType,
                                                businessColor:
                                                    AppColors.seaShell,
                                                personalColor:
                                                    AppColors.seaMist,
                                              ), // Your background color
                                              getColorAccountType(
                                                accountType: accountType,
                                                businessColor: AppColors
                                                    .seaShell
                                                    .withOpacity(0),
                                                personalColor: AppColors.seaMist
                                                    .withOpacity(0),
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
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
