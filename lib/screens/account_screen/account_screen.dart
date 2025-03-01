import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:guess_the_toilet/app/router/router.gr.dart';
import 'package:guess_the_toilet/l10n/s.dart';
import 'package:guess_the_toilet/screens/account_screen/google_button_widget.dart';

import 'apple_button_widget.dart';

@RoutePage()
class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final TextEditingController _confirmPasswordController =
      TextEditingController();

  final TextEditingController usernameController = TextEditingController();

  String? errorMessage;

  void _validateInputs() {
    setState(() {
      errorMessage = null;

      String email = _emailController.text.trim();
      String password = _passwordController.text.trim();
      String confirmPassword = _confirmPasswordController.text.trim();
      String username = usernameController.text.trim();

      if (email.isEmpty) {
        errorMessage = S.of(context).account__error_email_empty;
      } else if (!_isValidEmail(email)) {
        errorMessage = S.of(context).account__error_email_invalid;
      } else if (password.isEmpty) {
        errorMessage = S.of(context).account__error_password_empty;
      } else if (password.length < 6) {
        errorMessage = S.of(context).account__error_password_length;
      } else if (confirmPassword != password) {
        errorMessage = S.of(context).account__error_passwords_mismatch;
      } else if (username.isEmpty) {
        errorMessage = S.of(context).account__error_username_empty;
      }
    });
    print(errorMessage);
  }

  bool _isValidEmail(String email) {
    final emailRegex =
        RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");
    return emailRegex.hasMatch(email);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).account_settings.toUpperCase(),
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
                  errorText: errorMessage ==
                          S.of(context).account__error_email_invalid
                      ? S.of(context).account__error_email_invalid
                      : errorMessage == S.of(context).account__error_email_empty
                          ? S.of(context).account__error_email_empty
                          : null,
                ),
                autocorrect: false,
              ),
              TextField(
                controller: _passwordController,
                decoration: InputDecoration(
                  hintText: S.of(context).input_password,
                  errorText: errorMessage ==
                          S.of(context).account__error_password_empty
                      ? S.of(context).account__error_password_empty
                      : errorMessage ==
                              S.of(context).account__error_password_length
                          ? S.of(context).account__error_password_length
                          : null,
                ),
                autocorrect: false,
                obscureText: true,
              ),
              TextField(
                controller: _confirmPasswordController,
                decoration: InputDecoration(
                  hintText: S.of(context).input_confirm_password,
                  errorText: errorMessage ==
                          S.of(context).account__error_passwords_mismatch
                      ? S.of(context).account__error_passwords_mismatch
                      : null,
                ),
                autocorrect: false,
                obscureText: true,
              ),
              TextField(
                controller: usernameController,
                decoration: InputDecoration(
                  hintText: S.of(context).input_name,
                  errorText: errorMessage ==
                          S.of(context).account__error_username_empty
                      ? S.of(context).account__error_username_empty
                      : null,
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
                      _validateInputs();
                      print(_emailController.text);
                      print(_passwordController.text);
                      print(usernameController.text);
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
