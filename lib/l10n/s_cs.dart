// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 's.dart';

// ignore_for_file: type=lint

/// The translations for Czech (`cs`).
class SCs extends S {
  SCs([String locale = 'cs']) : super(locale);

  @override
  String get language => 'Čeština';

  @override
  String get welcome_text_1 => 'Toilet';

  @override
  String get welcome_text_2 => 'Guesser';

  @override
  String get register__title => 'Vytvořit účet';

  @override
  String get input_email => 'Email';

  @override
  String get input_password => 'Heslo';

  @override
  String get input_confirm_password => 'Potvrďte heslo';

  @override
  String get input_name => 'Přezdívka';

  @override
  String get sign_up_with_email => 'Zaregistorovat emailem';

  @override
  String get continue_with_apple => 'Pokračovat s Applem';

  @override
  String get continue_with_google => 'Pokračovat s Googlem';

  @override
  String get login_with_email => 'Přihlásit přes email';

  @override
  String get registered => 'Máte již účet? Přihlásit se';

  @override
  String get register__error_email_empty => 'Zadejte email';

  @override
  String get register__error_password_empty => 'Input the password';

  @override
  String get register__error_passwords_mismatch => 'Passwords do not match';

  @override
  String get register__error_email_invalid => 'Invalid email';

  @override
  String get register__error_password_length => 'Password too short (min. 6 chars)';

  @override
  String get register__error_username_empty => 'Enter your username';

  @override
  String get login__title => 'Login page';

  @override
  String get login__login_with_email => 'Login with email';

  @override
  String caught_error(String error) {
    return 'Error: $error';
  }

  @override
  String get login__error_invalid_credentials => 'Invalid credentials';

  @override
  String get register__error_email_already_registered => 'Email already registered';

  @override
  String get profile__successfully_logged_out => 'Successfully logged out';

  @override
  String get register__guest_sign_up => 'Sign up as a guest';
}
