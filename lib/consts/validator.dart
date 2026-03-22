class MyValidator {
  static String? displayNamevalidator(String? displayName) {
    if (displayName == null || displayName.isEmpty) {
      return "Display name cannot be empty";
    }
    if (displayName.length < 3 || displayName.length > 20) {
      return "Display name must be between 3 and 20 characters";
    }
    return null;
  }

  static String? emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Display name cannot be empty";
    }
    if (!RegExp(r'\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}\b')
        .hasMatch(value)) {
      return "Please entre a valid email";
    }
    return null;
  }

  static String? passwordValidaor(String? value) {
    if (value!.isEmpty) {
      return "Please entre a Password";
    }
    if (value.length < 6) {
      return "Please must be at least 6 characters long";
    }
    return null;
  }

  static String? repeatPasswordvalidator({String? value, String? password}) {
    if (value != password) {
      return "Passwoords do not match";
    }
    return null;
  }

  static String? uploadProdTexts({String? value, String? tobeReturnedString}) {
    if (value!.isEmpty) {
      return tobeReturnedString;
    }

    return null;
  }
}
