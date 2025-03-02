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
  String get account_settings => 'Nastavení účtu';

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
  String get continue_with_google => 'Pokračovat s Googlem';

  @override
  String get continue_with_apple => 'Pokračovat s Applem';

  @override
  String get login_with_email => 'Přihlásit přes email';

  @override
  String get registered => 'Máte již účet? Přihlásit se';

  @override
  String get account__error_email_empty => 'Zadejte email';

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

  @override
  String get login__login_with_email => 'Login with email';
}
