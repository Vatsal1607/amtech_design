import 'package:amtech_design/core/utils/app_colors.dart';
import 'package:amtech_design/core/utils/strings.dart';
import 'package:amtech_design/custom_widgets/svg_icon.dart';
import 'package:amtech_design/modules/menu/menu_provider.dart';
import 'package:amtech_design/modules/menu/widgets/banner_view.dart';
import 'package:amtech_design/modules/menu/widgets/divider_label.dart';
import 'package:amtech_design/modules/menu/widgets/pinned_header.dart';
import 'package:amtech_design/modules/menu/widgets/product_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../core/utils/constant.dart';
import '../../custom_widgets/appbar/custom_sliver_appbar.dart';
import '../../routes.dart';
import 'widgets/fab_menu_button.dart';
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
      // * FAB
      floatingActionButton: FabMenuButton(
        provider: provider,
        accountType: accountType,
      ),
      body: Stack(
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: NotificationListener(
                  onNotification: provider.onNotification,
                  child: CustomScrollView(
                    physics: const ClampingScrollPhysics(),
                    slivers: [
                      CustomSliverAppbar(
                        accountType: accountType,
                      ),

                      // * Initial data in Sliver
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
                                      overflow: TextOverflow.ellipsis,
                                      text: TextSpan(
                                        text: 'Deliver to, ',
                                        style: GoogleFonts.publicSans(
                                          fontSize: 12.sp,
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
                                            text:
                                                ' AMTECH DESIGN, TITANIUM CIT',
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
                              label: 'perks used',
                              icon: IconStrings.rupee,
                            ),
                            SizedBox(height: 13.h),

                            // * Linear progress indicator:
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 22.0),
                              child: Container(
                                height:
                                    6.h, // Height of the credit progress bar
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      AppColors.lightGreen.withOpacity(.2),
                                      AppColors.red.withOpacity(.2),
                                    ], // Gradient for background
                                  ),
                                  borderRadius: BorderRadius.circular(
                                      5.0), // Rounded corners
                                ),
                                child: Stack(
                                  children: [
                                    FractionallySizedBox(
                                      widthFactor: 0.4, // * based on progress
                                      child: Container(
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            colors: [
                                              AppColors.lightGreen
                                                  .withOpacity(.5),
                                              AppColors.lightGreen
                                                  .withOpacity(.5),
                                            ], // Gradient for active
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(5.0),
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
                                prefixIcon:
                                    const SvgIcon(icon: IconStrings.search),
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

                                  // * Best Seller Divider
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20.0),
                                    child: DividerLabel(
                                      key: provider.bestSellerKey,
                                      label: 'BEST SELLER',
                                      accountType: accountType,
                                    ),
                                  ),
                                  const SizedBox(height: 15.0),

                                  // * Best seller horizontal view
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
                                                context,
                                                Routes.productDetails,
                                              );
                                            },
                                            child: ProductWidget(
                                              image:
                                                  provider.productImage[index],
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
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 20.w),
                                    child: DividerLabel(
                                      key: provider.teaKey,
                                      label: 'TEA',
                                      accountType: accountType,
                                    ),
                                  ),
                                  const SizedBox(height: 15),
                                  // * TEA horizontal view
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
                                              Navigator.pushNamed(
                                                context,
                                                Routes.productDetails,
                                              );
                                            },
                                            child: ProductWidget(
                                              image:
                                                  provider.productImage[index],
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
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 20.w),
                                    child: DividerLabel(
                                      key: provider.coffeeKey,
                                      label: 'Coffee',
                                      accountType: accountType,
                                    ),
                                  ),
                                  const SizedBox(height: 15),
                                  // * TEA horizontal view
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
                                              Navigator.pushNamed(
                                                context,
                                                Routes.productDetails,
                                              );
                                            },
                                            child: ProductWidget(
                                              image:
                                                  provider.productImage[index],
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
                                          horizontal: 20.w,
                                        ),
                                        decoration: BoxDecoration(
                                          color: AppColors.lightGreen
                                              .withOpacity(.3),
                                          borderRadius:
                                              BorderRadius.circular(30.r),
                                        ),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 20.w,
                                                  vertical: 10.h),
                                              child: DividerLabel(
                                                isHealthFirst: true,
                                                label: 'Health first',
                                                accountType: accountType,
                                              ),
                                            ),
                                            // * Health first horizontal view
                                            SizedBox(
                                              height: 157.h,
                                              child: ListView.separated(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 20.0),
                                                shrinkWrap: true,
                                                itemCount: 4,
                                                scrollDirection:
                                                    Axis.horizontal,
                                                separatorBuilder: (context,
                                                        index) =>
                                                    const SizedBox(width: 10),
                                                itemBuilder: (context, index) {
                                                  return Consumer<MenuProvider>(
                                                    builder: (context, provider,
                                                            child) =>
                                                        GestureDetector(
                                                      onTap: () {
                                                        Navigator.pushNamed(
                                                          context,
                                                          Routes.productDetails,
                                                        );
                                                      },
                                                      child: ProductWidget(
                                                        isHealthFirst: true,
                                                        image: provider
                                                                .productImage[
                                                            index],
                                                        name: provider
                                                            .productName[index],
                                                        index: index,
                                                        accountType:
                                                            accountType,
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
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
                                                    personalColor: AppColors
                                                        .seaMist
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
                                                    personalColor: AppColors
                                                        .seaMist
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
                                                    personalColor: AppColors
                                                        .seaMist
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
                                                    personalColor: AppColors
                                                        .seaMist
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
                              height:
                                  20, // Adjust the height of the blur effect
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
          Positioned(
            left: 32.w,
            bottom: 28.h,
            child: Align(
              alignment: Alignment.bottomLeft,
              child: GestureDetector(
                onTap: () {
                  // Navigator.pushNamed(context, Routes.orderStatus);
                  Navigator.pushNamed(context, Routes.orderList);
                },
                child: Container(
                  height: 50.h,
                  width: 142.w,
                  decoration: BoxDecoration(
                      color: AppColors.lightGreen,
                      boxShadow: kDropShadow,
                      borderRadius: BorderRadius.circular(30.r)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SvgIcon(
                        icon: IconStrings.viewOrder,
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        'VIEW ORDER',
                        style: GoogleFonts.publicSans(
                          color: AppColors.seaShell,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
