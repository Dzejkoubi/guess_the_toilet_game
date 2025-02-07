import 's.dart';

// ignore_for_file: type=lint

/// The translations for Czech (`cs`).
class SCs extends S {
  SCs([String locale = 'cs']) : super(locale);

  @override
  String get language => 'Čeština';

  @override
  String get welcome_text_1 => 'Záchodové';

  @override
  String get welcome_text_2 => 'Dilema';

  @override
  String get welcome__continue_as_guest => 'Pokračovat bez přihlášení';

  @override
  String get welcome__continue_with_google => 'Pokračovat s Googlem';

  @override
  String get welcome__continue_with_apple => 'Pokračovat s Applem';
}
