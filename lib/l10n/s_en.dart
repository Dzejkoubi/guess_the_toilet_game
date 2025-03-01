// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 's.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class SEn extends S {
  SEn([String locale = 'en']) : super(locale);

  @override
  String get language => 'English';

  @override
  String get welcome_text_1 => 'Toilet';

  @override
  String get welcome_text_2 => 'Guesser';

  @override
  String get account_settings => 'Account settings';

  @override
  String get input_email => 'Email';

  @override
  String get input_password => 'Password';

  @override
  String get input_confirm_password => 'Confirm password';

  @override
  String get input_name => 'Username';

  @override
  String get sign_up_with_email => 'Sign up with email';

  @override
  String get continue_with_google => 'Continue with Google';

  @override
  String get continue_with_apple => 'Continue with Apple';

  @override
  String get login_with_email => 'Log in with email';

  @override
  String get registered => 'Already registered? Log in';

  @override
  String get account__error_email_empty => 'Input the email';

  @override
  String get account__error_password_empty => 'Input the password';

  @override
  String get account__error_passwords_mismatch => 'Passwords do not match';

  @override
  String get account__error_email_invalid => 'Invalid email';

  @override
  String get account__error_password_length => 'Password too short (min. 6 chars)';

  @override
  String get account__error_username_empty => 'Enter your username';
}
