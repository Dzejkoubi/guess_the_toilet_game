/*

unauthenticated -> login page

authenticated -> profile page

*/

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'package:guess_the_toilet/screens/register_screen/register_screen.dart';
import 'package:guess_the_toilet/screens/game_screen/game_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

@RoutePage()
class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      // Listens to an auth state change
      stream: Supabase.instance.client.auth.onAuthStateChange,
      // Shows the appropirate page
      builder: (context, snapshot) {
        // Loading...
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator.adaptive(),
            ),
          );
        }
        final session = snapshot.hasData ? snapshot.data!.session : null;

        // If the user is authenticated, show the profile page
        // Otherwise, show the register page
        if (session != null) {
          return GameScreen();
        } else {
          return const RegisterScreen();
        }
      },
    );
  }
}
