import 'package:amtech_design/core/utils/constant.dart';
import 'package:amtech_design/core/utils/constants/keys.dart';
import 'package:amtech_design/services/local/shared_preferences_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/utils.dart';
import '../../../../models/subs_list_model.dart';
import '../../../../routes.dart';

class SubscriptionCardWidget extends StatelessWidget {
  final bool isExpired;
  final SubsItems item;
  const SubscriptionCardWidget({
    super.key,
    this.isExpired = false,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    final String accountType =
        sharedPrefsService.getString(SharedPrefsKeys.accountType) ?? '';
    return Opacity(
      opacity: isExpired ? 0.5 : 1.0,
      child: GestureDetector(
        onTap: isExpired
            ? null
            : () {
                Navigator.pushNamed(
                  context,
                  Routes.subscriptonDetailsPage,
                  arguments: {
                    'subsId': item.sId,
                  },
                );
              },
        child: Container(
          decoration: BoxDecoration(
            color: getColorAccountType(
              accountType: accountType,
              businessColor: AppColors.primaryColor,
              personalColor: AppColors.darkGreenGrey,
            ),
            borderRadius: BorderRadius.circular(40.r),
          ),
          padding: EdgeInsets.symmetric(vertical: 20.w, horizontal: 25.h),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      //* Item name
                      '${item.items?.first.itemName}',
                      style: GoogleFonts.publicSans(
                        fontSize: 22.sp,
                        color: getColorAccountType(
                          accountType: accountType,
                          businessColor: AppColors.seaShell,
                          personalColor: AppColors.seaMist,
                        ),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 12.h),
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 10.w,
                            vertical: 4.h,
                          ),
                          decoration: BoxDecoration(
                            color: getColorAccountType(
                                accountType: accountType,
                                businessColor:
                                    AppColors.disabledColor.withOpacity(0.5),
                                personalColor:
                                    AppColors.bayLeaf.withOpacity(0.5)),
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                          child: Text(
                            // '${item.units} UNITS',
                            "${item.units} ${item.units == '1' ? 'UNIT' : 'UNITS'}",
                            style: GoogleFonts.publicSans(
                              color: getColorAccountType(
                                accountType: accountType,
                                businessColor: AppColors.seaShell,
                                personalColor: AppColors.seaMist,
                              ),
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1,
                            ),
                          ),
                        ),
                        SizedBox(width: 10.w),
                        Text(
                          '₹${item.price}',
                          style: GoogleFonts.publicSans(
                            color: getColorAccountType(
                              accountType: accountType,
                              businessColor: AppColors.seaShell,
                              personalColor: AppColors.seaMist,
                            ),
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 12.h),
                    Row(
                      children: [
                        Text(
                          'SUBSCRIBED ON ',
                          style: GoogleFonts.publicSans(
                            color: getColorAccountType(
                              accountType: accountType,
                              businessColor: AppColors.disabledColor,
                              personalColor: AppColors.bayLeaf,
                            ),
                            fontSize: 14.sp,
                          ),
                        ),
                        Text(
                          item.createdAt != null
                              ? '${Utils.formatSubscriptionDate(item.createdAt!)}'
                              : '',
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.publicSans(
                            color: getColorAccountType(
                              accountType: accountType,
                              businessColor: AppColors.disabledColor,
                              personalColor: AppColors.bayLeaf,
                            ),
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
