import 'dart:developer';

import 'package:amtech_design/models/user_recharge_model.dart';
import 'package:amtech_design/models/verify_recharge_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../../core/utils/app_colors.dart';
import '../../custom_widgets/snackbar.dart';
import '../../models/api_global_model.dart';
import '../../services/network/api_service.dart';

class RechargeProvider extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();
  TextEditingController amountController = TextEditingController();
  final NumberFormat _indianFormat = NumberFormat('#,##,##,###', 'en_IN');

  void formatIndianNumber(String value) {
    if (value.isEmpty) return;

    // Remove any commas before formatting
    String plainNumber = value.replaceAll(',', '');

    // Format the number using Indian Numbering Style
    String formattedNumber =
        _indianFormat.format(int.tryParse(plainNumber) ?? 0);

    // Prevent cursor from jumping
    if (formattedNumber != value) {
      amountController.value = amountController.value.copyWith(
        text: formattedNumber,
        selection: TextSelection.collapsed(offset: formattedNumber.length),
      );
    }
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  final ApiService apiService = ApiService();
  String? razorpayOrderId;
  String? verifyRechargeMsg;

  // * Api method userRecharge
  Future userRecharge(
    BuildContext context,
  ) async {
    _isLoading = true;
    notifyListeners();
    try {
      final cleanValue = amountController.text.replaceAll(',', '');
      final Map<String, dynamic> body = {
        'userId': '6750773be63d357449cb4903',
        'rechargeAmount': int.parse(cleanValue),
      };
      debugPrint('--Request body userRecharge: $body');
      // Make the API call
      final UserRechargeModel response = await apiService.userRecharge(
        body: body,
      );
      log('UserRecharge Response: $response');
      if (response.success == true) {
        log('UserRecharge Response: ${response.message.toString()}');
        if (response.data != null) {
          razorpayOrderId = response.data!.razorpayOrderId;
        }

        return true; // * Indicating success
      } else {
        debugPrint('UserRecharge Response: ${response.message}');
        return false; // * Indicating failure
      }
    } catch (error) {
      log("Error user Recharge: $error");

      if (error is DioException) {
        // Parse API error response
        final apiError = ApiGlobalModel.fromJson(error.response?.data ?? {});
        customSnackBar(
          context: context,
          message: apiError.message ?? 'An error occurred',
          backgroundColor: AppColors.primaryColor,
        );
      } else {
        // Handle unexpected errors
        customSnackBar(
          context: context,
          message: 'An unexpected error occurred',
          backgroundColor: AppColors.primaryColor,
        );
      }
    } finally {
      // Ensure loading state is reset
      _isLoading = false;
      notifyListeners();
    }
  }

  // * Api method verifyRecharge
  Future verifyRecharge(BuildContext context, String paymentId) async {
    _isLoading = true;
    notifyListeners();
    try {
      final cleanValue = amountController.text.replaceAll(',', '');
      final Map<String, dynamic> body = {
        "razorpayOrderId": razorpayOrderId,
        "userId": "6750773be63d357449cb4903",
        "rechargeAmount": int.parse(cleanValue),
        "razorpayPaymentId": paymentId,
      };
      debugPrint('--Request body userRecharge: $body');
      // Make the API call
      final VerifyRechargeModel response = await apiService.verifyRecharge(
        body: body,
      );
      log('verifyRecharge Response: $response');
      if (response.success == true) {
        log('verifyRecharge Response: ${response.message.toString()}');
        verifyRechargeMsg = response.message;
        notifyListeners();
        return true; // Indicating success
      } else {
        debugPrint('verifyRecharge Response: ${response.message}');
        verifyRechargeMsg = response.message;
        notifyListeners();
        return false; // Indicating failure
      }
    } catch (error) {
      log("Error verifyRecharge: $error");
      if (error is DioException) {
        final apiError = ApiGlobalModel.fromJson(error.response?.data ?? {});
        customSnackBar(
          context: context,
          message: apiError.message ?? 'An error occurred',
          backgroundColor: AppColors.primaryColor,
        );
      } else {
        customSnackBar(
          context: context,
          message: 'An unexpected error occurred',
          backgroundColor: AppColors.primaryColor,
        );
      }
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // ! Razorpay
  // late Razorpay razorpay;

  // RechargeProvider() {
  //   amountController.addListener(() {
  //     _formatIndianNumber(amountController.text);
  //   });
  //   // Initialize Razorpay instance
  //   razorpay = Razorpay();

  //   // Register event listeners
  //   razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccess);
  //   razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentError);
  //   razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handleExternalWallet);
  // }

  void handlePaymentSuccess(
      BuildContext context, PaymentSuccessResponse response) {
    log('Payment-Success: ${response.data}');
    if (response.paymentId != null) {
      verifyRecharge(context, response.paymentId!);
      amountController.clear();
    }
    // Payment success callback
    showDialog(
      context: context,
      builder: (context) => Consumer<RechargeProvider>(
        builder: (context, _, child) => AlertDialog(
          title: const Text("Payment Successful"),
          content: Text(verifyRechargeMsg ?? ''),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("OK"),
            )
          ],
        ),
      ),
    );
  }

  void handlePaymentError(
      BuildContext context, PaymentFailureResponse response) {
    log('Payment-Failure: ${response.toString()}');
    // Payment failure callback
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Payment Failed"),
        content: Text(
            "Error Code: ${response.code}\nError Message: ${response.message}"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Retry"),
          )
        ],
      ),
    );
  }

  void handleExternalWallet(
      BuildContext context, ExternalWalletResponse response) {
    log('Payment-External wallet: ${response.toString()}');
    // External wallet callback
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("External Wallet Selected"),
        content: Text("Wallet Name: ${response.walletName}"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("OK"),
          )
        ],
      ),
    );
  }
}
