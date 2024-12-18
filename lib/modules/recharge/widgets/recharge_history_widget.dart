import 'package:amtech_design/custom_widgets/svg_icon.dart';
import 'package:dotted_dashed_line/dotted_dashed_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/constant.dart';
import '../../../core/utils/strings.dart';
import 'recharge_history_value.dart';

class RechargeHistoryWidget extends StatelessWidget {
  const RechargeHistoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Divider(
                  color: AppColors.primaryColor.withOpacity(.5),
                  thickness: 2,
                  endIndent: 8,
                ),
              ),
              Text(
                'Recharge History',
                style: GoogleFonts.publicSans(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryColor,
                ),
              ),
              Expanded(
                child: Divider(
                  color: AppColors.primaryColor.withOpacity(.5),
                  thickness: 2,
                  indent: 8,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 16.h),
        // * New table headers
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 2,
              child: Text(
                "DATE",
                style: kRechargeTableHeaderStyle,
              ),
            ),
            Expanded(
              flex: 2,
              child: Center(
                  child: Text("AMOUNT", style: kRechargeTableHeaderStyle)),
            ),
            Expanded(
              flex: 1,
              child: Center(
                  child: Text("STATUS", style: kRechargeTableHeaderStyle)),
            ),
            Expanded(
              flex: 1,
              child: Align(
                  alignment: Alignment.centerRight,
                  child: Text("PERKS", style: kRechargeTableHeaderStyle)),
            ),
          ],
        ),
        SizedBox(height: 8.h),
        // * List Items
        ListView.separated(
          shrinkWrap: true,
          physics: const ClampingScrollPhysics(),
          itemCount: 4,
          separatorBuilder: (context, index) => Column(
            children: [
              SizedBox(height: 12.h),
              DottedDashedLine(
                dashWidth: 10.w,
                height: 16.h,
                axis: Axis.horizontal,
                width: double.infinity,
                dashColor: AppColors.primaryColor.withOpacity(.5),
              ),
            ],
          ),
          itemBuilder: (context, index) {
            return const RechargeHistoryValue(
              date: '9/12/2024',
              amount: '₹ 500',
              perks: '₹ 10',
              isSuccess: true,
            );
          },
        ),
      ],
    );
  }
}
