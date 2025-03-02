import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:guess_the_toilet/app/router/router.gr.dart';
import 'package:guess_the_toilet/auth/auth_service.dart';
import 'package:guess_the_toilet/l10n/s.dart';
import 'package:guess_the_toilet/screens/register_screen/google_button_widget.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'apple_button_widget.dart';

@RoutePage()
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  // Get auth service
  final authService = AuthService();

  // Login credentials controllers
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _usernameController = TextEditingController();

  // Error message saving
  String? errorMessage;

  // *Sign up button*
  void signUp() async {
    final email = _emailController.text;
    final password = _passwordController.text;
    final confirmPassword = _confirmPasswordController.text;
    final username = _usernameController.text;
    // Checks the conditions for the valid credentials
    if (email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(S.of(context).register__error_email_empty),
        ),
      );
      return;
    } else if (!_isValidEmail(email)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(S.of(context).register__error_email_invalid),
        ),
      );
      return;
    } else if (password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            S.of(context).register__error_password_empty,
          ),
        ),
      );
      return;
    } else if (password.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(S.of(context).register__error_password_length),
        ),
      );
      return;
    } else if (confirmPassword != password) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(S.of(context).register__error_passwords_mismatch),
        ),
      );
      return;
    } else if (username.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(S.of(context).register__error_username_empty),
        ),
      );
      return;
    }
    // A Attempt sign up
    try {
      await authService.signUpWithEmailPassword(email, password);
    }

    // Catch any error
    catch (e) {
      if (mounted) {
        // Getting the error and writing it to the user
        if (e is AuthException) {
          // Extract the error message
          String errorMessage = e.message;
          if (errorMessage.contains('User already registered')) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content:
                  Text(S.of(context).register__error_email_already_registered),
            ));
          } else {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(S.of(context).caught_error(errorMessage)),
            ));
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(S.of(context).caught_error(e.toString())),
          ));
        }
      }
      return;
    }
    AutoRouter.of(context).popAndPush(ProfileRoute());
  }

  // Validate email
  bool _isValidEmail(String email) {
    final emailRegex =
        RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");
    return emailRegex.hasMatch(email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).register__title.toUpperCase(),
            style: Theme.of(context).textTheme.titleLarge),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            for (var widget in [
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  hintText: S.of(context).input_email,
                ),
                autocorrect: false,
              ),
              TextField(
                controller: _passwordController,
                decoration: InputDecoration(
                  hintText: S.of(context).input_password,
                ),
                autocorrect: false,
                obscureText: true,
              ),
              TextField(
                controller: _confirmPasswordController,
                decoration: InputDecoration(
                  hintText: S.of(context).input_confirm_password,
                ),
                autocorrect: false,
                obscureText: true,
              ),
              TextField(
                controller: _usernameController,
                decoration: InputDecoration(
                  hintText: S.of(context).input_name,
                ),
                autocorrect: false,
              ),
              Container(
                  height: 54,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white,
                  ),
                  child: TextButton(
                    style: ButtonStyle(
                      shape: WidgetStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                    onPressed: () {
                      signUp();
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(S.of(context).sign_up_with_email,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            )),
                      ],
                    ),
                  )),
              AppleBtn(onPressed: () {}),
              GoogleBtn(onPressed: () {}),
              TextButton(
                onPressed: () {
                  AutoRouter.of(context).push(LoginRoute());
                },
                child: Text(
                  S.of(context).registered,
                  style: Theme.of(context).textTheme.labelLarge,
                ),
              ),
            ]) ...[
              widget,
              SizedBox(height: 16),
            ],
          ],
        ),
      ),
    );
  }
}
