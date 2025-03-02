/*

unauthenticated -> login page

authenticated -> profile page

*/

import 'package:flutter/material.dart';
import 'package:guess_the_toilet/app/router/router.gr.dart';
import 'package:guess_the_toilet/screens/register_screen/profile_screen.dart';
import 'package:guess_the_toilet/screens/register_screen/register_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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
              child: const CircularProgressIndicator.adaptive(),
            ),
          );
        }
        final session = snapshot.hasData ? snapshot.data!.session : null;

        if (session != null) {
          return ProfileScreen();
        } else {
          return RegisterScreen();
        }
      },
    );
  }
}
