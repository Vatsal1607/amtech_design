import 'package:amtech_design/core/utils/constant.dart';
import 'package:amtech_design/custom_widgets/appbar/custom_appbar.dart';
import 'package:amtech_design/custom_widgets/buttons/custom_button.dart';
import 'package:amtech_design/custom_widgets/loader/custom_loader.dart';
import 'package:amtech_design/custom_widgets/size_modal_bottom_sheet.dart';
import 'package:amtech_design/custom_widgets/svg_icon.dart';
import 'package:amtech_design/modules/menu/menu_provider.dart';
import 'package:amtech_design/modules/product_page/widgets/bottomsheet_content.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../core/utils/app_colors.dart';
import '../../core/utils/constants/keys.dart';
import '../../core/utils/strings.dart';
import '../../custom_widgets/snackbar.dart';
import '../../services/local/shared_preferences_service.dart';
import 'product_details_provider.dart';

class ProductDetailsPage extends StatefulWidget {
  final String menuId;
  final List<String> imageUrls;
  const ProductDetailsPage({
    super.key,
    required this.menuId,
    required this.imageUrls,
  });

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider =
          Provider.of<ProductDetailsProvider>(context, listen: false);

      provider.getMenuDetails(menuId: widget.menuId); //* API call
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String accountType =
        sharedPrefsService.getString(SharedPrefsKeys.accountType) ?? '';
    final provider =
        Provider.of<ProductDetailsProvider>(context, listen: false);
    final images = widget.imageUrls;

