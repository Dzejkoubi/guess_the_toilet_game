import 'package:flutter/material.dart';
import 'package:guess_the_toilet/l10n/s.dart';

class ValidationResult {
  final bool isValid;
  final String? errorMessage;
  ValidationResult({required this.isValid, this.errorMessage});
}

class UserService {
// **Email validation**
  ValidationResult validateEmail({
    required String email,
    String? currentEmail,
    required BuildContext context,
  }) {
    // Check if empty
    if (email.isEmpty) {
      return ValidationResult(
          isValid: false, errorMessage: S.of(context).caught_error_email_empty);
    }
    // Check format with regex
    final emailRegex =
        RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");
    if (!emailRegex.hasMatch(email)) {
      return ValidationResult(
          isValid: false,
          errorMessage: S.of(context).caught_error_email_invalid);
    }
    // Check if same as current (for profile updates)
    if (currentEmail != null && email == currentEmail) {
      return ValidationResult(
          isValid: false,
          errorMessage:
              S.of(context).caught_error_new_email_same_as_current_email);
    }
    return ValidationResult(isValid: true);
  }

// **Password validation**
  ValidationResult validatePassword({
    required String password,
    String? confirmPassword,
    required BuildContext context,
  }) {
    // Check if empty
    if (password.isEmpty) {
      return ValidationResult(
          isValid: false,
          errorMessage: S.of(context).caught_error_password_empty);
    }
    // Check length
    if (password.length < 6) {
      return ValidationResult(
          isValid: false,
          errorMessage: S.of(context).caught_error_password_length);
    }
    // Check if passwords match (for registration)
    if (confirmPassword != null && password != confirmPassword) {
      return ValidationResult(
          isValid: false,
          errorMessage: S.of(context).caught_error_passwords_mismatch);
    }
    return ValidationResult(isValid: true);
  }

// **Username validation**
  ValidationResult validateUsername({
    required String username,
    required BuildContext context,
    String? currentUsername,
  }) {
    // Check if empty
    if (username.isEmpty) {
      return ValidationResult(
        isValid: false,
        errorMessage: S.of(context).caught_error_username_empty,
      );
    }

    // Check minimum length
    if (username.length < 3) {
      return ValidationResult(
        isValid: false,
        errorMessage: S.of(context).caught_error_username_too_short,
      );
    }

    // Check maximum length
    if (username.length > 20) {
      return ValidationResult(
        isValid: false,
        errorMessage: S.of(context).caught_error_username_too_long,
      );
    }

    // Check for spaces
    if (username.contains(' ')) {
      return ValidationResult(
        isValid: false,
        errorMessage: S.of(context).caught_error_username_invalid,
      );
    }

    // Check if same as current (for profile updates)
    if (currentUsername != null && username == currentUsername) {
      return ValidationResult(
        isValid: false,
        errorMessage:
            S.of(context).caught_error_new_username_same_as_current_username,
      );
    }

    return ValidationResult(isValid: true);
  }

// **Show error at the bottom of the page**
  void showValidationError(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}
