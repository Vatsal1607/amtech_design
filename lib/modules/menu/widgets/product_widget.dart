import 'package:amtech_design/custom_widgets/size_modal_bottom_sheet.dart';
import 'package:amtech_design/custom_widgets/snackbar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/constant.dart';
import '../../../core/utils/strings.dart';
import '../../../custom_widgets/svg_icon.dart';
import '../../../models/home_menu_model.dart';

class ProductWidget extends StatelessWidget {
  final String image;
  final String name;
  final int index;
  final String accountType;
  final bool isHealthFirst;
  final dynamic provider;
  final MenuItems? menuItems;
  final bool isActive; // out of stock flag
  const ProductWidget({
    super.key,
    required this.image,
    required this.name,
    required this.index,
    required this.accountType,
    this.isHealthFirst = false,
    this.provider,
    this.menuItems,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        //* NEW cached network image
        Container(
          height: 150.h,
          width: 120.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30.r),
            border: Border.all(
              color:
                  isHealthFirst ? AppColors.deepGreen : AppColors.primaryColor,
              width: 2.w,
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30.r),
            child: Stack(
              fit: StackFit.expand,
              children: [
                // * Cached Background Image
                CachedNetworkImage(
                  imageUrl: image,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(
                    color: Colors.grey[300],
                    child: const Center(
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  ),
                  errorWidget: (context, url, error) => Container(
                    color: Colors.grey[200],
                    child: const Center(
                      child: Icon(Icons.broken_image, color: Colors.grey),
                    ),
                  ),
                ),

                // * Bottom Gradient Overlay
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: 58.h,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: isHealthFirst
                            ? [
                                AppColors.teaGreen.withOpacity(0.0),
                                AppColors.teaGreen.withOpacity(0.8),
                                AppColors.teaGreen,
                              ]
                            : [
                                AppColors.seaShell.withOpacity(0.0),
                                AppColors.seaShell.withOpacity(0.8),
                                AppColors.seaShell,
                              ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        stops: const [0.0, 0.5, 1.0],
                      ),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30.r),
                        bottomRight: Radius.circular(30.r),
                      ),
                    ),
                  ),
                ),

                // * Foreground Content
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 18.h),
                    child: Text(
                      capitalizeEachWord(name),
                      maxLines: 1,
                      overflow: TextOverflow.visible,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.publicSans(
                        fontWeight: FontWeight.bold,
                        fontSize: 12.sp,
                        color: isHealthFirst
                            ? AppColors.deepGreen
                            : getColorAccountType(
                                accountType: accountType,
                                businessColor: AppColors.primaryColor,
                                personalColor: AppColors.darkGreenGrey,
                              ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Align(
            alignment: Alignment.bottomCenter,
            //* ADD Button of Product widget
            child: isActive
                ? GestureDetector(
                    onTap: () async {
                      //* Store logic Online / Offline
                      bool storeStatus = await provider.getStoreStatus(context);
                      if (storeStatus) {
                        //* Store is open //* Custom Size bottomsheet
                        showSizeModalBottomSheet(
                          context: context,
                          accountType: accountType,
                          provider: provider,
                          menuItems: menuItems,
                          menuId: menuItems?.menuId ?? '',
                        );
                      } else {
                        //* Store is offline
                        customSnackBar(
                            context: context,
                            message:
                                "We're sorry, the store is offline at the moment.");
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        vertical: 3.h,
                        horizontal: 8.w,
                      ),
                      decoration: BoxDecoration(
                        color: isHealthFirst
                            ? AppColors.deepGreen
                            : getColorAccountType(
                                accountType: accountType,
                                businessColor: AppColors.primaryColor,
                                personalColor: AppColors.darkGreenGrey,
                              ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'ADD',
                            style: GoogleFonts.publicSans(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.bold,
                              color: AppColors.white,
                            ),
                          ),
                          SizedBox(width: 4.w),
                          const SvgIcon(icon: IconStrings.add),
                        ],
                      ),
                    ),
                  )
                : GestureDetector(
                    onTap: () {},
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        vertical: 3.h,
                        horizontal: 8.w,
                      ),
                      decoration: BoxDecoration(
                        color: isHealthFirst
                            ? AppColors.deepGreen
                            : isActive
                                ? getColorAccountType(
                                    accountType: accountType,
                                    businessColor: AppColors.primaryColor,
                                    personalColor: AppColors.darkGreenGrey,
                                  )
                                : AppColors.red,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'OUT OF STOCK',
                            style: GoogleFonts.publicSans(
                              fontSize: 10.sp,
                              fontWeight: FontWeight.bold,
                              color: AppColors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
          ),
        ),
      ],
    );
  }
}
