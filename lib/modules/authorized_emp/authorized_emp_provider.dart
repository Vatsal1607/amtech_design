import 'dart:developer';
import 'package:amtech_design/core/utils/constants/keys.dart';
import 'package:amtech_design/models/get_list_access_model.dart';
import 'package:amtech_design/services/local/shared_preferences_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../core/utils/app_colors.dart';
import '../../custom_widgets/snackbar.dart';
import '../../models/api_global_model.dart';
import '../../services/network/api_service.dart';

class AuthorizedEmpProvider extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();

  TextEditingController fullNameController = TextEditingController();
  TextEditingController positionController = TextEditingController();
  TextEditingController mobileController = TextEditingController();

  TextEditingController disabledfullNameController = TextEditingController();
  TextEditingController disabledpositionController = TextEditingController();
  TextEditingController disabledmobileController = TextEditingController();

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  final ApiService apiService = ApiService();

  AuthorizedEmpProvider() {
    getListAccess();
  }

  List<AccessList>? accessList;

  // * getListAccess
  Future getListAccess() async {
    // _isLoading = true;
    // notifyListeners();
    try {
      final GetListAccessModel response = await apiService.getListAccess();
      log('getListAccess Response: $response');
      if (response.success == true) {
        if (accessList != null) {
          accessList!.clear();
        }
        log('Success: getListAccess: ${response.message.toString()}');
        if (response.data != null) {
          accessList = response.data;
          log('accessList is:- ${accessList?[0].name.toString()}');
        }

        // customSnackBar(
        //   context: context,
        //   message: response.message.toString(),
        //   backgroundColor: AppColors.seaShell,
        //   textColor: AppColors.primaryColor,
        // );
        return true; // * Indicat success
      } else {
        debugPrint('User createAccess Message: ${response.message}');
        return false; // * Indicat failure
      }
    } catch (error) {
      log("Error during createAccess Response: $error");

      if (error is DioException) {
        final apiError = ApiGlobalModel.fromJson(error.response?.data ?? {});
        // customSnackBar(
        //   context: context,
        //   message: apiError.message ?? 'An error occurred',
        //   backgroundColor: AppColors.seaShell,
        //   textColor: AppColors.primaryColor,
        // );
      } else {
        // * Handle unexpected errors
        // customSnackBar(
        //   context: context,
        //   message: 'An unexpected error occurred',
        //   backgroundColor: AppColors.seaShell,
        //   textColor: AppColors.primaryColor,
        // );
      }
    } finally {
      // Ensure loading state is reset
      // _isLoading = false;
      notifyListeners();
    }
  }

  // Remove emp API
  Future deleteAccess({
    required BuildContext context,
    required String empId,
  }) async {
    _isLoading = true;
    notifyListeners();
    try {
      final ApiGlobalModel response =
          await apiService.deleteAccess(userId: empId);
      log('deleteAccess Response: $response');
      if (response.success == true) {
        log('Success: deleteAccess: ${response.message.toString()}');
        Navigator.pop(context);
        getListAccess();

        customSnackBar(
          context: context,
          message: response.message.toString(),
          backgroundColor: AppColors.seaShell,
          textColor: AppColors.primaryColor,
        );
        notifyListeners();
        return true; // * Indicat success
      } else {
        debugPrint('deleteAccess Message: ${response.message}');
        Navigator.pop(context);
        customSnackBar(
          context: context,
          message: response.message.toString(),
          backgroundColor: AppColors.seaShell,
          textColor: AppColors.primaryColor,
        );
        return false; // * Indicat failure
      }
    } catch (error) {
      log("Error during deleteAccess Response: $error");

      if (error is DioException) {
        final apiError = ApiGlobalModel.fromJson(error.response?.data ?? {});
        // customSnackBar(
        //   context: context,
        //   message: apiError.message ?? 'An error occurred',
        //   backgroundColor: AppColors.seaShell,
        //   textColor: AppColors.primaryColor,
        // );
      } else {
        // * Handle unexpected errors
        // customSnackBar(
        //   context: context,
        //   message: 'An unexpected error occurred',
        //   backgroundColor: AppColors.seaShell,
        //   textColor: AppColors.primaryColor,
        // );
      }
    } finally {
      // Ensure loading state is reset
      _isLoading = false;
      notifyListeners();
    }
  }

  // createAccess
  Future createAccess({
    required BuildContext context,
  }) async {
    _isLoading = true;
    notifyListeners();
    try {
      final String userId =
          sharedPrefsService.getString(SharedPrefsKeys.userId) ?? '';
      final Map<String, dynamic> body = {
        'businessId': userId,
        'name': fullNameController.text.trim(),
        'contact': int.parse('91${mobileController.text}'),
        'position': positionController.text.trim(),
      };
      debugPrint('--Request body createAccess: $body');
      final ApiGlobalModel response = await apiService.createAccess(
        body: body,
      );
      log('createAccess Response: $response');
      if (response.success == true) {
        log('Success: createAccess: ${response.message.toString()}');
        customSnackBar(
          context: context,
          message: response.message.toString(),
          backgroundColor: AppColors.seaShell,
          textColor: AppColors.primaryColor,
        );
        return true; // * Indicat success
      } else {
        debugPrint('User createAccess Message: ${response.message}');
        return false; // * Indicat failure
      }
    } catch (error) {
      log("Error during createAccess Response: $error");

      if (error is DioException) {
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
    bool isNavigateToOtpPage = false,
    required String secondaryMobile,
  }) async {
    _isLoading = true;
    notifyListeners();
    try {
      final Map<String, dynamic> body = {
        'role': '0',
        'secondaryContact': int.parse('91$secondaryMobile'),
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
        return true; // * Indicat success
      } else {
        debugPrint('User sendotp Message: ${response.message}');
        return false; // * Indicat failure
      }
    } catch (error) {
      log("Error during sendotp Response: $error");

      if (error is DioException) {
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

  //* verifyOtp
  Future<void> verifyOtp({
    required BuildContext context,
    required String mobile,
    required TextEditingController otpController,
  }) async {
    _isLoading = true;
    notifyListeners();
    try {
      final Map<String, dynamic> body = {
        'otp': int.parse(otpController.text),
        'role': '0',
        'secondaryContact': int.parse('91${mobileController.text}'),
      };
      debugPrint('--Request body OTP verify: $body');
      final ApiGlobalModel response = await apiService.verifyOtp(
        body: body,
      );
      log('verify OTP Response: $response');
      if (response.success == true) {
        getListAccess();
        log('Success: verify otp: ${response.message.toString()}');
        fullNameController.clear();
        positionController.clear();
        mobileController.clear();
        Navigator.pop(context);
        customSnackBar(
          context: context,
          message: response.message.toString(),
          textColor: AppColors.primaryColor,
          backgroundColor: AppColors.white,
        );
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
