import 'package:flutter/material.dart';
import 'package:guess_the_toilet/app/router/router.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:guess_the_toilet/l10n/s.dart';
import 'package:guess_the_toilet/theme/theme.dart';
import 'package:flame/game.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  // make sure you don't initiate your router
  // inside of the build function.
  final _appRouter = AppRouter();

  App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Toilet Guessser',
      debugShowCheckedModeBanner: false,
      routerConfig: _appRouter.config(),
      localizationsDelegates: const [
        S.delegate, // Generated file from the l10n.yaml
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'), // English
        Locale('cs'), // Czech
      ],
      locale: const Locale('en'),
      // Theme
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
    );
  }
}
