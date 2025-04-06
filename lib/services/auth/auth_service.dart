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

  Future<AuthResponse> signUpWithEmailPassword(String email, String password,
      {String? username}) async {
    // Create the auth user
    final response = await _supabase.auth.signUp(
      password: password,
      email: email,
      data: {
        'username': username, // Store username in user metadata
      },
    );
    // If signup successful and username provided, update profile
    if (response.user != null && username != null) {
      try {
        await _supabase
            .from('profiles')
            .update({'username': username}).eq('id', response.user!.id);
      } catch (e) {
        print('Error updating profile: $e');
        // Continue anyway since the user was created
      }
    }
    return response;
  }

  // Sign out

  Future<void> signOut() async {
    await _supabase.auth.signOut();
  }

  // Get user id
  String? getCurrentUserId() {
    final session = _supabase.auth.currentSession;
    final user = session?.user;
    return user?.id;
  }

  // Get user email
  String? getCurrentUserEmail() {
    final session = _supabase.auth.currentSession;
    final user = session?.user;
    return user?.email;
  }

  // Get user name from profile database
  Future<String> getCurrentUsername() async {
    final userId = getCurrentUserId();

    // Null safety error
    if (userId == null) {
      throw Exception("User not logged in");
    }

    final response = await _supabase
        .from('profiles')
        .select('username')
        .eq('id', userId)
        .single();

    return response['username'];
  }

  // Update email
  Future<void> updateEmail(String newEmail) async {
    final userId = getCurrentUserId();
    if (userId == null) {
      throw Exception("Cannot update username: User is not logged in");
    }

    await _supabase.auth.updateUser(
      UserAttributes(email: newEmail),
    );
  }

  Future<String> updateUsername(String newUsername) async {
    final userId = getCurrentUserId();

    if (userId == null) {
      throw Exception("Cannot update username: User is not logged in");
    }

    try {
      await _supabase
          .from('profiles')
          .update({'username': newUsername}).eq('id', userId);

      return newUsername;
    } catch (e) {
      throw Exception("Failed to update username: ${e.toString()}");
    }
  }

  // Sign up as a guest
  Future<AuthResponse> signUpAsGuest() async {
    return await _supabase.auth.signInAnonymously();
  }
}
