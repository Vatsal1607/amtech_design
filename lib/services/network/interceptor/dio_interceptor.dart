import 'dart:developer';

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
      'Authorization': 'Bearer your_api_token', //Todo Add the bearer token
    });
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    debugPrint("Response: ${response.statusCode} ${response.data}");
    handler.next(response);
  }

  @override
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
