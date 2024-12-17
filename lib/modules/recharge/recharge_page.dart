import 'package:amtech_design/core/utils/constant.dart';
import 'package:amtech_design/custom_widgets/custom_button.dart';
import 'package:amtech_design/custom_widgets/custom_textfield.dart';
import 'package:amtech_design/custom_widgets/perks_chart_bottom_sheet.dart';
import 'package:amtech_design/modules/recharge/recharge_provider.dart';
import 'package:amtech_design/modules/recharge/widgets/recharge_history_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import '../../core/utils/app_colors.dart';
import '../../core/utils/strings.dart';
import '../../core/utils/validator.dart';
import '../../custom_widgets/appbar/custom_appbar_with_center_title.dart';

class RechargePage extends StatelessWidget {
  const RechargePage({super.key});

  @override
  Widget build(BuildContext context) {
    String accountType = 'business'; // Todo imp set dynamic
    // sharedPrefsService.getString(SharedPrefsKeys.accountType) ?? '';
    final provider = Provider.of<RechargeProvider>(context, listen: false);
    return Scaffold(
      appBar: CustomAppbarWithCenterTitle(
        title: 'Recharge',
        isAction: true,
        onTapAction: () {
          // * Show Perks chart
          showPerksChartBottomSheeet(
            context: context,
            accountType: accountType,
          );
        },
      ),
      body: SingleChildScrollView(
        child: Form(
          key: provider.formKey,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 23.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Consumer<RechargeProvider>(
                  builder: (context, _, child) => CustomTextField(
                    hint: 'Enter Amount',
                    validator: Validator.rechargeAmountValidator,
                    textColor: AppColors.primaryColor,
                    borderColor: AppColors.primaryColor,
                    iconColor: AppColors.primaryColor,
                    prefixIcon: IconStrings.rupee,
                    controller: provider.amountController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(5), // Max 5 digits
                    ],
                  ),
                ),
                SizedBox(height: 23.h),
                Text(
                  'Note:',
                  style: GoogleFonts.publicSans(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryColor,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      'You Can Recharge ',
                      style: GoogleFonts.publicSans(
                        fontSize: 12.sp,
                        color: AppColors.primaryColor,
                      ),
                    ),
                    Text(
                      'Minimum ₹500 Upto ₹50,000 ',
                      style: GoogleFonts.publicSans(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryColor,
                      ),
                    ),
                    Text(
                      'At Once.',
                      style: GoogleFonts.publicSans(
                        fontSize: 12.sp,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 23.h),
                CustomButton(
                  height: 55.h,
                  onTap: () {
                    if (provider.formKey.currentState!.validate()) {
                      debugPrint('VALID Amount');
                    } else {
                      debugPrint('INVALID Amount');
                    }
                  },
                  text: 'recharge',
                  textColor: AppColors.seaShell,
                  bgColor: AppColors.primaryColor,
                ),
                SizedBox(height: 23.h),
                // * RechargeHistoryWidget
                RechargeHistoryWidget(),
                //! Temp Lottie file
                // Lottie.asset(LottieStrings.orderConfirm),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
