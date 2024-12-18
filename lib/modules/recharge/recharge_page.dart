import 'package:amtech_design/core/utils/constant.dart';
import 'package:amtech_design/custom_widgets/custom_button.dart';
import 'package:amtech_design/custom_widgets/custom_textfield.dart';
import 'package:amtech_design/custom_widgets/perks_chart_bottom_sheet.dart';
import 'package:amtech_design/modules/razorpay/razorpay_page.dart';
import 'package:amtech_design/modules/recharge/recharge_provider.dart';
import 'package:amtech_design/modules/recharge/widgets/recharge_history_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import '../../core/utils/app_colors.dart';
import '../../core/utils/strings.dart';
import '../../core/utils/validator.dart';
import '../../custom_widgets/appbar/custom_appbar_with_center_title.dart';
import '../../routes.dart';

class RechargePage extends StatefulWidget {
  const RechargePage({super.key});

  @override
  State<RechargePage> createState() => _RechargePageState();
}

class _RechargePageState extends State<RechargePage> {
  late RechargeProvider provider;
  late Razorpay razorpay;

  @override
  void initState() {
    super.initState();
    provider = Provider.of<RechargeProvider>(context, listen: false);
    razorpay = Razorpay();
    provider.amountController.addListener(() {
      provider.formatIndianNumber(provider.amountController.text);
    });

    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, (response) {
      provider.handlePaymentSuccess(context, response);
    });
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, (response) {
      provider.handlePaymentError(context, response);
    });
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, (response) {
      provider.handleExternalWallet(context, response);
    });
  }

  @override
  void dispose() {
    super.dispose();
    // provider.amountController.dispose();
    razorpay.clear(); // Removes all event listeners
  }

  @override
  Widget build(BuildContext context) {
    String accountType = 'business'; // Todo imp set dynamic
    // sharedPrefsService.getString(SharedPrefsKeys.accountType) ?? '';
    // final provider = Provider.of<RechargeProvider>(context, listen: false);
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
                    cursorColor: AppColors.primaryColor,
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
                SizedBox(height: 5.h),
                Padding(
                  padding: EdgeInsets.only(left: 8.w),
                  child: Text(
                    'Available Balance: 11'.toUpperCase(),
                    style: GoogleFonts.publicSans(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.black,
                    ),
                  ),
                ),
                SizedBox(height: 15.h),
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
                Consumer<RechargeProvider>(
                  builder: (context, _, child) => CustomButton(
                    height: 55.h,
                    isLoading: provider.isLoading,
                    onTap: () {
                      if (provider.formKey.currentState!.validate()) {
                        // * userRecharge API * open Razorpay on success
                        provider.userRecharge(context).then((isSuccess) {
                          if (isSuccess != null && isSuccess) {
                            openRazorpay();
                            debugPrint('isSuccess callback api-——: $isSuccess');
                          } else {
                            debugPrint('isSuccess callback api-——: $isSuccess');
                          }
                        });
                      } else {
                        debugPrint('INVALID Amount');
                      }
                    },
                    text: 'recharge',
                    textColor: AppColors.seaShell,
                    bgColor: AppColors.primaryColor,
                  ),
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

  // * Open razorpay
  void openRazorpay() {
    final cleanValue = provider.amountController.text.replaceAll(',', '');
    var options = {
      'key': 'rzp_test_gvsZVEPcujnlQ5', // Replace with your Razorpay Test Key
      // 'key': 'rzp_live_YbWaocbWfEYdCO', // Live key
      'amount': int.parse(cleanValue) * 100,
      'currency': 'INR',
      'order_id': provider.razorpayOrderId,
      'name': 'AMTech Design',
      'description': 'Payment for Order #1234',
      'prefill': {
        'contact': '9876543210',
        'email': 'customer@example.com',
      },
      'external': {
        'wallets': ['paytm'], // Optional: Enable external wallets like PayTM
      }
    };

    try {
      razorpay.open(options);
    } catch (e) {
      debugPrint('Error: $e');
    }
  }
}
