import 'dart:developer';
import 'package:amtech_design/core/utils/constants/keys.dart';
import 'package:amtech_design/services/local/shared_preferences_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../../models/api_global_model.dart';

class DioInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    debugPrint("Request: ${options.method} ${options.uri}");
    options.headers.addAll({
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization':
          'Bearer ${sharedPrefsService.getString(SharedPrefsKeys.userToken)}',
    });
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    log("Response: ${response.statusCode} ${response.data}");
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // Global error handling
    ApiGlobalModel apiError;
    if (err.response != null) {
      // Server error
      apiError = ApiGlobalModel.fromJson(err.response!.data);
    } else {
      // Network or other error
      apiError = ApiGlobalModel(
        message: err.message ?? 'Network error occurred',
        statusCode: err.response?.statusCode,
      );
    }
    log('Error occurred: ${apiError.message}');
    handler.next(err); // Forward the error for further handling
  }
}
