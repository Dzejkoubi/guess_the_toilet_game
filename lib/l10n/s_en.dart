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
  String get welcome__continue_as_guest => 'Continue as guest';

  @override
  String get welcome__continue_with_google => 'Sign up with Google';

  @override
  String get welcome__continue_with_apple => 'Sign up with Apple';
}
