import 'package:amtech_design/core/utils/constant.dart';
import 'package:amtech_design/core/utils/strings.dart';
import 'package:amtech_design/custom_widgets/svg_icon.dart';
import 'package:amtech_design/modules/subscriptions/create_subscription_plan/select_meal_bottomsheet/select_meal_bottomsheet.dart';
import 'package:amtech_design/modules/subscriptions/subscription/subscription_details/subscription_details_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../../../core/utils/app_colors.dart';

class ItemDetailsWidget extends StatelessWidget {
  final String accountType;
  const ItemDetailsWidget({super.key, required this.accountType});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: getColorAccountType(
          accountType: accountType,
          businessColor: AppColors.primaryColor,
          personalColor: AppColors.darkGreenGrey,
        ),
        borderRadius: BorderRadius.circular(32.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Consumer<SubscriptionDetailsProvider>(
            builder: (context, provider, child) => _buildRichText(
              "Items",
              "${provider.dayDetailsRes?.quantity}x ${provider.dayDetailsRes?.itemName}",
            ),
          ),
          SizedBox(height: 8.h),
          Consumer<SubscriptionDetailsProvider>(
            builder: (context, provider, child) => _buildRichText(
              "Add-Ons",
              "${provider.dayDetailsRes?.quantity}x ${provider.dayDetailsRes?.addOns?.first.name}",
            ),
          ),
          SizedBox(height: 8.h),
          Consumer<SubscriptionDetailsProvider>(
            builder: (context, provider, child) => _buildRichText(
              "Ingredients",
              "${provider.dayDetailsRes?.ingredients?.first.ingreName}",
            ),
          ),
          SizedBox(height: 10.h),
          Divider(
            thickness: 1.5.w,
            color: getColorAccountType(
              accountType: accountType,
              businessColor: AppColors.seaShell,
              personalColor: AppColors.seaMist,
            ),
          ),
          SizedBox(height: 5.h),
          GestureDetector(
            onTap: () {
              // Todo Add isModify flag for future handle
              showSelectMealBottomSheeet(
                context: context,
                accountType: accountType,
                // day: day,
                // mealIndex: mealIndex,
              );
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: getColorAccountType(
                  accountType: accountType,
                  businessColor: AppColors.seaShell,
                  personalColor: AppColors.seaMist,
                ),
                borderRadius: BorderRadius.circular(30.r),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgIcon(
                    icon: IconStrings.modify,
                    color: getColorAccountType(
                      accountType: accountType,
                      businessColor: AppColors.disabledColor,
                      personalColor: AppColors.bayLeaf,
                    ),
                  ),
                  SizedBox(width: 5.w),
                  Text(
                    'MODIFY',
                    style: GoogleFonts.publicSans(
                      color: getColorAccountType(
                        accountType: accountType,
                        businessColor: AppColors.primaryColor,
                        personalColor: AppColors.darkGreenGrey,
                      ),
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRichText(String label, String value) {
    return RichText(
      text: TextSpan(
        style: GoogleFonts.publicSans(
          fontSize: 16.sp,
          color: getColorAccountType(
            accountType: accountType,
            businessColor: AppColors.disabledColor,
            personalColor: AppColors.bayLeaf,
          ),
        ),
        children: [
          TextSpan(text: '$label : '),
          TextSpan(
            text: value,
            style: GoogleFonts.publicSans(
              color: getColorAccountType(
                accountType: accountType,
                businessColor: AppColors.seaShell,
                personalColor: AppColors.seaMist,
              ),
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
