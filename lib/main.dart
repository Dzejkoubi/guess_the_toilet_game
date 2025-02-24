import 'package:flutter/material.dart';
import 'package:guess_the_toilet/app/router/router.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:guess_the_toilet/l10n/s.dart';
import 'package:guess_the_toilet/theme/theme.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await Supabase.initialize(
    url: dotenv.env['SUBABASE_URL'] ?? '',
    anonKey: dotenv.env['SUBABASE_ANON_KEY'] ?? '',
  );
  final supabase = Supabase.instance.client;
  final session = supabase.auth.currentSession;
  if (session == null) {
    await supabase.auth.signInAnonymously();
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final _appRouter = AppRouter();

  MyApp({super.key});

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
