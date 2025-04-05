import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:guess_the_toilet/app/router/router.gr.dart';
import 'package:guess_the_toilet/services/auth/auth_service.dart';
import 'package:guess_the_toilet/l10n/s.dart';
import 'package:guess_the_toilet/screens/register_screen/button_widget.dart';
import 'package:guess_the_toilet/services/user_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

@RoutePage()
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  // Get services
  final authService = AuthService();
  final UserService _userService = UserService();

  // Credentials controllers
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _usernameController = TextEditingController();

  // *Sign up button*
  void signUp() async {
    // Text from text Controllers
    final email = _emailController.text;
    final password = _passwordController.text;
    final confirmPassword = _confirmPasswordController.text;
    final username = _usernameController.text;

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
    // Validate password using _userService
    // If validPassword isValid is false: show showValidation error with the error message from the first true if statement in _userService
    if (!_userService
        .validatePassword(
          password: password,
          confirmPassword: confirmPassword,
          context: context,
        )
        .isValid) {
      _userService.showValidationError(
        context,
        _userService
            .validatePassword(
              password: password,
              confirmPassword: confirmPassword,
              context: context,
            )
            .errorMessage!,
      );
      return;
    }
    // Validate username using _userService
    // If validUsername isValid is false: show showValidation error with the error message from the first true if statement in _userService
    if (!_userService
        .validateUsername(username: username, context: context)
        .isValid) {
      _userService.showValidationError(
        context,
        _userService
            .validateUsername(
              username: username,
              context: context,
            )
            .errorMessage!,
      );
      return;
    }

    // If credentials are correct try:
    try {
      await authService.signUpWithEmailPassword(email, password);
    }
    // Catch any error
    catch (e) {
      // Catch error
      if (mounted) {
        // Getting the error and writing it to the user
        if (e is AuthException) {
          // Extract the error message
          String errorMessage = e.message;
          if (errorMessage.contains('User already registered')) {
            _userService.showValidationError(
                context, S.of(context).caught_error_email_already_registered);
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

  void signUpAsGuest() async {
    try {
      await authService.signUpAsGuest();
    }

    // Catch any error
    catch (e) {
      if (mounted) {
        _userService.showValidationError(
            context, S.of(context).caught_error(e.toString()));
      }
      return;
    }
    AutoRouter.of(context).popAndPush(AuthGate());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).register_title.toUpperCase(),
            style: Theme.of(context).textTheme.titleLarge),
        automaticallyImplyLeading: false,
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
              ButtonWidget(
                S.of(context).sign_up_with_email,
                signUp,
              ),
              TextButton(
                onPressed: () {
                  AutoRouter.of(context).push(LoginRoute());
                },
                child: Text(
                  S.of(context).registered,
                  style: Theme.of(context).textTheme.labelLarge,
                ),
              ),
              Expanded(child: SizedBox()),
              ButtonWidget(
                S.of(context).register_guest_sign_up,
                signUpAsGuest,
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
