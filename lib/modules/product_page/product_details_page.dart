import 'package:amtech_design/core/utils/constant.dart';
import 'package:amtech_design/custom_widgets/appbar/custom_appbar.dart';
import 'package:amtech_design/custom_widgets/svg_icon.dart';
import 'package:amtech_design/modules/product_page/widgets/bottomsheet_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/utils/app_colors.dart';
import '../../core/utils/strings.dart';

class ProductPage extends StatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const ProductPage(),
      );
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  // // Bottom sheet
  // void _showScrollableBottomSheet() {
  //   showModalBottomSheet(
  //     context: context,
  //     isScrollControlled: true, // Allows the BottomSheet to take more space
  //     backgroundColor: Colors.transparent, // transparent for full effect
  //     barrierColor: Colors.transparent, // Prevent dimming of background
  //     isDismissible: false,
  //     builder: (BuildContext context) {
  //       return DraggableScrollableSheet(
  //         initialChildSize: 0.6, // Initial height of BottomSheet
  //         minChildSize: 0.6, // Minimum height of BottomSheet
  //         maxChildSize: 0.8, // Maximum height of BottomSheet
  //         expand: true,
  //         shouldCloseOnMinExtent: false,
  //         builder: (BuildContext context, ScrollController scrollController) {
  //           return Container(
  //             decoration: const BoxDecoration(
  //               color: AppColors.seaShell,
  //               borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
  //             ),
  //             child: Column(
  //               children: [
  //                 // Handle to indicate dragging
  //                 Container(
  //                   width: 40,
  //                   height: 6,
  //                   margin: const EdgeInsets.only(top: 8),
  //                   decoration: BoxDecoration(
  //                     color: Colors.grey[300],
  //                     borderRadius: BorderRadius.circular(3),
  //                   ),
  //                 ),
  //                 Expanded(
  //                   // Content goes here
  //                   child: Stack(
  //                     children: [
  //                       SingleChildScrollView(
  //                         controller: scrollController,
  //                         child: const BottomsheetContent(),
  //                       ),
  //                       Positioned(
  //                         bottom: 50.h,
  //                         left: 0,
  //                         right: 0,
  //                         child: GestureDetector(
  //                           onTap: () {
  //                             //
  //                           },
  //                           child: Container(
  //                             height: 55.h,
  //                             width: double.infinity,
  //                             margin: EdgeInsets.symmetric(horizontal: 34.w),
  //                             decoration: BoxDecoration(
  //                               color: AppColors.primaryColor,
  //                               borderRadius: BorderRadius.circular(40.0),
  //                             ),
  //                             child: Center(
  //                               child: Text(
  //                                 'ADD TO CART',
  //                                 style: GoogleFonts.publicSans(
  //                                   fontSize: 16.0,
  //                                   fontWeight: FontWeight.bold,
  //                                   color: AppColors.seaShell,
  //                                 ),
  //                               ),
  //                             ),
  //                           ),
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           );
  //         },
  //       );
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   _showScrollableBottomSheet();
    // });
    return Scaffold(
      extendBodyBehindAppBar: true, // Ensures content goes behind the AppBar
      backgroundColor: AppColors.primaryColor,
      appBar: CustomAppBar(
        backgroundColor: Colors.transparent,
        title: '',
        onTapLeading: () {
          debugPrint('details leading pressed');
          Navigator.pop(context);
        },
        leading: Container(
          height: 48.h,
          width: 48.w,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.seaShell,
          ),
          child: ClipOval(
            child: SvgIcon(
              icon: IconStrings.arrowBack,
              color: AppColors.primaryColor,
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
            child: SvgIcon(
              icon: IconStrings.heart,
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          // Top content above the DraggableScrollableSheet
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                decoration: BoxDecoration(
                  boxShadow: const [
                    BoxShadow(
                      color: AppColors.primaryColor, // Shadow color
                      offset: Offset(0, -4), // shadow at the top
                      blurRadius: 10, // Blur effect for a smoother shadow
                    ),
                  ],
                ),
                child: Image.asset(
                  height: 439.h,
                  width: double.infinity,
                  ImageStrings.teaImg,
                  fit: BoxFit.cover,
                ),
              ),
              // Expanded(
              //   child: DraggableScrollableSheet(
              //     initialChildSize: 0.7,
              //     minChildSize: 0.7,
              //     maxChildSize: 0.9,
              //     expand: true, // set true for scrollable sheet itself
              //     builder:
              //         (BuildContext context, ScrollController scrollController) {
              //       return SingleChildScrollView(
              //         controller: scrollController,
              //         child:
              //       );
              //     },
              //   ),
              // ),
            ],
          ),

          // DraggableScrollableSheet at the bottom
          Align(
            alignment: Alignment.bottomCenter,
            child: DraggableScrollableSheet(
              expand: false, // doesn’t take over the entire screen
              initialChildSize: 0.55, // Initial height of BottomSheet
              minChildSize: 0.55, // Minimum height of BottomSheet
              maxChildSize: 0.8, // Maximum height of BottomSheet
              shouldCloseOnMinExtent: false,
              builder: (context, scrollController) {
                return Container(
                  decoration: const BoxDecoration(
                    color: AppColors.seaShell,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(16)),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Handle to indicate dragging
                      Container(
                        width: 40,
                        height: 6,
                        margin: const EdgeInsets.only(top: 8),
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                      Expanded(
                        child: Stack(
                          children: [
                            SingleChildScrollView(
                              controller: scrollController,
                              physics: const ClampingScrollPhysics(),
                              child: const BottomsheetContent(),
                            ),
                            // Add to cart button
                            Positioned(
                              bottom: 50.h,
                              left: 0,
                              right: 0,
                              child: GestureDetector(
                                onTap: () {
                                  //
                                },
                                child: Container(
                                  height: 55.h,
                                  width: double.infinity,
                                  margin:
                                      EdgeInsets.symmetric(horizontal: 34.w),
                                  decoration: BoxDecoration(
                                    color: AppColors.primaryColor,
                                    borderRadius: BorderRadius.circular(40.0),
                                  ),
                                  child: Center(
                                    child: Text(
                                      'ADD TO CART',
                                      style: GoogleFonts.publicSans(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.seaShell,
                                      ),
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
              },
            ),
          ),
        ],
      ),

      /// Old body code
      // body: Column(
      //   mainAxisSize: MainAxisSize.min,
      //   children: [
      //     Image.asset(
      //       height: 439.h,
      //       width: double.infinity,
      //       ImageStrings.teaImg,
      //       fit: BoxFit.cover,
      //     ),
      //     // Expanded(
      //     //   child: DraggableScrollableSheet(
      //     //     initialChildSize: 0.7,
      //     //     minChildSize: 0.7,
      //     //     maxChildSize: 0.9,
      //     //     expand: true, // set true for scrollable sheet itself
      //     //     builder:
      //     //         (BuildContext context, ScrollController scrollController) {
      //     //       return SingleChildScrollView(
      //     //         controller: scrollController,
      //     //         child:
      //     //       );
      //     //     },
      //     //   ),
      //     // ),
      //   ],
      // ),
    );
  }
}
