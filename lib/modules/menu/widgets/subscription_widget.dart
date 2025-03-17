// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:provider/provider.dart';
// import 'package:smooth_page_indicator/smooth_page_indicator.dart';
// import '../../../core/utils/app_colors.dart';
// import '../../../core/utils/constant.dart';
// import '../../../core/utils/constants/keys.dart';
// import '../../../services/local/shared_preferences_service.dart';
// import '../menu_provider.dart';

// class SubscriptionWidget extends StatelessWidget {
//   const SubscriptionWidget({
//     super.key,
//     required this.provider,
//   });

//   final MenuProvider provider;

//   @override
//   Widget build(BuildContext context) {
//     String accountType =
//         sharedPrefsService.getString(SharedPrefsKeys.accountType) ?? '';
//     return Column(
//       children: [
//         SizedBox(
//           height: 250.h,
//           width: 425.w,
//           child: CarouselSlider.builder(
//             itemCount: provider.banners.length,
//             options: CarouselOptions(
//               viewportFraction: 1, // * Space between pages
//               enableInfiniteScroll: false, // * Disable infinite scrolling
//               onPageChanged: provider.onPageChangedsubscription,
//             ),
//             itemBuilder: (context, index, realIndex) {
//               return Stack(
//                 children: [
//                   Container(
//                     margin: EdgeInsets.symmetric(horizontal: 20.w),
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(30.r),
//                       image: DecorationImage(
//                         image: AssetImage(provider.subscriptionImages[index]),
//                         fit: BoxFit.fitWidth,
//                         // colorFilter: ColorFilter.mode(
//                         //   AppColors.primaryColor.withOpacity(0.5),
//                         //   BlendMode
//                         //       .srcATop, // Adjust blend mode based on your needs
//                         // ),
//                       ),
//                     ),
//                   ),
//                   //* Gradient on image
//                   Container(
//                     margin: EdgeInsets.symmetric(horizontal: 20.w),
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(30.r),
//                       gradient: LinearGradient(
//                         colors: [
//                           AppColors.primaryColor,
//                           AppColors.primaryColor.withOpacity(.2),
//                           // AppColors.primaryColor,
//                           // AppColors.primaryColor.withOpacity(.8),
//                           // AppColors.primaryColor.withOpacity(.4),
//                           // AppColors.primaryColor.withOpacity(0),
//                           // AppColors.primaryColor.withOpacity(0),
//                           // AppColors.primaryColor.withOpacity(0),
//                         ],
//                         begin: Alignment.centerLeft,
//                         end: Alignment.centerRight,
//                       ),
//                     ),
//                   ),
//                   //* Subscription image details
//                   Positioned(
//                     left: 19.w,
//                     bottom: 17.h,
//                     child: Padding(
//                       padding: EdgeInsets.symmetric(horizontal: 20.w),
//                       child: SizedBox(
//                         width: 270.w,
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               'SUBSCRIPTION OF',
//                               style: GoogleFonts.publicSans(
//                                 fontSize: 12.sp,
//                                 color: AppColors.white,
//                               ),
//                             ),
//                             Text(
//                               'Weekly Salads',
//                               style: GoogleFonts.publicSans(
//                                 fontSize: 25.sp,
//                                 fontWeight: FontWeight.bold,
//                                 color: AppColors.white,
//                               ),
//                             ),
//                             SizedBox(height: 5.h),
//                             Row(
//                               children: [
//                                 Container(
//                                   padding: EdgeInsets.symmetric(
//                                     vertical: 4.h,
//                                     horizontal: 8.w,
//                                   ),
//                                   decoration: BoxDecoration(
//                                     color: AppColors.disabledColor,
//                                     borderRadius: BorderRadius.circular(30.r),
//                                   ),
//                                   child: Text(
//                                     'REGULAR',
//                                     style: GoogleFonts.publicSans(
//                                       fontSize: 12.sp,
//                                       fontWeight: FontWeight.bold,
//                                       color: AppColors.white,
//                                     ),
//                                   ),
//                                 ),
//                                 SizedBox(width: 5.w),
//                                 Text(
//                                   '350 ML',
//                                   style: GoogleFonts.publicSans(
//                                     fontSize: 12.sp,
//                                     fontWeight: FontWeight.bold,
//                                     color: AppColors.white,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             SizedBox(height: 10.h),
//                             Text(
//                               'AVAILABLE ON A WEEKLY / MONTHLY BASIS',
//                               style: GoogleFonts.publicSans(
//                                 fontSize: 12.sp,
//                                 color: AppColors.white,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               );
//             },
//           ),
//         ),
//         SizedBox(height: 10.h),
//         //* Dots indicator
//         Consumer<MenuProvider>(
//           builder: (context, provider, child) => AnimatedSmoothIndicator(
//             activeIndex: provider.subscriptionCurrentIndex,
//             count: provider.banners.length,
//             effect: WormEffect(
//               dotHeight: 7,
//               dotWidth: 7,
//               spacing: 5.w,
//               activeDotColor: getColorAccountType(
//                 accountType: accountType,
//                 businessColor: AppColors.primaryColor,
//                 personalColor: AppColors.darkGreenGrey,
//               ),
//               dotColor: getColorAccountType(
//                 accountType: accountType,
//                 businessColor: AppColors.primaryColor.withOpacity(0.5),
//                 personalColor: AppColors.darkGreenGrey.withOpacity(0.5),
//               ),
//             ),
//           ),
//         ),
//         SizedBox(height: 10.h),
//       ],
//     );
//   }
// }
