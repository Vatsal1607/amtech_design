import 'package:amtech_design/core/utils/constant.dart';
import 'package:amtech_design/core/utils/strings.dart';
import 'package:amtech_design/custom_widgets/svg_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../../core/utils/app_colors.dart';
import '../subscription_summary_provider.dart';

class DayWiseDetailsListWidget extends StatelessWidget {
  final String accountType;
  const DayWiseDetailsListWidget({
    super.key,
    required this.provider,
    required this.accountType,
  });

  final SubscriptionSummaryProvider provider;

  @override
  Widget build(BuildContext context) {
    return Consumer<SubscriptionSummaryProvider>(
      builder: (context, provider, child) {
        final groupedData = provider.groupByDay(provider.subsItems ?? []);

        return ListView.builder(
          itemCount: groupedData.length,
          itemBuilder: (context, index) {
            final day = groupedData.keys.elementAt(index);
            final meals = groupedData[day]!;

            return Padding(
              padding: EdgeInsets.only(top: 8.h, left: 10.w, bottom: 10.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    day,
                    style: GoogleFonts.publicSans(
                      fontSize: 20.sp,
                      color: getColorAccountType(
                        accountType: accountType,
                        businessColor: AppColors.seaShell,
                        personalColor: AppColors.seaMist,
                      ),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: meals.length,
                    separatorBuilder: (context, index) =>
                        SizedBox(height: 15.h),
                    itemBuilder: (context, mealIndex) {
                      final meal = meals[mealIndex];
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              SvgIcon(
                                icon: IconStrings.appFill,
                                height: 15.h,
                                color: getColorAccountType(
                                  accountType: accountType,
                                  businessColor: AppColors.disabledColor,
                                  personalColor: AppColors.bayLeaf,
                                ),
                              ),
                              Text(
                                ' ${meal.timeSlot}',
                                style: GoogleFonts.publicSans(
                                  fontSize: 16.sp,
                                  color: getColorAccountType(
                                    accountType: accountType,
                                    businessColor: AppColors.disabledColor,
                                    personalColor: AppColors.bayLeaf,
                                  ),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 15.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${meal.quantity} x ${meal.saladName}',
                                  style: GoogleFonts.publicSans(
                                    fontSize: 16.sp,
                                    color: getColorAccountType(
                                      accountType: accountType,
                                      businessColor: AppColors.disabledColor,
                                      personalColor: AppColors.bayLeaf,
                                    ),
                                  ),
                                ),
                                //* Ingredients
                                Builder(builder: (context) {
                                  // Step 1: Find the SubsItem that contains this meal
                                  final matchingSubsItem =
                                      provider.subsItems?.firstWhere(
                                    (item) =>
                                        item.mealSubscription?.contains(meal) ??
                                        false,
                                  );

                                  // Step 2: Get ingredients from that SubsItem's customize list
                                  final ingredientNames = (matchingSubsItem
                                              ?.customize
                                              ?.expand((custom) =>
                                                  custom.ingredients?.map(
                                                      (ing) => ing.ingreName) ??
                                                  [])
                                              .toList() ??
                                          [])
                                      .cast<String>();

                                  final ingredientsText =
                                      '[ ${ingredientNames.join(', ')} ]';

                                  return Text(
                                    ingredientsText,
                                    style: GoogleFonts.publicSans(
                                      fontSize: 14.sp,
                                      color: getColorAccountType(
                                        accountType: accountType,
                                        businessColor: AppColors.disabledColor,
                                        personalColor: AppColors.bayLeaf,
                                      ),
                                    ),
                                  );
                                }),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  //* OLD UI which shows multiple days (duplicate)
  // @override
  // Widget build(BuildContext context) {
  //   return Consumer<SubscriptionSummaryProvider>(
  //     builder: (context, _, child) => ListView.builder(
  //       itemCount: provider.subsItems?.length ?? 0,
  //       physics: const ClampingScrollPhysics(),
  //       itemBuilder: (context, index) {
  //         final subsDetails = provider.subsItems?[index];
  //         return Padding(
  //           padding: EdgeInsets.only(top: 8.h, left: 10.w, bottom: 10.w),
  //           child: Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               Text(
  //                 // dayData['day'],
  //                 '${subsDetails?.mealSubscription?[0].day}',
  //                 style: GoogleFonts.publicSans(
  //                     fontSize: 20.sp,
  //                     color: getColorAccountType(
  //                       accountType: accountType,
  //                       businessColor: AppColors.seaShell,
  //                       personalColor: AppColors.seaMist,
  //                     ),
  //                     fontWeight: FontWeight.bold),
  //               ),
  //               // Timeslot & itemname [ingredients]
  //               ListView.builder(
  //                 shrinkWrap: true,
  //                 physics: const NeverScrollableScrollPhysics(),
  //                 itemCount:
  //                     provider.subsItems?[index].mealSubscription?.length ?? 0,
  //                 itemBuilder: (context, mealSubsIndex) {
  //                   final mealSubs = provider
  //                       .subsItems?[index].mealSubscription?[mealSubsIndex];
  //                   return Column(
  //                     crossAxisAlignment: CrossAxisAlignment.start,
  //                     children: [
  //                       Row(
  //                         children: [
  //                           SvgIcon(
  //                             icon: IconStrings.appFill,
  //                             height: 15.h,
  //                             color: getColorAccountType(
  //                               accountType: accountType,
  //                               businessColor: AppColors.disabledColor,
  //                               personalColor: AppColors.bayLeaf,
  //                             ),
  //                           ),
  //                           Text(
  //                             ' ${mealSubs?.timeSlot}',
  //                             style: GoogleFonts.publicSans(
  //                                 fontSize: 16.sp,
  //                                 color: getColorAccountType(
  //                                   accountType: accountType,
  //                                   businessColor: AppColors.disabledColor,
  //                                   personalColor: AppColors.bayLeaf,
  //                                 ),
  //                                 fontWeight: FontWeight.bold),
  //                           ),
  //                         ],
  //                       ),
  //                       Padding(
  //                         padding: EdgeInsets.only(left: 15.w),
  //                         child: Column(
  //                           crossAxisAlignment: CrossAxisAlignment.start,
  //                           children: [
  //                             Text(
  //                               '${mealSubs?.quantity} x ${mealSubs?.saladName}',
  //                               style: GoogleFonts.publicSans(
  //                                 fontSize: 16.sp,
  //                                 color: getColorAccountType(
  //                                   accountType: accountType,
  //                                   businessColor: AppColors.disabledColor,
  //                                   personalColor: AppColors.bayLeaf,
  //                                 ),
  //                               ),
  //                             ),
  //                             Builder(builder: (context) {
  //                               List<String> ingredientNames = (provider
  //                                           .summaryRes
  //                                           ?.data
  //                                           ?.items?[index]
  //                                           .customize
  //                                           ?.expand((custom) {
  //                                         return custom.ingredients?.map(
  //                                                 (ing) => ing.ingreName) ??
  //                                             [];
  //                                       }).toList() ??
  //                                       [])
  //                                   .cast<String>();
  //                               String ingredientsText =
  //                                   '[ ${ingredientNames.join(', ')} ]';
  //                               return Text(
  //                                 ingredientsText,
  //                                 style: GoogleFonts.publicSans(
  //                                   fontSize: 14.sp,
  //                                   color: getColorAccountType(
  //                                     accountType: accountType,
  //                                     businessColor: AppColors.disabledColor,
  //                                     personalColor: AppColors.bayLeaf,
  //                                   ),
  //                                 ),
  //                               );
  //                             }),
  //                           ],
  //                         ),
  //                       ),
  //                     ],
  //                   );
  //                 },
  //               )
  //             ],
  //           ),
  //         );
  //       },
  //     ),
  //   );
  // }
}
