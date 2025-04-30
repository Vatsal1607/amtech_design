import 'dart:developer';
import 'package:amtech_design/core/utils/constants/keys.dart';
import 'package:amtech_design/custom_widgets/dialog/custom_info_dialog.dart';
import 'package:amtech_design/services/local/shared_preferences_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../core/utils/app_colors.dart';
import '../../core/utils/app_globals.dart';
import '../../custom_widgets/snackbar.dart';
import '../../models/api_global_model.dart';
import '../../routes.dart';
import '../../services/network/api_service.dart';

class ProfileProvider extends ChangeNotifier {
  int selectedTileIndex = 0;
  updateTileIndex(int index) {
    selectedTileIndex = index;
    notifyListeners();
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  final ApiService apiService = ApiService();

  // * logout api method
  Future logout({
    BuildContext? context,
    bool isTokenExpired = false,
  }) async {
    _isLoading = true;
    notifyListeners();
    final userId = sharedPrefsService.getString(SharedPrefsKeys.userId);
    final deviceId = sharedPrefsService.getString(SharedPrefsKeys.deviceId);
    try {
      final Map<String, dynamic> body = {
        'userId': userId,
        'deviceId': deviceId,
      };
      final ApiGlobalModel response = await apiService.logout(body: body);
      if (response.success == true) {
        sharedPrefsService.setBool(SharedPrefsKeys.isLoggedIn, false);
        if (context != null) {
          if (isTokenExpired) {
            if (navigatorKey.currentContext != null) {
              showCustomInfoDialog(
                context: navigatorKey.currentContext!,
                buttonText: 'Login Again!',
                onTap: () {
                  Navigator.pushNamedAndRemoveUntil(
                    navigatorKey.currentContext!,
                    Routes.accountSelection,
                    (Route<dynamic> route) => false,
                  );
                },
                title: 'Session Expired',
                accountType:
                    sharedPrefsService.getString(SharedPrefsKeys.accountType) ??
                        '',
                message:
                    'Your session has expired for security reasons. Please log in again to continue.',
              );
            }
          } else {
            Navigator.pushNamedAndRemoveUntil(
              navigatorKey.currentContext!,
              Routes.accountSelection,
              (Route<dynamic> route) => false,
            );
          }
          customSnackBar(
            context: navigatorKey.currentContext!,
            message: response.message.toString(),
            backgroundColor: AppColors.seaShell,
            textColor: AppColors.primaryColor,
          );
        }
        // else {
        //   navigatorKey.currentState?.pushNamedAndRemoveUntil(
        //     Routes.accountSelection,
        //     (route) => false,
        //   );
        // }
        return true;
      } else {
        if (context != null) {
          customSnackBar(
            context: context,
            message: response.message.toString(),
            backgroundColor: AppColors.seaShell,
            textColor: AppColors.primaryColor,
          );
        }
        return false;
      }
    } catch (error) {
      log("Error during logout Response: $error");
      if (context != null) {
        if (error is DioException) {
          final apiError = ApiGlobalModel.fromJson(error.response?.data ?? {});
          customSnackBar(
            context: context,
            message: apiError.message ?? 'An error occurred',
            backgroundColor: AppColors.seaShell,
            textColor: AppColors.primaryColor,
          );
        } else {
          customSnackBar(
            context: context,
            message: 'An unexpected error occurred',
            backgroundColor: AppColors.seaShell,
            textColor: AppColors.primaryColor,
          );
        }
      }
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
