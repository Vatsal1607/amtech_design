import 'dart:convert';
import 'package:amtech_design/core/utils/constants/keys.dart';
import 'package:amtech_design/services/local/shared_preferences_service.dart';
import 'package:flutter/material.dart';

class AuthTokenHelper {
  static String? getUserId() {
    try {
      String? authToken =
          sharedPrefsService.getString(SharedPrefsKeys.userToken);
      if (authToken != null) {
        List<String> tokenParts = authToken.split('.');
        if (tokenParts.length == 3) {
          String payloadBase64 = tokenParts[1];
          String payload = utf8.decode(base64Url.decode(payloadBase64));
          Map<String, dynamic> payloadMap = jsonDecode(payload);
          return payloadMap['userId'];
        }
      }

      return null; // * If the structure is invalid
    } catch (e) {
      debugPrint('Error extracting userId: $e');
      return null;
    }
  }
}
