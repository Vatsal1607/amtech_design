import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../../core/utils/app_colors.dart';
import '../../../custom_widgets/snackbar.dart';
import '../../../models/api_global_model.dart';
import '../../../routes.dart';
import '../../../services/network/api_service.dart';

class OtpProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  final ApiService apiService = ApiService();
  final TextEditingController otpController = TextEditingController();

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
        Navigator.pushNamed(context, Routes.bottomBarPage);
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
