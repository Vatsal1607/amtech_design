import 'package:flutter/material.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/constant.dart';

class RechargeHistoryValue extends StatelessWidget {
  final String date;
  final String amount;
  final String perks;
  final Color iconColor;
  final bool isSuccess;
  final String accountType;
  const RechargeHistoryValue({
    super.key,
    required this.date,
    required this.amount,
    required this.perks,
    this.iconColor = AppColors.lightGreen,
    this.isSuccess = true,
    required this.accountType,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              date,
              style: kRechargeTableValueStyle?.copyWith(
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
          flex: 2,
          child: Center(
            child: Text(
              amount,
              style: kRechargeTableValueStyle?.copyWith(
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
            child: Icon(
              isSuccess ? Icons.check_circle : Icons.cancel_rounded,
              color: isSuccess ? Colors.green : Colors.red,
              size: 22,
            ),
          ),
        ),
        // Perks Column: Align Right
        Expanded(
          flex: 1,
          child: Align(
            alignment: Alignment.centerRight,
            child: Text(
              perks,
              style: kRechargeTableValueStyle?.copyWith(
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
    );
  }
}
