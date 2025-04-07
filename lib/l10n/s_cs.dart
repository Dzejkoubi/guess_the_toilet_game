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
  String get register_title => 'Vytvořit účet';

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
  String get login_title => 'Přihlášení';

  @override
  String get register_guest_sign_up => 'Pokračovat jako host';

  @override
  String get successfully_logged_out => 'Úspěšně jste se přihlásili';

  @override
  String caught_error(String error) {
    return 'Error: $error';
  }

  @override
  String get caught_error_invalid_credentials => 'Neplatné přihlašovací údaje';

  @override
  String get caught_error_email_already_registered => 'Pod tímto emailem je již založený účet';

  @override
  String get caught_error_email_empty => 'Vyplňte email';

  @override
  String get caught_error_password_empty => 'Vyplňte heslo';

  @override
  String get caught_error_passwords_mismatch => 'Hesla se neshodují';

  @override
  String get caught_error_email_invalid => 'Neplatná emailová adresa';

  @override
  String get caught_error_password_length => 'Heslo je moc krátké (min. 6 chars)';

  @override
  String get caught_error_username_empty => 'Vyplňte jméno';

  @override
  String get caught_error_username_too_short => 'Jméno je příliš krátké (min. 3 chars)';

  @override
  String get caught_error_username_too_long => 'Jméno je příliš dlouhé (max. 20 chars)';

  @override
  String get caught_error_username_invalid => 'Neplatné uživatelské jméno';

  @override
  String get caught_error_new_username_same_as_current_username => 'Nové jméno je stejné jako staré';

  @override
  String get caught_error_new_email_same_as_current_email => 'Nový email je stejný jako ten starý';

  @override
  String get notification_changed_email_successfully => 'Potvrďte změnění ve starém mailu';

  @override
  String get notification_changed_username_successfully => 'Jméno úspěšně změněno';

  @override
  String get game__wrong_toilet => 'Wrong Toilet';

  @override
  String get game__time_s_up => 'Time\\\'s up!';

  @override
  String get leader__leaderboard => 'Leaderboard';
}
