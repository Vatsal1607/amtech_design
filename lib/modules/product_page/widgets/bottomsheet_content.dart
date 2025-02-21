import 'package:amtech_design/core/utils/constant.dart';
import 'package:amtech_design/core/utils/enums/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:readmore/readmore.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/strings.dart';
import '../../../custom_widgets/svg_icon.dart';
import '../../../models/menu_details_model.dart';

class BottomsheetContent extends StatelessWidget {
  final String accountType;
  final MenuDetailsModel? menuDetails;
  const BottomsheetContent({
    super.key,
    required this.accountType,
    this.menuDetails,
  });

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>? ??
            {};
    final detailsType = args['detailsType'];
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
                // 'Masala Tea',
                '${menuDetails?.data?.itemName}',
                style: GoogleFonts.publicSans(
                    color: getColorAccountType(
                      accountType: accountType,
                      businessColor: AppColors.primaryColor,
                      personalColor: AppColors.darkGreenGrey,
                    ),
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold),
              ),
              Container(
                padding: EdgeInsets.all(5.w),
                decoration: BoxDecoration(
                  color: AppColors.lightGreen,
                  borderRadius: BorderRadius.circular(10.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      offset: const Offset(0, 4),
                      blurRadius: 8,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Text(
                      '${menuDetails?.data?.ratings ?? ''} ',
                      style: GoogleFonts.publicSans(
                        color: AppColors.seaShell,
                        fontSize: 13.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SvgIcon(icon: IconStrings.ratings),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 10.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //* Conditional Row: details || subscription
              if (detailsType == DetailsType.details.name)
                Row(
                  children: [
                    SvgIcon(
                      icon: IconStrings.time,
                      color: getColorAccountType(
                        accountType: accountType,
                        businessColor: AppColors.disabledColor,
                        personalColor: AppColors.bayLeaf,
                      ),
                    ),
                    RichText(
                      maxLines: 1,
                      overflow: TextOverflow.clip,
                      text: TextSpan(
                        text: 'Avg. ',
                        style: GoogleFonts.publicSans(
                          fontSize: 14.sp,
                          color: getColorAccountType(
                            accountType: accountType,
                            businessColor: AppColors.primaryColor,
                            personalColor: AppColors.darkGreenGrey,
                          ),
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: '15 Minutes',
                            style: GoogleFonts.publicSans(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                              color: getColorAccountType(
                                accountType: accountType,
                                businessColor: AppColors.primaryColor,
                                personalColor: AppColors.darkGreenGrey,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              if (detailsType == DetailsType.subscription.name)
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        vertical: 4.h,
                        horizontal: 7.w,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.lightGreen,
                        borderRadius: BorderRadius.circular(30.r),
                      ),
                      child: Text(
                        'CLASSIC',
                        style: GoogleFonts.publicSans(
                          fontWeight: FontWeight.bold,
                          fontSize: 11.sp,
                          color: getColorAccountType(
                            accountType: accountType,
                            businessColor: AppColors.seaShell,
                            personalColor: AppColors.seaMist,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 5.w),
                    Container(
                      padding: EdgeInsets.symmetric(
                        vertical: 4.h,
                        horizontal: 7.w,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.disabledColor,
                        borderRadius: BorderRadius.circular(30.r),
                      ),
                      child: Text(
                        'REGULAR',
                        style: GoogleFonts.publicSans(
                          fontWeight: FontWeight.bold,
                          fontSize: 11.sp,
                          color: getColorAccountType(
                            accountType: accountType,
                            businessColor: AppColors.seaShell,
                            personalColor: AppColors.seaMist,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 5.w),
                    Text(
                      '350 ML',
                      style: GoogleFonts.publicSans(
                        fontSize: 11.sp,
                        fontWeight: FontWeight.bold,
                        color: getColorAccountType(
                          accountType: accountType,
                          businessColor: AppColors.primaryColor,
                          personalColor: AppColors.darkGreenGrey,
                        ),
                      ),
                    ),
                    SizedBox(width: 5.w),
                    const SvgIcon(
                      icon: IconStrings.rupeeFilled,
                      color: AppColors.disabledColor,
                    ),
                    SizedBox(width: 3.w),
                    Text(
                      '2,199',
                      style: GoogleFonts.publicSans(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                        color: getColorAccountType(
                          accountType: accountType,
                          businessColor: AppColors.primaryColor,
                          personalColor: AppColors.darkGreenGrey,
                        ),
                      ),
                    ),
                  ],
                )
              // * Ratings
              // Row(
              //   children: [
              //     SvgIcon(
              //       icon: IconStrings.ratingsPerson,
              //       color: getColorAccountType(
              //         accountType: accountType,
              //         businessColor: AppColors.disabledColor,
              //         personalColor: AppColors.bayLeaf,
              //       ),
              //     ),
              //     RichText(
              //       maxLines: 1,
              //       overflow: TextOverflow.clip,
              //       text: TextSpan(
              //         text: '1.5K ',
              //         style: GoogleFonts.publicSans(
              //           fontSize: 14.sp,
              //           fontWeight: FontWeight.bold,
              //           color: getColorAccountType(
              //             accountType: accountType,
              //             businessColor: AppColors.primaryColor,
              //             personalColor: AppColors.darkGreenGrey,
              //           ),
              //         ),
              //         children: <TextSpan>[
              //           TextSpan(
              //             text: 'Ratings',
              //             style: GoogleFonts.publicSans(
              //               fontSize: 14.sp,
              //               color: getColorAccountType(
              //                 accountType: accountType,
              //                 businessColor: AppColors.primaryColor,
              //                 personalColor: AppColors.darkGreenGrey,
              //               ),
              //             ),
              //           ),
              //         ],
              //       ),
              //     ),
              //   ],
              // ),
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
                color: getColorAccountType(
                  accountType: accountType,
                  businessColor: AppColors.primaryColor,
                  personalColor: AppColors.darkGreenGrey,
                ),
              ),
            ),
          ),
          SizedBox(height: 10.h),
          Padding(
            padding: EdgeInsets.only(bottom: 5.h),
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: ReadMoreText(
                    '${menuDetails?.data?.description}',
                    textAlign: TextAlign.justify,
                    trimLines:
                        5, // Number of lines to display before truncating
                    colorClickableText: getColorAccountType(
                      accountType: accountType,
                      businessColor: AppColors.primaryColor,
                      personalColor: AppColors.darkGreenGrey,
                    ),
                    trimMode: TrimMode.Line,
                    trimCollapsedText: 'Read More',
                    trimExpandedText: 'Read Less',
                    delimiter: '    ',
                    // isCollapsed: (collapsed){
                    // },
                    style: GoogleFonts.publicSans(
                      color: getColorAccountType(
                        accountType: accountType,
                        businessColor: AppColors.primaryColor,
                        personalColor: AppColors.darkGreenGrey,
                      ),
                      fontSize: 14.sp,
                    ),
                    moreStyle: GoogleFonts.publicSans(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                      color: getColorAccountType(
                        accountType: accountType,
                        businessColor: AppColors.primaryColor,
                        personalColor: AppColors.darkGreenGrey,
                      ),
                    ),
                    lessStyle: GoogleFonts.publicSans(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                      color: getColorAccountType(
                        accountType: accountType,
                        businessColor: AppColors.primaryColor,
                        personalColor: AppColors.darkGreenGrey,
                      ),
                    ),
                  ),
                ),
                // * Overlay gradient effect
                // Positioned(
                //   bottom: 0,
                //   left: 0,
                //   right: 0,
                //   height: 30.h,
                //   child: IgnorePointer(
                //     child: Container(
                //       decoration: BoxDecoration(
                //         gradient: LinearGradient(
                //           begin: Alignment.topCenter,
                //           end: Alignment.bottomCenter,
                //           colors: [
                //             // * color 1
                //             getColorAccountType(
                //                 accountType: accountType,
                //                 businessColor:
                //                     AppColors.seaShell.withOpacity(0.0),
                //                 personalColor:
                //                     AppColors.seaMist.withOpacity(0.0)),
                //             // * color 2
                //             getColorAccountType(
                //                 accountType: accountType,
                //                 businessColor:
                //                     AppColors.seaShell.withOpacity(0.8),
                //                 personalColor:
                //                     AppColors.seaMist.withOpacity(0.8)),
                //           ],
                //         ),
                //       ),
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
          SizedBox(height: 15.h),

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
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              '${menuDetails?.data?.ingredients}',
              style: GoogleFonts.publicSans(
                height: 1.h,
                fontSize: 14.sp,
                color: AppColors.primaryColor,
              ),
            ),
          ),
          // ListView.builder(
          //   padding: EdgeInsets.zero, // Remove extra space from top in listview
          //   shrinkWrap: true,
          //   itemCount: 4,
          //   physics: const NeverScrollableScrollPhysics(),
          //   itemBuilder: (context, index) {
          //     return const Padding(
          //       padding: EdgeInsets.all(0),
          //       child: IngredientText(
          //         text: 'Lorem ipsum dolor sit amet',
          //       ),
          //     );
          //   },
          // ),
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
