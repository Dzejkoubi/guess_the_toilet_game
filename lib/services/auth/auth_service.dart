import 'package:guess_the_toilet/services/user_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final SupabaseClient _supabase = Supabase.instance.client;

  UserService _userService = UserService();

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

  // Get user id
  String? getCurrentUserId() {
    final session = _supabase.auth.currentSession;
    final user = session?.user;
    return user?.id;
  }

  // Add username to user to profile database
  Future<void> addUsernameToProfile(String username) async {
    final userId = getCurrentUserId();
    if (userId == null) {
      throw Exception("User ID is null");
    }

    await await _supabase
        .from('profiles')
        .update({'username': username}).eq('id', userId);
  }

  // Get user name from profile database
  Future<String> getUsername() async {
    final userId = getCurrentUserId();
    if (userId == null) {
      throw Exception("User ID is null");
    }

    final response = await _supabase
        .from('profiles')
        .select('username')
        .eq('id', userId)
        .single();

    return response['username'] ?? 'No username found';
  }

  // Sign up as a guest
  Future<AuthResponse> signUpAsGuest() async {
    return await _supabase.auth.signInAnonymously();
  }
}