    return Scaffold(
      extendBodyBehindAppBar: true, // Ensures content goes behind the AppBar
      backgroundColor: getColorAccountType(
        accountType: accountType,
        businessColor: AppColors.primaryColor,
        personalColor: AppColors.darkGreenGrey,
      ),
      appBar: CustomAppBar(
        backgroundColor: Colors.transparent,
        title: '',
        onTapLeading: () {
          Navigator.pop(context);
        },
        leading: Container(
          height: 48.h,
          width: 48.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: getColorAccountType(
              accountType: accountType,
              businessColor: AppColors.seaShell,
              personalColor: AppColors.seaMist,
            ),
          ),
          child: ClipOval(
            child: SvgIcon(
              icon: IconStrings.arrowBack,
              color: getColorAccountType(
                accountType: accountType,
                businessColor: AppColors.primaryColor,
                personalColor: AppColors.darkGreenGrey,
              ),
            ),
          ),
        ),
        actions: [
          GestureDetector(
            onTap: provider.isFavLoading
                ? null
                : () {
                    //* API call
                    if (provider.isFavorite == true) {
                      provider.removeFavorite(
                          context: context, menuId: widget.menuId);
                    } else {
                      provider.favoritesAdd(
                          context: context, menuId: widget.menuId);
                    }
                  },
            child: Container(
              height: 45.h,
              width: 45.w,
              margin: EdgeInsets.only(right: 15.w),
              decoration: BoxDecoration(
                color: getColorAccountType(
                  accountType: accountType,
                  businessColor: AppColors.primaryColor,
                  personalColor: AppColors.darkGreenGrey,
                ),
                shape: BoxShape.circle,
              ),
              child: Consumer<ProductDetailsProvider>(
                builder: (context, _, child) =>
                    provider.isFavLoading || provider.isLoading
                        ? const CustomLoader(
                            color: AppColors.seaShell,
                            backgroundColor: AppColors.white,
                          )
                        : SvgIcon(
                            icon: provider.isFavorite
                                ? IconStrings.favorite
                                : IconStrings.heart,
                            color: provider.isFavorite
                                ? AppColors.lightGreen
                                : AppColors.seaShell,
                          ),
              ),
            ),
          ),
        ],
      ),
      body: Consumer<ProductDetailsProvider>(
        builder: (context, _, child) => provider.isLoading
            ? Center(
                child: CustomLoader(
                    color: getColorAccountType(
                  accountType: accountType,
                  businessColor: AppColors.seaShell,
                  personalColor: AppColors.seaMist,
                )),
              )
            : Stack(
                children: [
                  // * Top content above the DraggableScrollableSheet
                  Stack(
                    // mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: 440.h,
                        width: double.infinity,
                        child: PageView.builder(
                          controller: provider.pageController,
                          itemCount: images.length,
                          onPageChanged: provider.onPageChanged,
                          itemBuilder: (context, index) {
                            return CachedNetworkImage(
                              imageUrl: images[index],
                              fit: BoxFit.cover,
                            );
                          },
                        ),
                      ),
                      Positioned(
                        bottom: 40.h,
                        left: 1.sw / 2,
                        child: SmoothPageIndicator(
                          controller: provider.pageController,
                          count: images.length,
                          effect: WormEffect(
                            dotHeight: 10,
                            dotWidth: 10,
                            activeDotColor: Colors.green,
                            dotColor: Colors.grey.shade300,
                          ),
                        ),
                      ),
                    ],
                  ),
                  // * DraggableScrollableSheet at the bottom
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: DraggableScrollableSheet(
                      expand: false, // doesn’t take over the entire screen
                      initialChildSize: 0.55, // Initial height
                      minChildSize: 0.55, // Minimum height
                      maxChildSize: 0.8, // Maximum height
                      shouldCloseOnMinExtent: false,
                      builder: (context, scrollController) {
                        return Container(
                          decoration: BoxDecoration(
                            color: getColorAccountType(
                              accountType: accountType,
                              businessColor: AppColors.seaShell,
                              personalColor: AppColors.seaMist,
                            ),
                            borderRadius: BorderRadius.vertical(
                                top: Radius.circular(16.r)),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // Handle to indicate dragging
                              Container(
                                width: 40.w,
                                height: 6.h,
                                margin: EdgeInsets.only(top: 8.h),
                                decoration: BoxDecoration(
                                  color: AppColors.shipGrey.withOpacity(.3),
                                  borderRadius: BorderRadius.circular(3.r),
                                ),
                              ),
                              Expanded(
                                child: Stack(
                                  children: [
                                    SingleChildScrollView(
                                      controller: scrollController,
                                      physics: const ClampingScrollPhysics(),
                                      child: BottomsheetContent(
                                        accountType: accountType,
                                        menuDetails:
                                            provider.menuDetailsResponse,
                                      ),
                                    ),
                                    // * Add to cart button
                                    Positioned(
                                      bottom: 50.h,
                                      left: 34.w,
                                      right: 34.w,
                                      child: Consumer<MenuProvider>(
                                        builder:
                                            (context, menuProvider, child) =>
                                                CustomButton(
                                          height: 55.h,
                                          onTap: () async {
                                            bool storeStatus =
                                                await menuProvider
                                                    .getStoreStatus(context);
                                            //* Out of stock (isActive)
                                            if (provider.isActive) {
                                              if (storeStatus) {
                                                //* Store is open //* Custom Size bottomsheet
                                                showSizeModalBottomSheet(
                                                  context: context,
                                                  accountType: accountType,
                                                  provider: menuProvider,
                                                  menuId: widget.menuId,
                                                );
                                              } else {
                                                //* Store is offline
                                                customSnackBar(
                                                    context: context,
                                                    message:
                                                        "We're sorry, the store is offline at the moment.");
                                              }
                                            } else {}
                                          },
                                          text: provider.isActive
                                              ? 'ADD TO CART'
                                              : 'OUT OF STOCK',
                                          textColor: getColorAccountType(
                                            accountType: accountType,
                                            businessColor: AppColors.seaShell,
                                            personalColor: AppColors.seaMist,
                                          ),
                                          bgColor: provider.isActive
                                              ? getColorAccountType(
                                                  accountType: accountType,
                                                  businessColor:
                                                      AppColors.primaryColor,
                                                  personalColor:
                                                      AppColors.darkGreenGrey,
                                                )
                                              : AppColors.red,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
