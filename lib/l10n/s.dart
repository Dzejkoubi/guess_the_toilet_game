import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 's_cs.dart';
import 's_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of S
/// returned by `S.of(context)`.
///
/// Applications need to include `S.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/s.dart';
///
/// return MaterialApp(
///   localizationsDelegates: S.localizationsDelegates,
///   supportedLocales: S.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the S.supportedLocales
/// property.
abstract class S {
  S(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static S of(BuildContext context) {
    return Localizations.of<S>(context, S)!;
  }

  static const LocalizationsDelegate<S> delegate = _SDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('cs')
  ];

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get language;

  /// No description provided for @welcome_text_1.
  ///
  /// In en, this message translates to:
  /// **'Toilet'**
  String get welcome_text_1;

  /// No description provided for @welcome_text_2.
  ///
  /// In en, this message translates to:
  /// **'Guesser'**
  String get welcome_text_2;

  /// No description provided for @register_title.
  ///
  /// In en, this message translates to:
  /// **'Create an account'**
  String get register_title;

  /// No description provided for @input_email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get input_email;

  /// No description provided for @input_password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get input_password;

  /// No description provided for @input_confirm_password.
  ///
  /// In en, this message translates to:
  /// **'Confirm password'**
  String get input_confirm_password;

  /// No description provided for @input_name.
  ///
  /// In en, this message translates to:
  /// **'Username'**
  String get input_name;

  /// No description provided for @sign_up_with_email.
  ///
  /// In en, this message translates to:
  /// **'Sign up with email'**
  String get sign_up_with_email;

  /// No description provided for @continue_with_apple.
  ///
  /// In en, this message translates to:
  /// **'Continue with Apple'**
  String get continue_with_apple;

  /// No description provided for @continue_with_google.
  ///
  /// In en, this message translates to:
  /// **'Continue with Google'**
  String get continue_with_google;

  /// No description provided for @login_with_email.
  ///
  /// In en, this message translates to:
  /// **'Log in with email'**
  String get login_with_email;

  /// No description provided for @registered.
  ///
  /// In en, this message translates to:
  /// **'Already registered? Log in'**
  String get registered;

  /// No description provided for @login_title.
  ///
  /// In en, this message translates to:
  /// **'Login page'**
  String get login_title;

  /// No description provided for @register_guest_sign_up.
  ///
  /// In en, this message translates to:
  /// **'Sign up as a guest'**
  String get register_guest_sign_up;

  /// No description provided for @successfully_logged_out.
  ///
  /// In en, this message translates to:
  /// **'Successfully logged out'**
  String get successfully_logged_out;

  /// No description provided for @caught_error.
  ///
  /// In en, this message translates to:
  /// **'Error: {error}'**
  String caught_error(String error);

  /// No description provided for @caught_error_invalid_credentials.
  ///
  /// In en, this message translates to:
  /// **'Invalid credentials'**
  String get caught_error_invalid_credentials;

  /// No description provided for @caught_error_email_already_registered.
  ///
  /// In en, this message translates to:
  /// **'Email already registered'**
  String get caught_error_email_already_registered;

  /// No description provided for @caught_error_email_empty.
  ///
  /// In en, this message translates to:
  /// **'Input the email'**
  String get caught_error_email_empty;

  /// No description provided for @caught_error_password_empty.
  ///
  /// In en, this message translates to:
  /// **'Input the password'**
  String get caught_error_password_empty;

  /// No description provided for @caught_error_passwords_mismatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get caught_error_passwords_mismatch;

  /// No description provided for @caught_error_email_invalid.
  ///
  /// In en, this message translates to:
  /// **'Invalid email'**
  String get caught_error_email_invalid;

  /// No description provided for @caught_error_password_length.
  ///
  /// In en, this message translates to:
  /// **'Password too short (min. 6 chars)'**
  String get caught_error_password_length;

  /// No description provided for @caught_error_username_empty.
  ///
  /// In en, this message translates to:
  /// **'Enter your username'**
  String get caught_error_username_empty;

  /// No description provided for @caught_error_username_too_short.
  ///
  /// In en, this message translates to:
  /// **'Password is too short (min. 3 chars)'**
  String get caught_error_username_too_short;

  /// No description provided for @caught_error_username_too_long.
  ///
  /// In en, this message translates to:
  /// **'Password is too long (max. 20 chars)'**
  String get caught_error_username_too_long;

