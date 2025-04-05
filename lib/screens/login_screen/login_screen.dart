import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:guess_the_toilet/app/router/router.gr.dart';
import 'package:guess_the_toilet/services/auth/auth_service.dart';
import 'package:guess_the_toilet/l10n/s.dart';
import 'package:guess_the_toilet/services/user_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

@RoutePage()
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Services
  final authService = AuthService();
  final UserService _userService = UserService();

  // Login credentials controllers
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void login() async {
    // Gets text from controllers
    final email = _emailController.text;
    final password = _passwordController.text;

    // Validate email using _userService
    // If validateEmail isValid is false: show showValidation error with the error message from the first true if statement in _userService
    if (!_userService.validateEmail(email: email, context: context).isValid) {
      _userService.showValidationError(
        context,
        _userService
            .validateEmail(
              email: email,
              context: context,
            )
            .errorMessage!,
      );
      return;
    }
    // Check if password isn't empty
    if (password.isEmpty) {
      _userService.showValidationError(
          context, S.of(context).caught_error_password_empty);
      return;
    }
    try {
      await authService.signInWithEmailPassword(email, password);

      // Catch any errors and show it as a snackBar
    } catch (e) {
      if (mounted) {
        if (e is AuthException) {
          // Extract the error message

          String errorMessage = e.message;
          if (errorMessage.contains('Invalid login credentials')) {
            _userService.showValidationError(
                context, S.of(context).caught_error_invalid_credentials);
          } else {
            _userService.showValidationError(
                context, S.of(context).caught_error(errorMessage));
          }
        } else {
          _userService.showValidationError(
              context, S.of(context).caught_error(e.toString()));
        }
      }
      return;
    }

    AutoRouter.of(context).popAndPush(ProfileRoute());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            S.of(context).login_title,
          ),
        ),
        body: Scaffold(
          body: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  for (var widget in [
                    // email
                    TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        hintText: S.of(context).input_email,
                      ),
                      autocorrect: false,
                    ),
                    // password
                    TextField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                        hintText: S.of(context).input_password,
                      ),
                      autocorrect: false,
                      obscureText: true,
                    ),
                    // Login button
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
                            login();
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(S.of(context).login_with_email,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                  )),
                            ],
                          ),
                        )),
                  ]) ...[
                    widget,
                    SizedBox(height: 16),
                  ],
                ],
              )),
        ));
  }
}
