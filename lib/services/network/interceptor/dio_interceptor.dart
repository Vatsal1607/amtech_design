import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../../models/api_global_model.dart';

class DioInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // Todo add bearer api token
    options.headers['Authorization'] = 'Bearer your_api_token';
    debugPrint("Request: ${options.method} ${options.uri}");
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    debugPrint("Response: ${response.statusCode} ${response.data}");
    handler.next(response);
  }

  @override
  // void onError(DioException err, ErrorInterceptorHandler handler) {
  //   debugPrint("Error: ${err.response?.statusCode} ${err.message}");
  //   handler.next(err);
  // }
  void onError(DioException error, ErrorInterceptorHandler handler) {
    // Global error handling
    ApiGlobalModel apiError;
    if (error.response != null) {
      // Server error
      apiError = ApiGlobalModel.fromJson(error.response!.data);
    } else {
      // Network or other error
      apiError = ApiGlobalModel(
        message: error.message ?? 'Network error occurred',
        statusCode: error.response?.statusCode,
      );
    }
    log('Error occurred: ${apiError.message}');
    handler.next(error); // Forward the error for further handling
  }
}