  /// No description provided for @caught_error_username_invalid.
  ///
  /// In en, this message translates to:
  /// **'Invalid username'**
  String get caught_error_username_invalid;

  /// No description provided for @caught_error_new_username_same_as_current_username.
  ///
  /// In en, this message translates to:
  /// **'New username is same as the old one'**
  String get caught_error_new_username_same_as_current_username;

  /// No description provided for @caught_error_new_email_same_as_current_email.
  ///
  /// In en, this message translates to:
  /// **'New email is same as the old one'**
  String get caught_error_new_email_same_as_current_email;

  /// No description provided for @notification_changed_email_successfully.
  ///
  /// In en, this message translates to:
  /// **'Confirm the change in the old email'**
  String get notification_changed_email_successfully;

  /// No description provided for @notification_changed_username_successfully.
  ///
  /// In en, this message translates to:
  /// **'Username has been successfully changed'**
  String get notification_changed_username_successfully;

  /// No description provided for @game__wrong_toilet.
  ///
  /// In en, this message translates to:
  /// **'Wrong Toilet'**
  String get game__wrong_toilet;

  /// No description provided for @game__time_s_up.
  ///
  /// In en, this message translates to:
  /// **'Time\\\'s up!'**
  String get game__time_s_up;

  /// No description provided for @leaderboard__title.
  ///
  /// In en, this message translates to:
  /// **'Leaderboard'**
  String get leaderboard__title;

  /// No description provided for @roadmap_title.
  ///
  /// In en, this message translates to:
  /// **'Roadmap'**
  String get roadmap_title;

  /// No description provided for @game_wrong_toilet.
  ///
  /// In en, this message translates to:
  /// **'Wrong Toilet'**
  String get game_wrong_toilet;

  /// No description provided for @profile__profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile__profile;

  /// No description provided for @profile__confirm_logout.
  ///
  /// In en, this message translates to:
  /// **'confirm logout'**
  String get profile__confirm_logout;

  /// No description provided for @profile__logout_confirmation.
  ///
  /// In en, this message translates to:
  /// **'Do you really want to log out?'**
  String get profile__logout_confirmation;

  /// No description provided for @profile__cancel_logout.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get profile__cancel_logout;

  /// No description provided for @profile__logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get profile__logout;

  /// No description provided for @profile__change_email.
  ///
  /// In en, this message translates to:
  /// **'Change Email'**
  String get profile__change_email;

  /// No description provided for @profile__change.
  ///
  /// In en, this message translates to:
  /// **'Change'**
  String get profile__change;

  /// No description provided for @profile__close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get profile__close;

  /// No description provided for @profile__enter_new_email.
  ///
  /// In en, this message translates to:
  /// **'Enter new email'**
  String get profile__enter_new_email;

  /// No description provided for @profile__change_username.
  ///
  /// In en, this message translates to:
  /// **'Change username'**
  String get profile__change_username;

  /// No description provided for @profile__input_new_username.
  ///
  /// In en, this message translates to:
  /// **'Input new username'**
  String get profile__input_new_username;

  /// No description provided for @profile__username.
  ///
  /// In en, this message translates to:
  /// **'Username: {username}'**
  String profile__username(String username);

  /// No description provided for @profile__current_level.
  ///
  /// In en, this message translates to:
  /// **'Level: {level}'**
  String profile__current_level(int level);

  /// No description provided for @leaderboard__refresh_button.
  ///
  /// In en, this message translates to:
  /// **'Try Again'**
  String get leaderboard__refresh_button;

  /// No description provided for @leader__no_data_available.
  ///
  /// In en, this message translates to:
  /// **'No leaderboard data available'**
  String get leader__no_data_available;

  /// No description provided for @leader__unknown.
  ///
  /// In en, this message translates to:
  /// **'Unknown'**
  String get leader__unknown;

  /// No description provided for @game__time_indicator.
  ///
  /// In en, this message translates to:
  /// **'{remaining_time} s'**
  String game__time_indicator(Object remaining_time);
}

class _SDelegate extends LocalizationsDelegate<S> {
  const _SDelegate();

  @override
  Future<S> load(Locale locale) {
    return SynchronousFuture<S>(lookupS(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['cs', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_SDelegate old) => false;
}

S lookupS(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'cs': return SCs();
    case 'en': return SEn();
  }

  throw FlutterError(
    'S.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
