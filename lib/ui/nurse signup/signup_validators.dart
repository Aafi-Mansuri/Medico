import '../../utils/regex.dart';

class Validators {
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter an email address';
    }

    if (!RegexConstants.emailRegex.hasMatch(value)) {
      return 'Please enter a valid email address';
    }

    return null; // Return null if input is valid
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a password';
    }

    if (!RegexConstants.passwordRegex.hasMatch(value)) {
      return 'Please enter a valid password:\nminimum 8 characters\nat least one letter \nat least one number';
    }

    return null; // Return null if input is valid
  }

  static String? validateConfirmPassword(String? value, String password) {
    if (value == null || value.isEmpty) {
      return 'Please enter the confirm password';
    }

    if (password != value) {
      return 'Password does not match';
    }

    return null; // Return null if input is valid
  }

  static String? validateFirstName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a first name';
    }

    if (!RegexConstants.firstNameRegex.hasMatch(value)) {
      return 'Please enter a valid first name';
    }

    return null; // Return null if input is valid
  }

  static String? validateLastName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a last name';
    }

    if (!RegexConstants.lastNameRegex.hasMatch(value)) {
      return 'Please enter a valid last name';
    }

    return null; // Return null if input is valid
  }

  static String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a phone number';
    }

    if (!RegexConstants.phoneNumberRegex.hasMatch(value)) {
      return 'Please enter a valid phone number (10 digits)';
    }

    return null; // Return null if input is valid
  }

  static String? validateAddressLine1(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter address line 1';
    }

    if (!RegexConstants.addressLine1Regex.hasMatch(value)) {
      return 'Please enter a valid address line 1';
    }

    return null; // Return null if input is valid
  }

  static String? validateAddressLine2(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter address line 1';
    }
    if (!RegexConstants.addressLine2Regex.hasMatch(value)) {
      return 'Please enter a valid address line 2';
    }

    return null; // Return null if input is valid
  }

  static String? validateCity(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a city';
    }

    if (!RegexConstants.cityRegex.hasMatch(value)) {
      return 'Please enter a valid city';
    }

    return null; // Return null if input is valid
  }

  static String? validateState(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a state';
    }

    if (!RegexConstants.stateRegex.hasMatch(value)) {
      return 'Please enter a valid state';
    }

    return null; // Return null if input is valid
  }

  static String? validateWorkExperience(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter the work experience year';
    }

    int? years;
    try {
      years = int.parse(value);
    } catch (_) {
      return 'Please enter a valid work experience year';
    }

    if (years <= 0) {
      return 'Please enter a valid work experience year';
    }

    return null; // Return null if input is valid
  }

  static String? validateSpecialization(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a specialization';
    }

    return null; // Return null if input is valid
  }
}
