import 'package:amtech_design/modules/notification/notification_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../core/utils/app_colors.dart';
import '../../core/utils/constant.dart';
import '../../core/utils/strings.dart';
import '../../modules/menu/menu_provider.dart';
import '../../routes.dart';
import '../svg_icon.dart';

class CustomSliverAppbar extends StatelessWidget {
  const CustomSliverAppbar({
    super.key,
    required this.accountType,
  });

  final String accountType;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MenuProvider>(context, listen: false);
    final notificationProvider =
        Provider.of<NotificationProvider>(context, listen: false);
    return SliverAppBar(
      backgroundColor: getColorAccountType(
        accountType: accountType,
        businessColor: AppColors.seaShell,
        personalColor: AppColors.seaMist,
      ),
      centerTitle: true,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //! leading icon
          GestureDetector(
            onTap: () => Navigator.pushNamed(context, Routes.profile),
            //* IMP: Account switch logic
            onLongPress: provider.onVerticalDragDownLeading,
            child: Container(
              height: 48.h,
              width: 48.w,
              decoration: BoxDecoration(
                boxShadow: kDropShadow,
                color: Colors.black,
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.primaryColor,
                  width: 2.w,
                ),
              ),
              child: ClipOval(
                child: Consumer<MenuProvider>(builder: (context, _, child) {
                  final imageUrl =
                      provider.homeMenuResponse?.data?.profileImage;
                  return (imageUrl == null || imageUrl.isEmpty)
                      ? SizedBox(
                          height: 30.h,
                          width: 30.w,
                          child: Image.asset(
                            ImageStrings.defaultAvatar,
                            color: AppColors.white,
                            fit: BoxFit.contain,
                          ),
                        )
                      : CachedNetworkImage(
                          imageUrl: imageUrl ?? '',
                          fit: BoxFit.cover,
                          placeholder: (context, url) =>
                              CircularProgressIndicator(
                            color: getColorAccountType(
                              accountType: accountType,
                              businessColor: AppColors.primaryColor,
                              personalColor: AppColors.darkGreenGrey,
                            ),
                          ),
                          errorWidget: (context, url, error) => const Icon(
                            Icons.account_circle,
                            size: 48,
                            color: Colors.grey,
                          ),
                        );
                }),
              ),
            ),
          ),

          //! center title content
          Column(
            children: [
              SizedBox(height: 2.h),
              Consumer<MenuProvider>(
                builder: (context, menuProvider, child) => Text(
                  menuProvider.getGreeting(),
                  style: GoogleFonts.publicSans(
                    color: getColorAccountType(
                      accountType: accountType,
                      businessColor: AppColors.primaryColor,
                      personalColor: AppColors.darkGreenGrey,
                    ),
                    fontSize: 15.sp,
                  ),
                ),
              ),
              Row(
                children: [
                  Consumer<MenuProvider>(
                    builder: (context, menuProvider, child) => Text(
                      accountType == 'business'
                          ? menuProvider.homeMenuResponse?.data?.businessName ??
                              'User'
                          : '${menuProvider.homeMenuResponse?.data?.firstName ?? 'User'}'
                              ' ${menuProvider.homeMenuResponse?.data?.lastName ?? ''}',
                      style: GoogleFonts.publicSans(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.bold,
                        color: getColorAccountType(
                          accountType: accountType,
                          businessColor: AppColors.primaryColor,
                          personalColor: AppColors.darkGreenGrey,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 5.w),
                  const SvgIcon(
                    icon: IconStrings.verifiedUser,
                    color: AppColors.disabledColor,
                  ),
                ],
              ),
            ],
          ),

          //! trailing(action) icon
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, Routes.notification);
            },
            child: Container(
              height: 48.h,
              width: 48.w,
              decoration: BoxDecoration(
                boxShadow: kDropShadow,
                color: getColorAccountType(
                  accountType: accountType,
                  businessColor: AppColors.primaryColor,
                  personalColor: AppColors.darkGreenGrey,
                ),
                shape: BoxShape.circle,
              ),
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Center(
                      child: SvgIcon(
                        icon: IconStrings.notification2,
                        color: AppColors.white,
                        height: 20.h,
                        width: 20.w,
                      ),
                    ),
                  ),
                  if (notificationProvider.unreadCount != 0)
                    Positioned(
                      top: 0,
                      right: 0,
                      child: Container(
                        height: 20.h,
                        width: 20.h,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.red,
                        ),
                        child: Center(
                          child: Consumer<NotificationProvider>(
                            builder: (context, provider, child) => Text(
                              // '99+',
                              '${provider.unreadCount}',
                              style: GoogleFonts.publicSans(
                                fontSize: 8.sp,
                                fontWeight: FontWeight.bold,
                                color: AppColors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
      automaticallyImplyLeading: false,
      // expandedHeight: 150.h,
      /// Bottom content of appbar
      // bottom: PreferredSize(
    );
  }
}
