import 'package:amtech_design/core/utils/constants/keys.dart';
import 'package:amtech_design/services/local/shared_preferences_service.dart';
import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

typedef RazorpaySuccessHandler = void Function(PaymentSuccessResponse);
typedef RazorpayErrorHandler = void Function(PaymentFailureResponse);
typedef RazorpayExternalWalletHandler = void Function(ExternalWalletResponse);

class RazorpayService {
  static final RazorpayService _instance = RazorpayService._internal();

  factory RazorpayService() => _instance;

  late Razorpay _razorpay;

  RazorpayService._internal() {
    _razorpay = Razorpay();
  }

  void init({
    required RazorpaySuccessHandler onSuccess,
    required RazorpayErrorHandler onError,
    required RazorpayExternalWalletHandler onExternalWallet,
  }) {
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, onSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, onError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, onExternalWallet);
  }

  void openCheckout(Map<String, Object> options) {
    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint('Razorpay Error: $e');
    }
  }

  void clear() {
    _razorpay.clear();
  }

  void openRazorpayCheckout({
    required String amountText,
    required String orderId,
    required String description,
    required String name,
    String email = 'customer@example.com',
  }) {
    final cleanValue = amountText.replaceAll(',', '');
    final int amount = int.tryParse(cleanValue) ?? 0;

    final options = {
      'key': RazorPayKeys.liveKey,
      'amount': amount * 100, // Razorpay expects amount in paise
      'currency': 'INR',
      'order_id': orderId,
      'name': name,
      'description': description,
      'prefill': {
        'contact':
            sharedPrefsService.getString(SharedPrefsKeys.userContact) ?? '',
        'email': email,
      },
      'method': {
        'upi': true,
        'card': true,
        'wallet': false,
        'netbanking': false,
        'paylater': false,
      },
    };

    RazorpayService().openCheckout(options);
  }
}
