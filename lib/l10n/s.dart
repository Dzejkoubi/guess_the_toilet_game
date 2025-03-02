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

  /// No description provided for @register__title.
  ///
  /// In en, this message translates to:
  /// **'Create an account'**
  String get register__title;

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

  /// No description provided for @register__error_email_empty.
  ///
  /// In en, this message translates to:
  /// **'Input the email'**
  String get register__error_email_empty;

  /// No description provided for @register__error_password_empty.
  ///
  /// In en, this message translates to:
  /// **'Input the password'**
  String get register__error_password_empty;

  /// No description provided for @register__error_passwords_mismatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get register__error_passwords_mismatch;

  /// No description provided for @register__error_email_invalid.
  ///
  /// In en, this message translates to:
  /// **'Invalid email'**
  String get register__error_email_invalid;

  /// No description provided for @register__error_password_length.
  ///
  /// In en, this message translates to:
  /// **'Password too short (min. 6 chars)'**
  String get register__error_password_length;

  /// No description provided for @register__error_username_empty.
  ///
  /// In en, this message translates to:
  /// **'Enter your username'**
  String get register__error_username_empty;

  /// No description provided for @login__title.
  ///
  /// In en, this message translates to:
  /// **'Login page'**
  String get login__title;

  /// No description provided for @login__login_with_email.
  ///
  /// In en, this message translates to:
  /// **'Login with email'**
  String get login__login_with_email;

  /// No description provided for @catch_error.
  ///
  /// In en, this message translates to:
  /// **'Error: {error}'**
  String catch_error(String error);
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
