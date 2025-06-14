import 'dart:developer';
import 'package:amtech_design/core/utils/constants/keys.dart';
import 'package:amtech_design/models/user_recharge_model.dart';
import 'package:amtech_design/models/verify_recharge_model.dart';
import 'package:amtech_design/services/local/shared_preferences_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import '../../core/utils/app_colors.dart';
import '../../custom_widgets/snackbar.dart';
import '../../models/api_global_model.dart';
import '../../models/recharge_history_model.dart';
import '../../services/network/api_service.dart';

class RechargeProvider extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();
  TextEditingController amountController = TextEditingController();
  final NumberFormat _indianFormat = NumberFormat('#,##,##,###', 'en_IN');
  FocusNode amountFocusNode = FocusNode();

  void formatIndianNumber(String value) {
    if (value.isEmpty) return;
    String plainNumber = value.replaceAll(',', '');
    String formattedNumber =
        _indianFormat.format(int.tryParse(plainNumber) ?? 0);
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

  // * Api method userRecharge (Note: Pass amount while call api expect from recharge page)
  Future<bool> userRecharge({
    required BuildContext context,
    int? amount,
  }) async {
    _isLoading = true;
    notifyListeners();
    log('userRecharge API called');

    try {
      int finalAmount;

      if (amount != null) {
        finalAmount = amount;
      } else {
        final cleanValue = amountController.text.replaceAll(',', '').trim();

        if (cleanValue.isEmpty || int.tryParse(cleanValue) == null) {
          log("Invalid cleanValue: '$cleanValue'");
        }
        finalAmount = int.parse(cleanValue);
      }

      final userId = sharedPrefsService.getString(SharedPrefsKeys.userId);

      final Map<String, dynamic> body = {
        'userId': userId,
        'rechargeAmount': finalAmount,
      };

      log('Recharge request body: $body');

      final UserRechargeModel response =
          await apiService.userRecharge(body: body);
      log('UserRecharge Response: $response');

      if (response.success == true) {
        log('UserRecharge Message: ${response.message.toString()}');
        if (response.data != null) {
          razorpayOrderId = response.data!.razorpayOrderId;
        }
        return true;
      } else {
        return false;
      }
    } catch (error) {
      log("Error user Recharge: $error");

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

      return false;
    } finally {
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
        "userId": sharedPrefsService.getString(SharedPrefsKeys.userId),
        "rechargeAmount": int.parse(cleanValue),
        "razorpayPaymentId": paymentId,
      };
      // Make the API call
      final VerifyRechargeModel response = await apiService.verifyRecharge(
        body: body,
      );
      log('verifyRecharge Response: $response');
      if (response.success == true) {
        log('verifyRecharge Response: ${response.message.toString()}');
        verifyRechargeMsg = response.message;
        getRechargeHistory(context);
        return true; // Indicating success
      } else {
        verifyRechargeMsg = response.message;
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

  bool isLoadingRechargeHistory = false;
  RechargeHistoryModel? historyRes;
  List<PaymentHistory>? paymentHistoryList;

  // * Recharge History API
  Future<void> getRechargeHistory(BuildContext context) async {
    isLoadingRechargeHistory = true;
    notifyListeners();
    try {
      String userId =
          sharedPrefsService.getString(SharedPrefsKeys.userId) ?? '';
      final res = await apiService.rechargeHistory(userId: userId);
      log('getRechargeHistory: $res');
      if (res.success == true) {
        historyRes = res;
        paymentHistoryList = res.data?.paymentHistory;
      } else {
        log('${res.message}');
      }
    } catch (e) {
      log("Error getRechargeHistory: ${e.toString()}");
    } finally {
      isLoadingRechargeHistory = false;
      notifyListeners();
    }
  }

  // ! Razorpay
  void handlePaymentSuccess(
      BuildContext context, PaymentSuccessResponse response) {
    log('Payment-Success: ${response.data}');
    if (response.paymentId != null) {
      verifyRecharge(context, response.paymentId!).then((isSuccess) {
        if (isSuccess) {
          amountController.clear();
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
      });
    }
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
