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
  String get register_title => 'Create an account';

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
  String get continue_with_apple => 'Continue with Apple';

  @override
  String get continue_with_google => 'Continue with Google';

  @override
  String get login_with_email => 'Log in with email';

  @override
  String get registered => 'Already registered? Log in';

  @override
  String get login_title => 'Login page';

  @override
  String get register_guest_sign_up => 'Sign up as a guest';

  @override
  String get successfully_logged_out => 'Successfully logged out';

  @override
  String caught_error(String error) {
    return 'Error: $error';
  }

  @override
  String get caught_error_invalid_credentials => 'Invalid credentials';

  @override
  String get caught_error_email_already_registered => 'Email already registered';

  @override
  String get caught_error_email_empty => 'Input the email';

  @override
  String get caught_error_password_empty => 'Input the password';

  @override
  String get caught_error_passwords_mismatch => 'Passwords do not match';

  @override
  String get caught_error_email_invalid => 'Invalid email';

  @override
  String get caught_error_password_length => 'Password too short (min. 6 chars)';

  @override
  String get caught_error_username_empty => 'Enter your username';

  @override
  String get caught_error_username_too_short => 'Password is too short (min. 3 chars)';

  @override
  String get caught_error_username_too_long => 'Password is too long (max. 20 chars)';

  @override
  String get caught_error_username_invalid => 'Invalid username';

  @override
  String get caught_error_new_username_same_as_current_username => 'New username is same as the old one';

  @override
  String get caught_error_new_email_same_as_current_email => 'New email is same as the old one';

  @override
  String get notification_changed_email_successfully => 'Confirm the change in the old email';

  @override
  String get notification_changed_username_successfully => 'Username has been successfully changed';

  @override
  String get game__wrong_toilet => 'Wrong Toilet';

  @override
  String get game__time_s_up => 'Time\\\'s up!';

  @override
  String get leaderboard__title => 'Leaderboard';

  @override
  String get roadmap_title => 'Roadmap';

  @override
  String get game_wrong_toilet => 'Wrong Toilet';

  @override
  String get profile__profile => 'Profile';

  @override
  String get profile__confirm_logout => 'confirm logout';

  @override
  String get profile__logout_confirmation => 'Do you really want to log out?';

  @override
  String get profile__cancel_logout => 'Cancel';

  @override
  String get profile__logout => 'Logout';

  @override
  String get profile__change_email => 'Change Email';

  @override
  String get profile__change => 'Change';

  @override
  String get profile__close => 'Close';

  @override
  String get profile__enter_new_email => 'Enter new email';

  @override
  String get profile__change_username => 'Change username';

  @override
  String get profile__input_new_username => 'Input new username';

  @override
  String profile__username(String username) {
    return 'Username: $username';
  }

  @override
  String profile__current_level(String level) {
    return 'Level: $level';
  }

  @override
  String get leaderboard__refresh_button => 'Try Again';

  @override
  String get leader__no_data_available => 'No leaderboard data available';

  @override
  String get leader__unknown => 'Unknown';

  @override
  String game__time_indicator(Object remaining_time) {
    return '$remaining_time s';
  }
}
