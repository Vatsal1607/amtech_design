import 'dart:convert';
import 'dart:developer';
import 'package:amtech_design/core/utils/constants/keys.dart';
import 'package:amtech_design/services/local/shared_preferences_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/utils/app_globals.dart';
import '../../../models/api_global_model.dart';
import '../../../modules/profile/profile_provider.dart';

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
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    ApiGlobalModel apiError;

    if (err.response != null) {
      dynamic responseData = err.response!.data;

      // Check if response is String and likely HTML
      if (responseData is String) {
        if (responseData.trimLeft().startsWith('<!DOCTYPE html')) {
          log('❌ HTML error page received instead of JSON.');
          responseData = null;
        } else {
          try {
            responseData = jsonDecode(responseData);
          } catch (e) {
            log('❌ Failed to decode JSON: $e');
            responseData = null;
          }
        }
      }

      // Now parse safely
      if (responseData is Map<String, dynamic>) {
        apiError = ApiGlobalModel.fromJson(responseData);
      } else {
        apiError = ApiGlobalModel(
          message: 'Unexpected error format',
          statusCode: err.response?.statusCode,
        );
      }

      // Check if token is invalid or expired
      final isUnauthorized = err.response?.statusCode == 401 ||
          apiError.message?.toLowerCase().contains('expired token') == true;

      if (isUnauthorized) {
        log('Token expired. Logging out...');
        Future.delayed(Duration.zero, () async {
          final context = navigatorKey.currentContext;
          if (context != null) {
            final profileProvider =
                Provider.of<ProfileProvider>(context, listen: false);
            await profileProvider.logout(isTokenExpired: true);
          } else {
            log('Context is null. Could not access ProfileProvider.');
          }
        });
      }
    } else {
      // Handle network or unknown errors
      apiError = ApiGlobalModel(
        message: err.message ?? 'Network error occurred',
        statusCode: err.response?.statusCode,
      );
    }

    log('Error occurred: ${apiError.message}');
    handler.next(err); // Pass the error to the next interceptor/handler
  }
}
