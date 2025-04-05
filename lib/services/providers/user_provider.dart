import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  String username;
  String email;
  String get getUsername => username;
  String get getEmail => email;

  UserProvider({this.username = 'username', this.email = 'email'});

  void changeUsername({
    required String newUsername,
  }) async {
    username = newUsername;
    notifyListeners();
  }

  void changeEmail({
    required String newEmail,
  }) async {
    email = newEmail;
    notifyListeners();
  }
}
