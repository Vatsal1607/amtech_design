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
}
