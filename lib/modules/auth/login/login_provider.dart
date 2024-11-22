import 'package:flutter/material.dart';

class LoginProvider extends ChangeNotifier {
  String selectedCountryCode = '+91'; // Default country code
  final TextEditingController phoneController = TextEditingController();

  onChangeCountryCode(value) {
    selectedCountryCode = value!;
    notifyListeners();
  }

  final List<String> countryCodes = [
    '+1',
    '+91',
    '+44',
    '+61',
    '+81'
  ]; // Add more codes as needed
}
