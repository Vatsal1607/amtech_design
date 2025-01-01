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
    } else if (value == null ||
        !RegExp(r'Titanium City Center', caseSensitive: false)
            .hasMatch(value)) {
      return "We're delivering only in 'Titanium City Center'";
      // * Changed by AJAY PANCHAL by Backend dev.
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

  // * Email validation
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter an email address';
    }
    // * Regular expression to validate email
    String pattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }
}
