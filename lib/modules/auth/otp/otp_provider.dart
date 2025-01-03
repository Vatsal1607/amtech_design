import 'dart:async';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/constants/keys.dart';
import '../../../custom_widgets/snackbar.dart';
import '../../../models/api_global_model.dart';
import '../../../routes.dart';
import '../../../services/local/shared_preferences_service.dart';
import '../../../services/network/api_service.dart';

class OtpProvider extends ChangeNotifier {
  OtpProvider() {
    startTimer();
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  final ApiService apiService = ApiService();
  final TextEditingController otpController = TextEditingController();
  int remainingSeconds = 30;
  Timer? timer;

  void startTimer() {
    remainingSeconds = 30;
    timer?.cancel(); // * Cancel any existing timer
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingSeconds > 0) {
        remainingSeconds--;
        notifyListeners(); // Notify listeners about the updated state
      } else {
        timer.cancel();
      }
    });
  }

  void stopTimer() {
    timer?.cancel();
    remainingSeconds = 0;
    notifyListeners();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  //* verifyOtp
  Future<void> verifyOtp({
    required BuildContext context,
    required String accountType,
    required String mobile,
  }) async {
    _isLoading = true;
    notifyListeners();
    try {
      final Map<String, dynamic> body = {
        'contact': int.parse('91$mobile'),
        'otp': int.parse(otpController.text),
        'role': accountType == 'business' ? '0' : '1',
        // 'secondaryContact': '', // optional
      };
      debugPrint('--Request body OTP verify: $body');
      // Make the API call
      final ApiGlobalModel response = await apiService.verifyOtp(
        body: body,
      );
      log('send OTP Response: $response');
      if (response.success == true) {
        log('Success: verify otp: ${response.message.toString()}');
        // * isLogged in user - true
        sharedPrefsService.setBool(SharedPrefsKeys.isLoggedIn, true);
        Navigator.pushNamed(context, Routes.verifySuccess);
      } else {
        debugPrint('verify otp: ${response.message}');
      }
    } catch (error) {
      log("Error during verify otp: $error");

      if (error is DioException) {
        // Parse API error response
        final apiError = ApiGlobalModel.fromJson(error.response?.data ?? {});
        customSnackBar(
          context: context,
          message: apiError.message ?? 'An error occurred',
          textColor: AppColors.primaryColor,
          backgroundColor: AppColors.white,
        );
      } else {
        // Handle unexpected errors
        customSnackBar(
          context: context,
          message: 'An unexpected error occurred',
          textColor: AppColors.primaryColor,
          backgroundColor: AppColors.white,
        );
      }
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
