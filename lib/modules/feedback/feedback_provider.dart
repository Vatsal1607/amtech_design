import 'dart:developer';

import 'package:amtech_design/custom_widgets/snackbar.dart';
import 'package:amtech_design/services/network/api_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../core/utils/constants/keys.dart';
import '../../services/local/shared_preferences_service.dart';

class FeedbackProvider extends ChangeNotifier {
  TextEditingController feedbackController = TextEditingController();

  bool isLoadingFeedback = false;
  ApiService apiService = ApiService();

  // feedback Submit API
  Future feedbackSubmit(BuildContext context) async {
    isLoadingFeedback = true;
    notifyListeners();
    try {
      final res = await apiService.feedbackSumbit(
        userId: sharedPrefsService.getString(SharedPrefsKeys.userContact) ?? '',
        userType: sharedPrefsService.getString(SharedPrefsKeys.accountType) ==
                'business'
            ? 'BusinessUser'
            : 'User',
        description: feedbackController.text.trim(),
      );
      if (res.success == true) {
        feedbackController.clear();
        Navigator.pop(context);
        customSnackBar(context: context, message: res.message.toString());
      } else {
        log(res.message.toString());
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
      isLoadingFeedback = false;
      notifyListeners();
    }
  }
}
