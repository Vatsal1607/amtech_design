import 'dart:developer';

import 'package:amtech_design/core/utils/constants/keys.dart';
import 'package:amtech_design/models/user_login_model.dart';
import 'package:amtech_design/services/local/shared_preferences_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../../core/utils/app_colors.dart';
import '../../../custom_widgets/snackbar.dart';
import '../../../models/api_global_model.dart';
import '../../../routes.dart';
import '../../../services/network/api_service.dart';

class LoginProvider extends ChangeNotifier {
  String countryCode = '+91'; // Default country code for mobile
  final TextEditingController phoneController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  String? mobileErrorText;

  String? validateMobileNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Mobile number is required';
    }
    if (value.length != 10) {
      return 'Mobile number must be 10 digits';
    }
    if (!RegExp(r'^\d{10}$').hasMatch(value)) {
      return 'Mobile number must contain only numeric values';
    }
    return null;
  }

  // @override
  // void dispose() {
  //   // phoneController.clear();
  //   // phoneController.dispose();
  //   super.dispose();
  // }

  onChangePersonalNumber(value) {
    if (value.length != 10) {
      mobileErrorText = 'Please enter exactly 10 digits';
      notifyListeners();
    } else {
      mobileErrorText = null;
      notifyListeners();
    }
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  final ApiService apiService = ApiService();

  //! User login API
  Future<void> userLogin(
    BuildContext context,
    String accountType,
  ) async {
    _isLoading = true;
    notifyListeners();
    try {
      final location = sharedPrefsService.getString(SharedPrefsKeys.location);
      final company = sharedPrefsService.getString(SharedPrefsKeys.company);
      final Map<String, dynamic> body = {
        'contact': int.parse('91${phoneController.text}'),
        'location': location, // * use sharedprefs //selectedLocation
        if (accountType == 'business')
          'company': company, // business.businessName
        'role': accountType == 'business' ? '0' : '1',
        'fcmToken': 'xyzwefghhfdsdfffffffffftgfdfcdfds', //Todo add dynamic data
        'deviceId': 'jrkjfbsdnanhaifkbsfa', //Todo add dynamic data
      };
      debugPrint('--Request body: $body');
      // Make the API call
      final UserLoginModel response = await apiService.userLogin(
        body: body,
      );
      log('User login Response: $response');
      if (response.success == true) {
        log(response.message.toString());
        if (response.data != null) {
          //* Save User Token
          sharedPrefsService.setString(
              SharedPrefsKeys.userToken, response.data!.token!);
        }
        // * send otp API call
        await sendOtp(
          context: context,
          mobile: phoneController.text,
          accountType: accountType,
          isNavigateToOtpPage: true,
        );
        phoneController.clear();
      } else {
        debugPrint('User login Message: ${response.message}');
      }
    } catch (error) {
      log("Error during User login Response: $error");

      if (error is DioException) {
        // Parse API error response
        final apiError = ApiGlobalModel.fromJson(error.response?.data ?? {});
        customSnackBar(
          context: context,
          message: apiError.message ?? 'An error occurred',
          backgroundColor: AppColors.seaShell,
          textColor: AppColors.primaryColor,
        );
      } else {
        // Handle unexpected errors
        customSnackBar(
          context: context,
          message: 'An unexpected error occurred',
          backgroundColor: AppColors.seaShell,
          textColor: AppColors.primaryColor,
        );
      }
    } finally {
      // Ensure loading state is reset
      _isLoading = false;
      notifyListeners();
    }
  }

  // * send Otp API
  Future sendOtp({
    required BuildContext context,
    required String accountType,
    bool isNavigateToOtpPage = false,
    required String mobile,
  }) async {
    _isLoading = true;
    notifyListeners();
    try {
      final Map<String, dynamic> body = {
        'contact': int.parse('91$mobile'),
        'role': accountType == 'business' ? '0' : '1',
        // 'secondaryContact': '', // optional
      };
      debugPrint('--Request body OTP: $body');
      // Make the API call
      final ApiGlobalModel response = await apiService.sendOtp(
        body: body,
      );
      log('send OTP Response: $response');
      if (response.success == true) {
        log('Success: sendotp: ${response.message.toString()}');
        customSnackBar(
          context: context,
          message: response.message.toString(),
          backgroundColor: AppColors.seaShell,
          textColor: AppColors.primaryColor,
        );
        if (isNavigateToOtpPage) {
          Navigator.pushNamed(context, Routes.otp, arguments: {
            'mobile': phoneController.text,
          });
        }
        return true; // * Indicat success
      } else {
        debugPrint('User sendotp Message: ${response.message}');
        return false; // * Indicat failure
      }
    } catch (error) {
      log("Error during sendotp Response: $error");

      if (error is DioException) {
        // Parse API error response
        final apiError = ApiGlobalModel.fromJson(error.response?.data ?? {});
        customSnackBar(
          context: context,
          message: apiError.message ?? 'An error occurred',
          backgroundColor: AppColors.seaShell,
          textColor: AppColors.primaryColor,
        );
      } else {
        // Handle unexpected errors
        customSnackBar(
          context: context,
          message: 'An unexpected error occurred',
          backgroundColor: AppColors.seaShell,
          textColor: AppColors.primaryColor,
        );
      }
    } finally {
      // Ensure loading state is reset
      _isLoading = false;
      notifyListeners();
    }
  }
}
