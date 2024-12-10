import 'dart:developer';

import 'package:amtech_design/core/utils/constants/keys.dart';
import 'package:amtech_design/models/user_login_model.dart';
import 'package:amtech_design/services/local/shared_preferences_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../../core/utils/app_colors.dart';
import '../../../custom_widgets/snackbar.dart';
import '../../../models/api_global_model.dart';
import '../../../services/network/api_service.dart';

class LoginProvider extends ChangeNotifier {
  String countryCode = '+91'; // Default country code for mobile
  final TextEditingController phoneController = TextEditingController();

  final formKey = GlobalKey<FormState>();

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

  @override
  void dispose() {
    phoneController.clear();
    phoneController.dispose();
    super.dispose();
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
      final location = await SharedPreferencesService()
          .getString(SharedPreferencesKeys.location);
      final company = await SharedPreferencesService()
          .getString(SharedPreferencesKeys.company);
      final Map<String, dynamic> body = {
        'contact': int.parse(phoneController.text),
        // 'location': location, // use sharedprefs //selectedLocation
        'location': 'kashmir', //! statis
        if (accountType == 'business')
          // 'company': company, // business.businessName
          'company': 'amTech company', //! static
        'role': accountType == 'business' ? '0' : '1',
        'fcmToken': 'xyzwefghhfdsdfffffffffftgfdfcdfds', //Todo add dynamic data
        'deviceId': 'jrkjfbsdnanhaifkbsfa', //Todo add dynamic data
      };
      debugPrint('Request body: $body');
      // Make the API call
      final UserLoginModel response = await apiService.userLogin(
        body: body,
        // images: multipartImageList, // For multipart file uploads
      );
      log('User login Response: $response');
      if (response.success == true) {
        customSnackBar(
          context: context,
          message: response.message!,
          backgroundColor: AppColors.primaryColor,
        );
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
}
