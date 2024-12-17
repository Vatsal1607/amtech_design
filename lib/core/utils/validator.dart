class Validator {
  // Validator for name
  static String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter your name";
    }
    if (!RegExp(r"^[a-zA-Z\s]+$").hasMatch(value)) {
      return "Name can only contain alphabetic characters";
    }
    return null;
  }

  // Address validator
  static String? validateAddress(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter your Address";
    }
    return null;
  }

  // Validator for phone number
  static String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter your phone number";
    }
    if (!RegExp(r"^\d{10}$").hasMatch(value)) {
      return "Please enter a valid 10-digit phone number";
    }
    return null;
  }

  // Recharge Amount Validator
  static String? rechargeAmountValidator(value) {
    if (value == null || value.isEmpty) {
      return "Please enter an amount";
    }
    final cleanValue = value.replaceAll(',', '');
    final intAmount = int.tryParse(cleanValue);
    if (intAmount == null) {
      return "Invalid number format";
    } else if (intAmount < 500) {
      return "Amount must be at least ₹500";
    } else if (intAmount > 50000) {
      return "Amount cannot exceed ₹50,000";
    }
    return null; // No error
  }
}
