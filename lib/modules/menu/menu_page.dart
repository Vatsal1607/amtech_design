import 'dart:developer';
import 'package:amtech_design/core/utils/app_colors.dart';
import 'package:amtech_design/core/utils/enums/enums.dart';
import 'package:amtech_design/core/utils/strings.dart';
import 'package:amtech_design/custom_widgets/buttons/small_edit_button.dart';
import 'package:amtech_design/custom_widgets/svg_icon.dart';
import 'package:amtech_design/modules/map/google_map_provider.dart';
import 'package:amtech_design/modules/menu/menu_provider.dart';
import 'package:amtech_design/modules/menu/widgets/banner_view.dart';
import 'package:amtech_design/modules/menu/widgets/divider_label.dart';
import 'package:amtech_design/modules/menu/widgets/menu_page_loader.dart';
import 'package:amtech_design/modules/menu/widgets/pinned_header.dart';
import 'package:amtech_design/modules/menu/widgets/product_widget.dart';
import 'package:amtech_design/modules/menu/widgets/subscription_banner_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:marquee/marquee.dart';
import 'package:provider/provider.dart';
import '../../core/utils/constant.dart';
import '../../core/utils/constants/keys.dart';
import '../../custom_widgets/appbar/custom_sliver_appbar.dart';
import '../../custom_widgets/textfield/custom_searchfield.dart';
import '../../routes.dart';
import '../../services/local/shared_preferences_service.dart';
import '../provider/socket_provider.dart';
import 'widgets/fab_menu_button.dart';
import 'widgets/slider_details_widget.dart';
import 'widgets/subscription_widget.dart';

class MenuPage extends StatefulWidget {
  final ScrollController scrollController;
  const MenuPage({super.key, required this.scrollController});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<GoogleMapProvider>().getCurrentLocation();
      context.read<MenuProvider>().homeMenuApi(); //* API call
      context.read<MenuProvider>().getBanner(); //* API call
      final provider = Provider.of<MenuProvider>(context, listen: false);
      final selectedAddressTypeString =
          sharedPrefsService.getString(SharedPrefsKeys.selectedAddressType);

      provider.selectedAddressType = selectedAddressTypeString != null
          ? HomeAddressType.values.firstWhere(
              (e) => e.name == selectedAddressTypeString, // Match by enum name
              orElse: () =>
                  HomeAddressType.local, // Provide a default if no match
            )
          : null; // If the stored value is null, assign null
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    log('userId: ${sharedPrefsService.getString(SharedPrefsKeys.userId)}');
    String accountType =
        sharedPrefsService.getString(SharedPrefsKeys.accountType) ?? '';
    final provider = Provider.of<MenuProvider>(context, listen: false);

