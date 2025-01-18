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

  static String? getUserContact() {
    String? authToken =
        sharedPrefsService.getString(SharedPrefsKeys.userToken) ?? '';
    // Split the token into parts
    List<String> tokenParts = authToken.split('.');
    if (tokenParts.length == 3) {
      String payloadBase64 = tokenParts[1];
      try {
        // Decode the Base64 URL-encoded payload
        String normalizedBase64 = base64Url.normalize(payloadBase64);
        String payload = utf8.decode(base64Url.decode(normalizedBase64));
        // Convert JSON payload to a Dart map
        Map<String, dynamic> payloadMap = jsonDecode(payload);
        // Access and return the contact field
        return payloadMap['contact']?.toString();
      } catch (e) {
        debugPrint("Error decoding token: $e");
        return null;
      }
    } else {
      debugPrint("Invalid token format");
      return null;
    }
  }
  // static String? getUserContact() {
  //   try {
  //     String? authToken =
  //         sharedPrefsService.getString(SharedPrefsKeys.userToken);
  //     if (authToken != null) {
  //       List<String> tokenParts = authToken.split('.');
  //       if (tokenParts.length == 3) {
  //         String payloadBase64 = tokenParts[1];
  //         String payload = utf8.decode(base64Url.decode(payloadBase64));
  //         Map<String, dynamic> payloadMap = jsonDecode(payload);
  //         return payloadMap[
  //             'contact']; // Assuming 'contact' is the key for mobile number in the payload
  //       }
  //     }
  //     return null; // * If the structure is invalid\
  //   } catch (e) {
  //     debugPrint('Error extracting userId: $e');
  //     return null;
  //   }
  // }
}
