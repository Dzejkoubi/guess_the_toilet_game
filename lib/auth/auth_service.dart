import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final SupabaseClient _supabase = Supabase.instance.client;

  // Sign in with email and password
  Future<AuthResponse> signInWithEmailPassword(
      String email, String password) async {
    return await _supabase.auth
        .signInWithPassword(password: password, email: email);
  }
  // Sign up with email and password

  Future<AuthResponse> signUpWithEmailPassword(
      String email, String password) async {
    return await _supabase.auth.signUp(password: password, email: email);
  }

  // Sign out

  Future<void> signOut() async {
    await _supabase.auth.signOut();
  }

  // Get user email

  String? getCurrentUserEmail() {
    final session = _supabase.auth.currentSession;
    final user = session?.user;
    return user?.email;
  }

  // Sign up as a guest
  Future<AuthResponse> signUpAsGuest() async {
    return await _supabase.auth.signInAnonymously();
  }
}
