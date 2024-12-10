import 'package:amtech_design/modules/product_page/widgets/ingredient_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:readmore/readmore.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/strings.dart';
import '../../../custom_widgets/svg_icon.dart';

class BottomsheetContent extends StatelessWidget {
  const BottomsheetContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 20.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Masala Tea',
                style: GoogleFonts.publicSans(
                    color: AppColors.primaryColor,
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold),
              ),
              Container(
                padding:  EdgeInsets.all(5.w),
                decoration: BoxDecoration(
                  color: AppColors.lightGreen,
                  borderRadius: BorderRadius.circular(10.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black
                          .withOpacity(0.2), // Shadow color with opacity
                      offset:
                          const Offset(0, 4), // Horizontal and vertical offsets
                      blurRadius: 8, // Blur radius for softness
                      spreadRadius: 2, // Spread radius for shadow expansion
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Text(
                      '4.5 ',
                      style: GoogleFonts.publicSans(
                        color: AppColors.white,
                        fontSize: 13.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SvgIcon(icon: IconStrings.ratings),
                  ],
                ),
              ),
            ],
          ),
           SizedBox(height: 10.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SvgIcon(
                    icon: IconStrings.time,
                    color: AppColors.disabledColor,
                  ),
                  RichText(
                    maxLines: 1,
                    overflow: TextOverflow.clip,
                    text: TextSpan(
                      text: 'Avg. ',
                      style: GoogleFonts.publicSans(
                        fontSize: 14.sp,
                        color: AppColors.primaryColor,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: '15 Minutes',
                          style: GoogleFonts.publicSans(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  SvgIcon(
                    icon: IconStrings.ratingsPerson,
                    color: AppColors.disabledColor,
                  ),
                  RichText(
                    maxLines: 1,
                    overflow: TextOverflow.clip,
                    text: TextSpan(
                      text: '1.5K ',
                      style: GoogleFonts.publicSans(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryColor,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Ratings',
                          style: GoogleFonts.publicSans(
                            fontSize: 14.sp,
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
           SizedBox(height: 17.h),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Description'.toUpperCase(),
              style: GoogleFonts.publicSans(
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryColor,
              ),
            ),
          ),
          SizedBox(height: 10.h),
          Padding(
            padding:  EdgeInsets.only(bottom: 5.h),
            child: Stack(
              children: [
                ReadMoreText(
                  'Everyday Tea draws from tea\'s rich history, dating back to 2737 BCE in ancient China. Sourced from Assam and Darjeeling, India’s finest tea regions, this blend offers a perfect balance of bold and aromatic flavors. Enjoy a cup steeped in centuries of tradition, bringing',
                  trimLines: 5, // Number of lines to display before truncating
                  colorClickableText: AppColors.primaryColor,
                  trimMode: TrimMode.Line,
                  trimCollapsedText: 'Read More',
                  trimExpandedText: 'Read Less',
                  textAlign: TextAlign.justify,
                  delimiter: '    ',
                  // isCollapsed: (collapsed){

                  // },
                  style: TextStyle(
                    color: AppColors.primaryColor,
                    fontSize: 14.sp,
                  ),
                  moreStyle: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryColor,
                  ),
                  lessStyle: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryColor,
                  ),
                ),
                // Overlay gradient effect
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  height: 30.h,
                  child: IgnorePointer(
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            AppColors.seaShell.withOpacity(0.0), // Transparent
                            AppColors.seaShell
                                .withOpacity(0.8), // Fade to background color
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 15.h),

          // // Size Widget
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     const SizeWidget(
          //       text: 'S',
          //     ),
          //     const SizeWidget(
          //       text: 'M',
          //       bgColor: AppColors.disabledColor,
          //     ),
          //     SizeWidget(
          //       text: 'L',
          //       bgColor: AppColors.disabledColor.withOpacity(.4),
          //       borderColor: AppColors.primaryColor.withOpacity(.4),
          //     ),
          //   ],
          // ),

          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'ingredients'.toUpperCase(),
              style: GoogleFonts.publicSans(
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryColor,
              ),
            ),
          ),
          SizedBox(height: 10.h),

          ListView.builder(
            padding: EdgeInsets.zero, // Remove extra space from top in listview
            shrinkWrap: true,
            itemCount: 4,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return const Padding(
                padding: EdgeInsets.all(0),
                child: IngredientText(
                  text: 'Lorem ipsum dolor sit amet',
                ),
              );
            },
          ),
          SizedBox(height: 30.h),
          SvgIcon(
            icon: IconStrings.hygiene,
            color: AppColors.disabledColor.withOpacity(0.5),
          ),
          Text(
            'hygiene first'.toUpperCase(),
            style: GoogleFonts.publicSans(
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryColor.withOpacity(0.5),
            ),
          ),
          SizedBox(height: 10.h),
          Text(
            'We serve our Products with hygiene'.toUpperCase(),
            style: GoogleFonts.publicSans(
              fontSize: 10.sp,
              color: AppColors.primaryColor.withOpacity(0.5),
            ),
          ),

          // AddToCart Button
          // GestureDetector(
          //   onTap: () {
          //     //
          //   },
          //   child: Container(
          //     height: 55.h,
          //     width: double.infinity,
          //     decoration: BoxDecoration(
          //       color: AppColors.primaryColor,
          //       borderRadius: BorderRadius.circular(40.0),
          //     ),
          //     child: Center(
          //       child: Text(
          //         'ADD TO CART',
          //         style: GoogleFonts.publicSans(
          //           fontSize: 16.0,
          //           fontWeight: FontWeight.bold,
          //           color: AppColors.seaShell,
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
          SizedBox(height: 200.h),
        ],
      ),
    );
  }
}
