import 'dart:developer';
import 'package:amtech_design/core/utils/constants/keys.dart';
import 'package:amtech_design/custom_widgets/dialog/custom_info_dialog.dart';
import 'package:amtech_design/modules/provider/socket_provider.dart';
import 'package:amtech_design/services/local/shared_preferences_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
        sharedPrefsService.clear();
        context?.read<SocketProvider>().disconnect();
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

  bool isLoadingAccountDelete = false;

  Future deleteAccount(BuildContext context) async {
    isLoadingAccountDelete = true;
    notifyListeners();
    try {
      final res = await apiService.deleteAccount(
        userId: sharedPrefsService.getString(SharedPrefsKeys.userId) ?? '',
      );
      if (res.success == true) {
        sharedPrefsService.clear();
        Navigator.pushNamedAndRemoveUntil(
          navigatorKey.currentContext!,
          Routes.accountSelection,
          (Route<dynamic> route) => false,
        );
        updateTileIndex(0);
      } else {
        customSnackBar(context: context, message: res.message.toString());
      }
    } on DioException catch (e) {
      if (e.response != null && e.response?.data != null) {
        final data = e.response!.data;
        if (data is Map<String, dynamic> && data['message'] != null) {
          log(data['message']);
        }
      }
      log("Error deleteAccount: ${e.toString()}");
    } finally {
      isLoadingAccountDelete = false;
      notifyListeners();
    }
  }
}