    //* Note: variable is not used but by initialize this socket connect
    final socketProvider = Provider.of<SocketProvider>(context, listen: false);
    //* Show cart snackbar
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   provider.updateSnackBarVisibility(true);
    //   provider.scaffoldMessengerKey.currentState
    //       ?.showSnackBar(
    //         cartSnackbarWidget(
    //           accountType: accountType,
    //           message: '${provider.cartSnackbarTotalItems} Items added',
    //           items: provider.cartSnackbarItemText,
    //           context: context,
    //         ),
    //       )
    //       .closed
    //       .then((_) {
    //     provider.updateSnackBarVisibility(false);
    //     log('Snackbar is closed');
    //   });
    // });
    return Consumer<MenuProvider>(
      builder: (context, _, child) => provider.isLoading ||
              provider.isLoadingGetBanner
          ? const MenuPageLoader()
          : Scaffold(
              backgroundColor: getColorAccountType(
                accountType: accountType,
                businessColor: AppColors.seaShell,
                personalColor: AppColors.seaMist,
              ),
              // * FAB
              floatingActionButton: Consumer<MenuProvider>(
                builder: (context, _, child) => Padding(
                  padding: provider.isSnackBarVisible
                      ? EdgeInsets.only(bottom: 62.h)
                      : EdgeInsets.zero,
                  child: FabMenuButton(
                    provider: provider,
                    accountType: accountType,
                  ),
                ),
              ),
              body: FocusableActionDetector(
                // autofocus: true,
                // onFocusChange: (value) {
                //   if (value == true) {
                //     context.read<MenuProvider>().homeMenuApi(); //* API call
                //   }
                // },
                child: Stack(
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                          child: NotificationListener(
                            onNotification: provider.onNotification,
                            child: CustomScrollView(
                              controller: widget.scrollController,
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
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 20.w),
                                        child: Row(
                                          children: [
                                            SvgIcon(
                                              icon: IconStrings.markerHome,
                                              color: getColorAccountType(
                                                accountType: accountType,
                                                businessColor:
                                                    AppColors.primaryColor,
                                                personalColor:
                                                    AppColors.darkGreenGrey,
                                              ),
                                            ),
                                            SizedBox(width: 5.w),
                                            //* Address widget
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    Text(
                                                      'Deliver To, ',
                                                      style: GoogleFonts
                                                          .publicSans(
                                                        fontSize: 12.sp,
                                                        color:
                                                            getColorAccountType(
                                                          accountType:
                                                              accountType,
                                                          businessColor:
                                                              AppColors
                                                                  .primaryColor,
                                                          personalColor:
                                                              AppColors
                                                                  .darkGreenGrey,
                                                        ),
                                                      ),
                                                    ),
                                                    Text(
                                                      'HOME',
                                                      style: GoogleFonts
                                                          .publicSans(
                                                        fontSize: 12.sp,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color:
                                                            getColorAccountType(
                                                          accountType:
                                                              accountType,
                                                          businessColor:
                                                              AppColors
                                                                  .primaryColor
                                                                  .withOpacity(
                                                                      0.8),
                                                          personalColor:
                                                              AppColors
                                                                  .darkGreenGrey
                                                                  .withOpacity(
                                                                      0.8),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    SizedBox(
                                                      width: provider
                                                          .addressWidth.w,
                                                      height: 20.h,
                                                      child: Consumer<
                                                              MenuProvider>(
                                                          builder: (context, _,
                                                              child) {
                                                        final address = provider
                                                            .homeMenuResponse
                                                            ?.data
                                                            ?.address;
                                                        final storedAddress =
                                                            sharedPrefsService
                                                                .getString(
                                                                    SharedPrefsKeys
                                                                        .selectedAddress);
                                                        if ((address == null ||
                                                                address
                                                                    .isEmpty) &&
                                                            (storedAddress ==
                                                                    null ||
                                                                storedAddress
                                                                    .isEmpty)) {
                                                          return SizedBox(
                                                            child: Text(
                                                              'Please Select Your Address',
                                                              style: GoogleFonts
                                                                  .publicSans(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                          );
                                                        }
                                                        //* Measure text width Address
                                                        TextPainter
                                                            textPainter =
                                                            TextPainter(
                                                          text: TextSpan(
                                                            text: provider
                                                                        .selectedAddressType ==
                                                                    HomeAddressType
                                                                        .local
                                                                ? storedAddress
                                                                : address,
                                                            style: GoogleFonts
                                                                .publicSans(
                                                              fontSize: 15.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                          maxLines: 1,
                                                          textDirection:
                                                              TextDirection.ltr,
                                                        )..layout(
                                                                maxWidth: provider
                                                                    .addressWidth
                                                                    .w);

                                                        // If text overflows, use Marquee, otherwise use normal Text
                                                        bool isOverflowing =
                                                            textPainter
                                                                .didExceedMaxLines;
                                                        return isOverflowing
                                                            ? Marquee(
                                                                velocity: 20,
                                                                scrollAxis: Axis
                                                                    .horizontal,
                                                                blankSpace: 15,
                                                                pauseAfterRound:
                                                                    const Duration(
                                                                        seconds:
                                                                            3),
                                                                text: provider
                                                                            .selectedAddressType ==
                                                                        HomeAddressType
                                                                            .local
                                                                    ? '$storedAddress.'
                                                                    : '$address.',
                                                                style: GoogleFonts
                                                                    .publicSans(
                                                                  fontSize:
                                                                      15.sp,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color:
                                                                      getColorAccountType(
                                                                    accountType:
                                                                        accountType,
                                                                    businessColor:
                                                                        AppColors
                                                                            .primaryColor,
                                                                    personalColor:
                                                                        AppColors
                                                                            .darkGreenGrey,
                                                                  ),
                                                                ),
                                                              )
                                                            : Text(
                                                                provider.selectedAddressType ==
                                                                        HomeAddressType
                                                                            .local
                                                                    ? storedAddress ??
                                                                        ''
                                                                    : address ??
                                                                        '',
                                                                style: GoogleFonts
                                                                    .publicSans(
                                                                  fontSize:
                                                                      15.sp,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color:
                                                                      getColorAccountType(
                                                                    accountType:
                                                                        accountType,
                                                                    businessColor:
                                                                        AppColors
                                                                            .primaryColor,
                                                                    personalColor:
                                                                        AppColors
                                                                            .darkGreenGrey,
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
                                                          Navigator.pushNamed(
                                                              context,
                                                              Routes
                                                                  .savedAddress);
                                                        },
                                                        accountType:
                                                            accountType,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 15.h),

                                      //* Slider details widget
                                      Consumer<MenuProvider>(
                                          builder: (context, _, child) {
                                        final homeMenuData =
                                            provider.homeMenuResponse?.data;
                                        return SliderDetailsWidget(
                                          isShowRecharge: true,
                                          accountType: accountType,
                                          filledValue:
                                              '₹ ${homeMenuData?.usedAmount ?? '0'}',
                                          totalValue:
                                              '₹ ${homeMenuData?.rechargeAmount ?? '0'}',
                                          label: 'perks used',
                                          icon: IconStrings.rupee,
                                        );
                                      }),
                                      SizedBox(height: 13.h),

                                      // * Linear progress indicator:
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 22.0),
                                        child: Container(
                                          height: 6
                                              .h, // Height of the credit progress bar
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                              colors: [
                                                AppColors.lightGreen
                                                    .withOpacity(.2),
                                                AppColors.red.withOpacity(.2),
                                              ], // Gradient for background
                                            ),
                                            borderRadius: BorderRadius.circular(
                                                5.0), // Rounded corners
                                          ),
                                          child: Stack(
                                            children: [
                                              FractionallySizedBox(
                                                widthFactor:
                                                    0.4, // * based on progress
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
                                                        BorderRadius.circular(
                                                            5.0),
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
                                          minExtent: 20.h,
                                          maxExtent: 20.h,
                                          child: SizedBox(height: 20.h),
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
                                      margin: EdgeInsets.symmetric(
                                        horizontal: 20.w,
                                      ),
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(100.r),
                                        boxShadow: kDropShadow,
                                      ),
                                      //* SearchField
                                      child: CustomSearchField(
                                        provider: provider,
                                        accountType: accountType,
                                        textAlignVertical:
                                            TextAlignVertical.bottom,
                                        controller: provider.searchController,
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
                                            const SizedBox(height: 20.0),

                                            //* Subscriptions Banner
                                            SubscriptionBannerWidget(),

                                            //* Subscriptions
                                            // GestureDetector(
                                            //   onTap: () {
                                            //     Navigator.pushNamed(
                                            //       context,
                                            //       Routes.productDetails,
                                            //       arguments: {
                                            //         'menuId':
                                            //             '', // Todo set menuId
                                            //         'detailsType': DetailsType
                                            //             .subscription.name,
                                            //       },
                                            //     );
                                            //   },
                                            //   child: SubscriptionWidget(
                                            //     provider: provider,
                                            //   ),
                                            // ),

                                            // * ListView Categories
                                            Consumer<MenuProvider>(
                                              builder: (context, _, child) {
                                                return ListView.separated(
                                                  // controller: widget.scrollController,
                                                  shrinkWrap: true,
                                                  padding: EdgeInsets.zero,
                                                  physics:
                                                      const NeverScrollableScrollPhysics(),
                                                  // itemCount:
                                                  //     provider.menuCategories?.length ??
                                                  //         0,
                                                  itemCount: provider
                                                      .filteredCategories
                                                      .length,
                                                  separatorBuilder: (context,
                                                          index) =>
                                                      SizedBox(height: 15.h),
                                                  itemBuilder:
                                                      (context, parentIndex) {
                                                    final categoryTitle = provider
                                                            .filteredCategories[
                                                                parentIndex]
                                                            .categoryTitle ??
                                                        '';
                                                    return Column(
                                                      children: [
                                                        Padding(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      20.w),
                                                          child: DividerLabel(
                                                            key: provider
                                                                    .dynamicKeys[
                                                                categoryTitle],
                                                            label:
                                                                categoryTitle,
                                                            accountType:
                                                                accountType,
                                                          ),
                                                        ),
                                                        SizedBox(height: 15.h),
                                                        // * Categories horizontal view
                                                        Align(
                                                          alignment:
                                                              Alignment.topLeft,
                                                          child: SizedBox(
                                                            height: 157.h,
                                                            //* ListView Items
                                                            child: ListView
                                                                .separated(
                                                              padding: EdgeInsets
                                                                  .symmetric(
                                                                      horizontal:
                                                                          20.w),
                                                              shrinkWrap: true,
                                                              itemCount: provider
                                                                      .filteredCategories[
                                                                          parentIndex]
                                                                      .menuItems
                                                                      ?.length ??
                                                                  0,
                                                              scrollDirection:
                                                                  Axis.horizontal,
                                                              separatorBuilder:
                                                                  (context,
                                                                          index) =>
                                                                      SizedBox(
                                                                          width:
                                                                              10.w),
                                                              itemBuilder:
                                                                  (context,
                                                                      childIndex) {
                                                                final menuItems = provider
                                                                    .filteredCategories[
                                                                        parentIndex]
                                                                    .menuItems?[childIndex];

                                                                return Consumer<
                                                                    MenuProvider>(
                                                                  builder: (context,
                                                                          provider,
                                                                          child) =>
                                                                      GestureDetector(
                                                                    onTap: () {
                                                                      debugPrint(
                                                                          'Product item pressed $childIndex');
                                                                      Navigator
                                                                          .pushNamed(
                                                                        context,
                                                                        Routes
                                                                            .productDetails,
                                                                        arguments: {
                                                                          'menuId':
                                                                              menuItems?.menuId,
                                                                          'detailsType': DetailsType
                                                                              .details
                                                                              .name,
                                                                        },
                                                                      );
                                                                    },
                                                                    child:
                                                                        ProductWidget(
                                                                      image:
                                                                          menuItems?.images ??
                                                                              '',
                                                                      name: menuItems
                                                                              ?.itemName ??
                                                                          '',
                                                                      index:
                                                                          childIndex,
                                                                      accountType:
                                                                          accountType,
                                                                      provider:
                                                                          provider,
                                                                      menuItems:
                                                                          menuItems,
                                                                    ),
                                                                  ),
                                                                );
                                                              },
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    );
                                                  },
                                                );
                                              },
                                            ),
                                            // * Best seller Product
                                            // * Best Seller Divider
                                            // Padding(
                                            //   padding: const EdgeInsets.symmetric(
                                            //       horizontal: 20.0),
                                            //   child: DividerLabel(
                                            //     key: provider.bestSellerKey,
                                            //     label: 'BEST SELLER',
                                            //     accountType: accountType,
                                            //   ),
                                            // ),
                                            // const SizedBox(height: 15.0),
                                            // // * Best seller horizontal view
                                            // SizedBox(
                                            //   height: 157.h,
                                            //   child: ListView.separated(
                                            //     padding: EdgeInsets.symmetric(
                                            //         horizontal: 20.w),
                                            //     shrinkWrap: true,
                                            //     itemCount: 4,
                                            //     scrollDirection: Axis.horizontal,
                                            //     separatorBuilder: (context, index) =>
                                            //         SizedBox(width: 10.w),
                                            //     itemBuilder: (context, index) {
                                            //       return Consumer<MenuProvider>(
                                            //         builder: (context, provider, child) =>
                                            //             GestureDetector(
                                            //           onTap: () {
                                            //             debugPrint(
                                            //                 'Product item pressed $index');
                                            //             Navigator.pushNamed(
                                            //               context,
                                            //               Routes.productDetails,
                                            //             );
                                            //           },
                                            //           child: ProductWidget(
                                            //             image:
                                            //                 provider.productImage[index],
                                            //             name: provider.productName[index],
                                            //             index: index,
                                            //             accountType: accountType,
                                            //           ),
                                            //         ),
                                            //       );
                                            //     },
                                            //   ),
                                            // ),
                                            SizedBox(height: 18.h),
                                            const SizedBox(height: 20.0),
                                            // * Health First (Keep it for ref)
                                            // Stack(
                                            //   children: [
                                            //     Container(
                                            //       height: 210.h,
                                            //       width: double.infinity,
                                            //       margin: EdgeInsets.symmetric(
                                            //         horizontal: 20.w,
                                            //       ),
                                            //       decoration: BoxDecoration(
                                            //         color: AppColors.lightGreen
                                            //             .withOpacity(.3),
                                            //         borderRadius:
                                            //             BorderRadius.circular(30.r),
                                            //       ),
                                            //       child: Column(
                                            //         mainAxisSize: MainAxisSize.min,
                                            //         children: [
                                            //           Padding(
                                            //             padding: EdgeInsets.symmetric(
                                            //                 horizontal: 20.w,
                                            //                 vertical: 10.h),
                                            //             child: DividerLabel(
                                            //               isHealthFirst: true,
                                            //               label: 'Health first',
                                            //               accountType: accountType,
                                            //             ),
                                            //           ),
                                            //           // * Health first horizontal view
                                            //           SizedBox(
                                            //             height: 157.h,
                                            //             child: ListView.separated(
                                            //               padding:
                                            //                   const EdgeInsets.symmetric(
                                            //                       horizontal: 20.0),
                                            //               shrinkWrap: true,
                                            //               itemCount: 4,
                                            //               scrollDirection:
                                            //                   Axis.horizontal,
                                            //               separatorBuilder: (context,
                                            //                       index) =>
                                            //                   const SizedBox(width: 10),
                                            //               itemBuilder: (context, index) {
                                            //                 return Consumer<MenuProvider>(
                                            //                   builder: (context, provider,
                                            //                           child) =>
                                            //                       GestureDetector(
                                            //                     onTap: () {
                                            //                       Navigator.pushNamed(
                                            //                         context,
                                            //                         Routes.productDetails,
                                            //                       );
                                            //                     },
                                            //                     child: ProductWidget(
                                            //                       isHealthFirst: true,
                                            //                       image: provider
                                            //                               .productImage[
                                            //                           index],
                                            //                       name: provider
                                            //                           .productName[index],
                                            //                       index: index,
                                            //                       accountType:
                                            //                           accountType,
                                            //                     ),
                                            //                   ),
                                            //                 );
                                            //               },
                                            //             ),
                                            //           ),
                                            //         ],
                                            //       ),
                                            //     ),
                                            //   ],
                                            // ),

                                            Stack(
                                              children: [
                                                ClipRect(
                                                  child: Image.asset(
                                                    ImageStrings
                                                        .bottomWatermark,
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
                                                        gradient:
                                                            LinearGradient(
                                                          begin: Alignment
                                                              .topCenter,
                                                          end: Alignment
                                                              .bottomCenter,
                                                          colors: [
                                                            getColorAccountType(
                                                              accountType:
                                                                  accountType,
                                                              businessColor:
                                                                  AppColors
                                                                      .seaShell,
                                                              personalColor:
                                                                  AppColors
                                                                      .seaMist,
                                                            ), // Your background color
                                                            getColorAccountType(
                                                              accountType:
                                                                  accountType,
                                                              businessColor:
                                                                  AppColors
                                                                      .seaShell
                                                                      .withOpacity(
                                                                          0),
                                                              personalColor:
                                                                  AppColors
                                                                      .seaMist
                                                                      .withOpacity(
                                                                          0),
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
                                                        gradient:
                                                            LinearGradient(
                                                          begin: Alignment
                                                              .centerLeft,
                                                          end: Alignment
                                                              .centerRight,
                                                          colors: [
                                                            getColorAccountType(
                                                              accountType:
                                                                  accountType,
                                                              businessColor:
                                                                  AppColors
                                                                      .seaShell,
                                                              personalColor:
                                                                  AppColors
                                                                      .seaMist,
                                                            ), // Your background color
                                                            getColorAccountType(
                                                              accountType:
                                                                  accountType,
                                                              businessColor:
                                                                  AppColors
                                                                      .seaShell
                                                                      .withOpacity(
                                                                          0),
                                                              personalColor:
                                                                  AppColors
                                                                      .seaMist
                                                                      .withOpacity(
                                                                          0),
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
                                                        gradient:
                                                            LinearGradient(
                                                          begin: Alignment
                                                              .centerRight,
                                                          end: Alignment
                                                              .centerLeft,
                                                          colors: [
                                                            getColorAccountType(
                                                              accountType:
                                                                  accountType,
                                                              businessColor:
                                                                  AppColors
                                                                      .seaShell,
                                                              personalColor:
                                                                  AppColors
                                                                      .seaMist,
                                                            ), // Your background color
                                                            getColorAccountType(
                                                              accountType:
                                                                  accountType,
                                                              businessColor:
                                                                  AppColors
                                                                      .seaShell
                                                                      .withOpacity(
                                                                          0),
                                                              personalColor:
                                                                  AppColors
                                                                      .seaMist
                                                                      .withOpacity(
                                                                          0),
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
                                                        gradient:
                                                            LinearGradient(
                                                          begin: Alignment
                                                              .bottomCenter,
                                                          end: Alignment
                                                              .topCenter,
                                                          colors: [
                                                            getColorAccountType(
                                                              accountType:
                                                                  accountType,
                                                              businessColor:
                                                                  AppColors
                                                                      .seaShell,
                                                              personalColor:
                                                                  AppColors
                                                                      .seaMist,
                                                            ), // Your background color
                                                            getColorAccountType(
                                                              accountType:
                                                                  accountType,
                                                              businessColor:
                                                                  AppColors
                                                                      .seaShell
                                                                      .withOpacity(
                                                                          0),
                                                              personalColor:
                                                                  AppColors
                                                                      .seaMist
                                                                      .withOpacity(
                                                                          0),
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
                                        width:
                                            20, // Adjust the width of the blur effect
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
                                            20, // Adjust the width of the blur effect
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
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Consumer<MenuProvider>(
                      builder: (context, _, child) => Positioned(
                        left: 32.w,
                        // bottom: 28.h,
                        bottom: provider.isSnackBarVisible
                            ? provider.viewOrderBottomPadding + 60
                            : provider.viewOrderBottomPadding,
                        child: Align(
                          alignment: Alignment.bottomLeft,
                          child: GestureDetector(
                            onTap: () {
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
                      ),
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
