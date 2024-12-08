import 'package:flutter/material.dart';

class LoginProvider extends ChangeNotifier {
  String countryCode = '+91'; // Default country code for mobile
  final TextEditingController phoneController = TextEditingController();

  final formKey = GlobalKey<FormState>();

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
    phoneController.clear();
    phoneController.dispose();
    super.dispose();
  }
}
