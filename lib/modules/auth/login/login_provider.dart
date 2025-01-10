import 'dart:convert';
import 'dart:developer';
import 'package:amtech_design/core/utils/constants/keys.dart';
import 'package:amtech_design/models/user_login_model.dart';
import 'package:amtech_design/services/local/auth_token_helper.dart';
import 'package:amtech_design/services/local/shared_preferences_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../../core/utils/app_colors.dart';
import '../../../custom_widgets/snackbar.dart';
import '../../../models/api_global_model.dart';
import '../../../models/business_list_model.dart';
import '../../../routes.dart';
import '../../../services/network/api_service.dart';

class LoginProvider extends ChangeNotifier {
  LoginProvider() {
    // getBusinessNameAndSecondaryAccess().then((value) {
    //   log('getBusinessNameAndSecondaryAccess: $value');
    //   businessList = value;
    // });

    /// getSelectedBusinessSecondaryAccess
    getSelectedBusinessSecondaryAccess().then((value) {
      secondaryAccessList = value;
      log('secondaryAccessList -- (loginProvider): $secondaryAccessList');
      // call Validate method
      // log('validateContactInSecondaryAccess: ${validateContactInSecondaryAccess(919725163481)}');
    });
  }

  List<SecondaryAccess> secondaryAccessList = [];
  // * Get SelectedBusinessSecondaryAccess
  Future<List<SecondaryAccess>> getSelectedBusinessSecondaryAccess() async {
    String? jsonString =
        sharedPrefsService.getString(SharedPrefsKeys.secondaryAccessList);

    if (jsonString != null) {
      // Decode JSON and return as List of SecondaryAccessModel
      List<dynamic> decodedList = jsonDecode(jsonString);
      secondaryAccessList =
          decodedList.map((item) => SecondaryAccess.fromJson(item)).toList();
      return secondaryAccessList;
    }
    return [];
  }

  List<Map<String, dynamic>> businessList = [];
  Future<List<Map<String, dynamic>>> getBusinessNameAndSecondaryAccess() async {
    String? jsonString =
        sharedPrefsService.getString(SharedPrefsKeys.firstSecondaryAccessList);

    if (jsonString != null) {
      // Decode JSON and return as List of Maps
      return List<Map<String, dynamic>>.from(jsonDecode(jsonString));
    }
    return [];
  }

  // * Valdiate secondary Access (check Is Authorized emp or Not)
  /// Note: pass prefix 91 while validate number to method because response start from 91{mobilenumber}
  bool validateContactInSecondaryAccess(int enteredContact) {
    // Check if the secondaryAccessList is not empty
    if (secondaryAccessList.isNotEmpty) {
      // Use any to find if the contact exists in the secondaryAccessList
      if (secondaryAccessList
          .any((contact) => contact.contact == enteredContact)) {
        log('validateContactInSecondaryAccessList: TRUE');
        return true; // Contact found
      }
    }

    log('validateContactInSecondaryAccessList: FALSE');
    return false; // Contact not found
  }

  /// * Old validate method
  // bool validateContactInSecondaryAccess(int enteredContact) {
  //   if (businessList.isNotEmpty) {
  //     for (var business in businessList) {
  //       List<dynamic> secondaryAccess = business['secondaryAccess'];
  //       if (secondaryAccess
  //           .any((contact) => contact['contact'] == enteredContact)) {
  //         log('validateContactInSecondaryAccess: TRUE');
  //         return true; // Contact found
  //       }
  //     }
  //   }
  //   log('validateContactInSecondaryAccess: FALSE');
  //   return false; // Contact not found
  // }

  String countryCode = '+91'; // Default country code for mobile
  final TextEditingController phoneController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  String? mobileErrorText;

  String? validateMobileNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Mobile number is required';
    }
    if (value.length != 10) {
      return 'Mobile number must be 10 digits';
    }
    if (!RegExp(r'^\d{10}$').hasMatch(value)) {
      return 'Mobile number must contain only numeric values';
    }
    return null;
  }

  @override
  void dispose() {
    // phoneController.clear();
    // phoneController.dispose();
    mobilenumberFocusNode.dispose();
    super.dispose();
  }

  final FocusNode mobilenumberFocusNode = FocusNode();

  onChangeMobileNumber(value) {
    if (value.length != 10) {
      mobileErrorText = 'Please enter exactly 10 digits';
      notifyListeners();
    } else {
      mobileErrorText = null;
      notifyListeners();
      mobilenumberFocusNode.unfocus();
    }
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  final ApiService apiService = ApiService();

  //! User login API
  Future<void> userLogin(
    BuildContext context,
    String accountType,
  ) async {
    _isLoading = true;
    notifyListeners();
    try {
      final location = sharedPrefsService.getString(SharedPrefsKeys.location);
      final company = sharedPrefsService.getString(SharedPrefsKeys.company);
      final fcmToken = sharedPrefsService.getString(SharedPrefsKeys.fcmToken);
      final deviceId = sharedPrefsService.getString(SharedPrefsKeys.deviceId);
      final Map<String, dynamic> body = {
        'contact': int.parse('91${phoneController.text}'),
        'location': location,
        if (accountType == 'business')
          'company': company, // business.businessName
        'role': accountType == 'business'
            ? validateContactInSecondaryAccess(
                    int.parse('91${phoneController.text}'))
                ? '2'
                : '0'
            : '1',
        // 'role': accountType == 'business' ? '2' : '1', // pass role '2' while isAccess = true in businesslist
        'fcmToken': fcmToken,
        'deviceId': deviceId,
      };
      debugPrint('--Request body: $body');
      // Make the API call
      final UserLoginModel response = await apiService.userLogin(
        body: body,
      );
      log('User login Response: $response');
      if (response.success == true) {
        log(response.message.toString());
        if (response.data != null) {
          // * Save User Token
          sharedPrefsService.setString(
              SharedPrefsKeys.userToken, response.data!.token!);
          // * Save User id
          sharedPrefsService.setString(
              SharedPrefsKeys.userId, AuthTokenHelper.getUserId().toString());
          // * Save contact
          sharedPrefsService.setString(SharedPrefsKeys.userContact,
              AuthTokenHelper.getUserContact().toString());
        }
        // * send otp API call
        await sendOtp(
          context: context,
          mobile: phoneController.text,
          accountType: accountType,
          isNavigateToOtpPage: true,
        );
        phoneController.clear();
      } else {
        debugPrint('User login Message: ${response.message}');
      }
    } catch (error) {
      log("Error during User login Response: $error");

      if (error is DioException) {
        // Parse API error response
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
    required String accountType,
    bool isNavigateToOtpPage = false,
    required String mobile,
  }) async {
    _isLoading = true;
    notifyListeners();
    try {
      final Map<String, dynamic> body = {
        /// If number not exist in secondory access
        if (!validateContactInSecondaryAccess(int.parse('91$mobile')))
          'contact': int.parse('91$mobile'),
        'role': accountType == 'business' ? '0' : '1',

        /// If number exist in secondary access
        if (validateContactInSecondaryAccess(int.parse('91$mobile')))
          'secondaryContact': int.parse('91$mobile'),
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
        if (isNavigateToOtpPage) {
          Navigator.pushNamed(context, Routes.otp, arguments: {
            'mobile': phoneController.text,
          });
        }
        return true; // * Indicat success
      } else {
        debugPrint('User sendotp Message: ${response.message}');
        return false; // * Indicat failure
      }
    } catch (error) {
      log("Error during sendotp Response: $error");

      if (error is DioException) {
        // Parse API error response
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
}
