import 'app_localization.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get language => 'English';

  @override
  String get appTitle => 'Guess The Toilet';

  @override
  String get guestSignIn => 'Sign in as guest';

  @override
  String get googleSignIn => 'Sign in with Google';

  @override
  String get appleSignIn => 'Sign in with Apple';

  @override
  String hello(String username) {
    return 'Hello $username';
  }
}
