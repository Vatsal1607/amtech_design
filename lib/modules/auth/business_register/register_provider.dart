import 'dart:developer';

import 'package:amtech_design/models/api_error_model.dart';
import 'package:amtech_design/models/personal_register_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../../services/network/api_service.dart';

class RegisterProvider extends ChangeNotifier {
  //! Business account controllers
  TextEditingController businessNameController = TextEditingController();
  TextEditingController businessOwnerController = TextEditingController();
  TextEditingController businessAddressController = TextEditingController();
  TextEditingController businessMobileController = TextEditingController();

  //! Personal account controllers
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController personalAddressController = TextEditingController();
  TextEditingController personalMobileController = TextEditingController();

  @override
  void dispose() {
    businessNameController.dispose();
    businessOwnerController.dispose();
    businessAddressController.dispose();
    businessMobileController.dispose();
    //
    firstNameController.dispose();
    lastNameController.dispose();
    personalAddressController.dispose();
    personalMobileController.dispose();
    super.dispose();
  }

  String? selectedPropertyStatus;

  List<String> propertyStatusItems = ['Owner', 'Rental'];

  onChangePropertyStatus(String? newValue) {
    selectedPropertyStatus = newValue;
    notifyListeners();
  }

  final personalFormKey = GlobalKey<FormState>(); // Key to identify the form
  final businessFormKey = GlobalKey<FormState>(); // Key to identify the form

  final ApiService apiService = ApiService();

  PersonalRegisterModel? _personalRegisterModel;
  bool _isLoading = false;

  PersonalRegisterModel? get personalRegisterModel => _personalRegisterModel;
  bool get isLoading => _isLoading;

  // Api method (personal register)
  Future<void> personalRegister(context) async {
    _isLoading = true;
    notifyListeners();

    try {
      _personalRegisterModel = await apiService.personalRegister({
        'firstName': firstNameController.text,
        'lastName': lastNameController.text,
        'contact': personalMobileController.text,
        'address': personalAddressController.text,
      });
      log('Personal Register log: $_personalRegisterModel');
      if (_personalRegisterModel?.success == true) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              '${_personalRegisterModel?.message.toString()}',
            ),
          ),
        );
      }
    } catch (e) {
      log("personalRegister Error: $e");
      if (e is DioException) {
        // Extract ApiError from DioError
        final apiError = ApiErrorModel.fromJson(e.response?.data ?? {});
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(apiError.message.toString())),
        );
      } else {
        // Handle other errors
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('An unexpected error occurred')),
        );
      }
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
