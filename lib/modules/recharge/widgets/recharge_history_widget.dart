import 'dart:developer';
import 'package:amtech_design/modules/recharge/recharge_provider.dart';
import 'package:dotted_dashed_line/dotted_dashed_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/constant.dart';
import '../../../core/utils/utils.dart';
import 'center_title_with_divider.dart';
import 'recharge_history_value.dart';

class RechargeHistoryWidget extends StatelessWidget {
  final String accountType;
  final RechargeProvider provider;
  const RechargeHistoryWidget({
    super.key,
    required this.accountType,
    required this.provider,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        //* Title with divider
        CenterTitleWithDivider(
          accountType: accountType,
          title: 'Recharge History',
        ),

        SizedBox(height: 16.h),
        // * Table Header
        if (provider.paymentHistoryList != null &&
            provider.paymentHistoryList!.isNotEmpty)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 2,
                child: Text(
                  "DATE",
                  style: kRechargeTableHeaderStyle?.copyWith(
                    color: getColorAccountType(
                      accountType: accountType,
                      businessColor: AppColors.primaryColor,
                      personalColor: AppColors.darkGreenGrey,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Center(
                  child: Text(
                    "AMOUNT",
                    style: kRechargeTableHeaderStyle?.copyWith(
                      color: getColorAccountType(
                        accountType: accountType,
                        businessColor: AppColors.primaryColor,
                        personalColor: AppColors.darkGreenGrey,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Center(
                  child: Text(
                    "STATUS",
                    style: kRechargeTableHeaderStyle?.copyWith(
                      color: getColorAccountType(
                        accountType: accountType,
                        businessColor: AppColors.primaryColor,
                        personalColor: AppColors.darkGreenGrey,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    "PERKS",
                    style: kRechargeTableHeaderStyle?.copyWith(
                      color: getColorAccountType(
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
        SizedBox(height: 8.h),

        // * List Items
        Consumer<RechargeProvider>(builder: (context, provider, child) {
          final list = provider.paymentHistoryList;
          if (list == null || list.isEmpty) {
            return Center(
              child: Text(
                'No recharge history available.',
                style: GoogleFonts.publicSans(
                  fontSize: 20.sp,
                  color: getColorAccountType(
                    accountType: accountType,
                    businessColor: AppColors.primaryColor,
                    personalColor: AppColors.darkGreenGrey,
                  ),
                  fontWeight: FontWeight.w500,
                ),
              ),
            );
          }
          return ListView.separated(
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            itemCount: provider.paymentHistoryList?.length ?? 0,
            separatorBuilder: (context, index) => Column(
              children: [
                SizedBox(height: 12.h),
                DottedDashedLine(
                  dashWidth: 10.w,
                  height: 16.h,
                  axis: Axis.horizontal,
                  width: double.infinity,
                  dashColor: getColorAccountType(
                    accountType: accountType,
                    businessColor: AppColors.primaryColor.withOpacity(.5),
                    personalColor: AppColors.darkGreenGrey.withOpacity(.5),
                  ),
                ),
              ],
            ),
            itemBuilder: (context, index) {
              final paymentHistory = provider.paymentHistoryList?[index];
              return RechargeHistoryValue(
                accountType: accountType,
                date: Utils.formatDateToDDMMYYYY(
                    '${paymentHistory?.transactionDate}'),
                amount: '₹ ${paymentHistory?.rechargeAmount}',
                perks: '₹ ${paymentHistory?.perks}',
                isSuccess: true,
              );
            },
          );
        }),
      ],
    );
  }
}
