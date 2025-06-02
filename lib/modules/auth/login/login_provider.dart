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
      return List<Map<String, dynamic>>.from(jsonDecode(jsonString));
    }
    return [];
  }

  // * Valdiate secondary Access (check Is Authorized emp or Not)
  /// Note: pass prefix 91 while validate number to method because response start from 91{mobilenumber}
  bool validateContactInSecondaryAccess(int enteredContact) {
    if (secondaryAccessList.isNotEmpty) {
      if (secondaryAccessList
          .any((contact) => contact.contact == enteredContact)) {
        log('validateContactInSecondaryAccessList: TRUE');
        return true; // Contact found
      }
    }
    log('validateContactInSecondaryAccessList: FALSE');
    return false; // Contact not found
  }

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
      mobilenumberFocusNode.unfocus();
      notifyListeners();
    }
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  final ApiService apiService = ApiService();

  //! User login API
  //* New login method with callback
  Future<bool> userLogin({
    required BuildContext context,
    required String accountType,
    bool isAccountSwitch = false,
    String? accountSwitchContact,
  }) async {
    _isLoading = true;
    notifyListeners();
    try {
      final location = sharedPrefsService.getString(SharedPrefsKeys.location);
      final company = sharedPrefsService.getString(SharedPrefsKeys.company);
      final fcmToken = sharedPrefsService.getString(SharedPrefsKeys.fcmToken);
      final deviceId = sharedPrefsService.getString(SharedPrefsKeys.deviceId);
      final Map<String, dynamic> body = {
        'contact': isAccountSwitch
            ? accountSwitchContact
            : int.parse('91${phoneController.text}'),
        'location': location,
        if (accountType == 'business') 'company': company,
        'role': accountType == 'business'
            ? validateContactInSecondaryAccess(
                    int.parse('91${phoneController.text}'))
                ? '2'
                : '0'
            : '1',
        'fcmToken': fcmToken,
        'deviceId': deviceId,
      };
      log('requestBody login: $body');
      final UserLoginModel response = await apiService.userLogin(body: body);
      if (response.success == true) {
        if (response.data != null) {
          await sharedPrefsService.setString(
              SharedPrefsKeys.userToken, response.data!.token!);
          await sharedPrefsService.setString(
              SharedPrefsKeys.userId, response.data?.user?.sId ?? '');
          log('User Id from local: $accountType ${sharedPrefsService.getString(SharedPrefsKeys.userId)}');
          log('User Id from response: $accountType ${response.data?.user?.sId}');
          await sharedPrefsService.setString(SharedPrefsKeys.userContact,
              AuthTokenHelper.getUserContact().toString());
        }
        if (isAccountSwitch) {
          // handle account switch specific logic here if needed
        } else {
          await sendOtp(
            context: context,
            mobile: phoneController.text,
            accountType: accountType,
            isNavigateToOtpPage: true,
          );
          phoneController.clear();
        }
        return true; // SUCCESS
      } else {
        debugPrint('User login Message: ${response.message}');
        return false; // FAIL from API
      }
    } catch (error) {
      log("Error during User login Response: $error");

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
      return false; // FAIL on exception
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
  //* OLD Without callback
  // Future<void> userLogin({
  //   required BuildContext context,
  //   required String accountType,
  //   bool isAccountSwitch = false,
  //   String? accountSwitchContact,
  // }) async {
  //   _isLoading = true;
  //   notifyListeners();
  //   try {
  //     final location = sharedPrefsService.getString(SharedPrefsKeys.location);
  //     final company = sharedPrefsService.getString(SharedPrefsKeys.company);
  //     final fcmToken = sharedPrefsService.getString(SharedPrefsKeys.fcmToken);
  //     final deviceId = sharedPrefsService.getString(SharedPrefsKeys.deviceId);
  //     final Map<String, dynamic> body = {
  //       'contact': isAccountSwitch
  //           ? accountSwitchContact
  //           : int.parse('91${phoneController.text}'),
  //       'location': location,
  //       if (accountType == 'business')
  //         'company': company, // business.businessName
  //       'role': accountType == 'business'
  //           ? validateContactInSecondaryAccess(
  //                   int.parse('91${phoneController.text}'))
  //               ? '2'
  //               : '0'
  //           : '1',
  //       'fcmToken': fcmToken,
  //       'deviceId': deviceId,
  //     };
  //     final UserLoginModel response = await apiService.userLogin(body: body);
  //     if (response.success == true) {
  //       if (response.data != null) {
  //         // * Save User Token
  //         await sharedPrefsService.setString(
  //             SharedPrefsKeys.userToken, response.data!.token!);
  //         // * Save User id
  //         await sharedPrefsService.setString(
  //             SharedPrefsKeys.userId, response.data?.user?.sId ?? '');
  //         // * Save contact
  //         await sharedPrefsService.setString(SharedPrefsKeys.userContact,
  //             AuthTokenHelper.getUserContact().toString());
  //       }
  //       if (isAccountSwitch) {
  //         //* handle while isAccountSwitch is true
  //         //
  //       } else {
  //         // * send otp API call
  //         await sendOtp(
  //           context: context,
  //           mobile: phoneController.text,
  //           accountType: accountType,
  //           isNavigateToOtpPage: true,
  //         );
  //         phoneController.clear();
  //       }
  //     } else {
  //       debugPrint('User login Message: ${response.message}');
  //     }
  //   } catch (error) {
  //     log("Error during User login Response: $error");
  //     if (error is DioException) {
  //       final apiError = ApiGlobalModel.fromJson(error.response?.data ?? {});
  //       customSnackBar(
  //         context: context,
  //         message: apiError.message ?? 'An error occurred',
  //         backgroundColor: AppColors.seaShell,
  //         textColor: AppColors.primaryColor,
  //       );
  //     } else {
  //       customSnackBar(
  //         context: context,
  //         message: 'An unexpected error occurred',
  //         backgroundColor: AppColors.seaShell,
  //         textColor: AppColors.primaryColor,
  //       );
  //     }
  //   } finally {
  //     _isLoading = false;
  //     notifyListeners();
  //   }
  // }

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
        //* OTP Snackbar TEMP
        // customSnackBar(
        //   context: context,
        //   message: 'Your OTP is: ${response.data.toString()}',
        //   duration: const Duration(seconds: 60),
        //   backgroundColor: AppColors.seaShell,
        //   textColor: AppColors.primaryColor,
        // );
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
