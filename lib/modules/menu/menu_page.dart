import 'dart:developer';
import 'package:amtech_design/core/utils/app_colors.dart';
import 'package:amtech_design/core/utils/enums/enums.dart';
import 'package:amtech_design/core/utils/strings.dart';
import 'package:amtech_design/custom_widgets/svg_icon.dart';
import 'package:amtech_design/modules/map/google_map_provider.dart';
import 'package:amtech_design/modules/menu/menu_provider.dart';
import 'package:amtech_design/modules/menu/widgets/banner_view.dart';
import 'package:amtech_design/modules/menu/widgets/divider_label.dart';
import 'package:amtech_design/modules/menu/widgets/edge_gradient_blur_widget.dart';
import 'package:amtech_design/modules/menu/widgets/menu_page_loader.dart';
import 'package:amtech_design/modules/menu/widgets/page_edge_blur_widget.dart';
import 'package:amtech_design/modules/menu/widgets/pinned_header.dart';
import 'package:amtech_design/modules/menu/widgets/product_widget.dart';
import 'package:amtech_design/modules/menu/widgets/subscription_banner_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../core/utils/constant.dart';
import '../../core/utils/constants/keys.dart';
import '../../custom_widgets/appbar/custom_sliver_appbar.dart';
import '../../custom_widgets/textfield/custom_searchfield.dart';
import '../../routes.dart';
import '../../services/local/shared_preferences_service.dart';
import '../provider/socket_provider.dart';
import 'widgets/address_widget_home_page.dart';
import 'widgets/fab_menu_button.dart';
import 'widgets/slider_details_widget.dart';

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
    final String accountType =
        sharedPrefsService.getString(SharedPrefsKeys.accountType) ?? '';
    final provider = Provider.of<MenuProvider>(context, listen: false);

    //! Note: variable is not used but by initialize this socket connect
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
                                            AddressWidgetHomePage(
                                              accountType: accountType,
                                              provider: provider,
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 15.h),

                                      //* Progress bar details widget
                                      Consumer<MenuProvider>(
                                          builder: (context, _, child) {
                                        final homeMenuData =
                                            provider.homeMenuResponse?.data;
                                        return ProgressDetailsWidget(
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

                                      // * Linear progress indicator
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 22.w),
                                        child: Container(
                                          height: 6.h,
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
                                          child: Consumer<MenuProvider>(
                                              builder: (context, _, child) {
                                            return Stack(
                                              children: [
                                                FractionallySizedBox(
                                                  widthFactor: provider
                                                      .progress, // Progress
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
                                            );
                                          }),
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
                                    //* Hint: Change min/max height incase of sliver size issue
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
                                            // * Banner View
                                            BannerView(
                                              accountType: accountType,
                                            ),
                                            SizedBox(height: 20.h),
                                            // * Subscriptions Banner
                                            const SubscriptionBannerWidget(),
                                            SizedBox(height: 20.h),
                                            // * ListView Categories
                                            Consumer<MenuProvider>(
                                              builder: (context, _, child) {
                                                return ListView.separated(
                                                  // controller: widget.scrollController,
                                                  shrinkWrap: true,
                                                  padding: EdgeInsets.zero,
                                                  physics:
                                                      const NeverScrollableScrollPhysics(),
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
                                                                      image: (menuItems?.images?.isNotEmpty ??
                                                                              false)
                                                                          ? menuItems!
                                                                              .images![0]
                                                                          : '',
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
                                            SizedBox(height: 18.h),
                                            const SizedBox(height: 20.0),
                                            //! Health First (Keep it for ref)
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
                                                EdgeGradientBlurWidget(
                                                  position: EdgePosition.top,
                                                  size: 150.h,
                                                  solidColor:
                                                      getColorAccountType(
                                                    accountType: accountType,
                                                    businessColor:
                                                        AppColors.seaShell,
                                                    personalColor:
                                                        AppColors.seaMist,
                                                  ),
                                                  transparentColor:
                                                      getColorAccountType(
                                                    accountType: accountType,
                                                    businessColor: AppColors
                                                        .seaShell
                                                        .withOpacity(0),
                                                    personalColor: AppColors
                                                        .seaMist
                                                        .withOpacity(0),
                                                  ),
                                                ),
                                                // Left edge gradient
                                                EdgeGradientBlurWidget(
                                                  position: EdgePosition.left,
                                                  size: 50,
                                                  solidColor:
                                                      getColorAccountType(
                                                    accountType: accountType,
                                                    businessColor:
                                                        AppColors.seaShell,
                                                    personalColor:
                                                        AppColors.seaMist,
                                                  ),
                                                  transparentColor:
                                                      getColorAccountType(
                                                    accountType: accountType,
                                                    businessColor: AppColors
                                                        .seaShell
                                                        .withOpacity(0),
                                                    personalColor: AppColors
                                                        .seaMist
                                                        .withOpacity(0),
                                                  ),
                                                ),
                                                // Right edge gradient
                                                EdgeGradientBlurWidget(
                                                  position: EdgePosition.right,
                                                  size: 50,
                                                  solidColor:
                                                      getColorAccountType(
                                                    accountType: accountType,
                                                    businessColor:
                                                        AppColors.seaShell,
                                                    personalColor:
                                                        AppColors.seaMist,
                                                  ),
                                                  transparentColor:
                                                      getColorAccountType(
                                                    accountType: accountType,
                                                    businessColor: AppColors
                                                        .seaShell
                                                        .withOpacity(0),
                                                    personalColor: AppColors
                                                        .seaMist
                                                        .withOpacity(0),
                                                  ),
                                                ),
                                                // Bottom edge gradient
                                                EdgeGradientBlurWidget(
                                                  position: EdgePosition.bottom,
                                                  size: 150,
                                                  solidColor:
                                                      getColorAccountType(
                                                    accountType: accountType,
                                                    businessColor:
                                                        AppColors.seaShell,
                                                    personalColor:
                                                        AppColors.seaMist,
                                                  ),
                                                  transparentColor:
                                                      getColorAccountType(
                                                    accountType: accountType,
                                                    businessColor: AppColors
                                                        .seaShell
                                                        .withOpacity(0),
                                                    personalColor: AppColors
                                                        .seaMist
                                                        .withOpacity(0),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      //* Added for blur effect on page (left, right, bottom)
                                      PageEdgeBlurWidget(
                                        edge: PageEdge.left,
                                        size: 20,
                                        solidColor: getColorAccountType(
                                          accountType: accountType,
                                          businessColor: AppColors.seaShell,
                                          personalColor: AppColors.seaMist,
                                        ),
                                        transparentColor: getColorAccountType(
                                          accountType: accountType,
                                          businessColor:
                                              AppColors.seaShell.withOpacity(0),
                                          personalColor:
                                              AppColors.seaMist.withOpacity(0),
                                        ),
                                      ),
                                      // Right edge gradient
                                      PageEdgeBlurWidget(
                                        edge: PageEdge.right,
                                        size: 20,
                                        solidColor: getColorAccountType(
                                          accountType: accountType,
                                          businessColor: AppColors.seaShell,
                                          personalColor: AppColors.seaMist,
                                        ),
                                        transparentColor: getColorAccountType(
                                          accountType: accountType,
                                          businessColor:
                                              AppColors.seaShell.withOpacity(0),
                                          personalColor:
                                              AppColors.seaMist.withOpacity(0),
                                        ),
                                      ),
                                      // Bottom edge gradient
                                      PageEdgeBlurWidget(
                                        edge: PageEdge.bottom,
                                        size: 20,
                                        solidColor: getColorAccountType(
                                          accountType: accountType,
                                          businessColor: AppColors.seaShell,
                                          personalColor: AppColors.seaMist,
                                        ),
                                        transparentColor: getColorAccountType(
                                          accountType: accountType,
                                          businessColor:
                                              AppColors.seaShell.withOpacity(0),
                                          personalColor:
                                              AppColors.seaMist.withOpacity(0),
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
