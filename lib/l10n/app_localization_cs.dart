import 'app_localization.dart';

// ignore_for_file: type=lint

/// The translations for Czech (`cs`).
class AppLocalizationsCs extends AppLocalizations {
  AppLocalizationsCs([String locale = 'cs']) : super(locale);

  @override
  String get language => 'Čeština';

  @override
  String get appTitle => 'Záchodové dilema';

  @override
  String get guestSignIn => 'Přihlásit se jako host';

  @override
  String get googleSignIn => 'Přihlásit se přes Google';

  @override
  String get appleSignIn => 'Přihlásit se přes Apple';

  @override
  String hello(String username) {
    return 'Ahoj $username';
  }
}
