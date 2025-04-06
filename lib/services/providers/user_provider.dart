import 'package:flutter/material.dart';
import 'package:guess_the_toilet/services/auth/auth_service.dart';

class UserProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();

  String _username = '';
  String _email = '';
  int _currentLevel = 1;
  bool _isLoading = true;
  String? _error;

  // Getters
  String get username => _username;
  String get email => _email;
  int get currentLevel => _currentLevel;
  bool get isLoading => _isLoading;
  String? get error => _error;

  UserProvider() {
    // Load user data when provider is initialized
    loadUserData();
  }

  Future<void> loadUserData() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      // Get current email and username using auth_service
      _email = _authService.getCurrentUserEmail() ?? 'no email';
      _username = await _authService.getCurrentUsername();
      _currentLevel = await _authService.getCurrentLevelNumber();
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> updateEmail(String newEmail) async {
    try {
      await _authService.updateEmail(newEmail);
      return true;
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      return false;
    }
  }

  Future<bool> updateUsername(String newUsername) async {
    try {
      _username = await _authService.updateUsername(newUsername);
      _error = null;
      notifyListeners();
      return true;
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      return false;
    }
  }

  Future<bool> updateCurrentLevelNumber(int newCurrentLevel) async {
    try {
      await _authService.updateCurrentLevelNumber(newCurrentLevel);
      _currentLevel = newCurrentLevel;
      notifyListeners();
      return true;
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      return false;
    }
  }
}
