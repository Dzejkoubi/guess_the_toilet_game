import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:guess_the_toilet/auth/auth_service.dart';
import 'package:guess_the_toilet/l10n/s.dart';

@RoutePage()
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Get auth service
  final authService = AuthService();

  // Login credentials controllers
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void login() async {
    // Gets text from controllers
    final email = _emailController.text;
    final password = _passwordController.text;

    // Attempt login...
    try {
      await authService.signInWithEmailPassword(email, password);

      // Catch any errors and show it as a snackBar
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(S.of(context).catch_error(e.toString()))));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            S.of(context).login__title,
          ),
        ),
        body: ListView(
          children: [
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
                  onPressed: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(S.of(context).login__login_with_email,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                          )),
                    ],
                  ),
                )),
          ],
        ));
  }
}
