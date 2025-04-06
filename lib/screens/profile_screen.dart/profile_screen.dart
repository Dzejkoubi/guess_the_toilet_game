import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:guess_the_toilet/app/router/router.gr.dart';
import 'package:guess_the_toilet/services/auth/auth_service.dart';
import 'package:guess_the_toilet/l10n/s.dart';
import 'package:guess_the_toilet/services/providers/user_provider.dart';
import 'package:guess_the_toilet/services/user_service.dart';
import 'package:provider/provider.dart';

@RoutePage()
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // Get services
  final _authService = AuthService();
  final UserService _userService = UserService();

  // Text editing controllers
  final TextEditingController _changeEmailController = TextEditingController();
  final TextEditingController _changeUsernameController =
      TextEditingController();
  final TextEditingController _changePasswordController =
      TextEditingController();
  final TextEditingController _changePasswordConfirmationController =
      TextEditingController();

  // Log out from your account
  void logout() async {
    await _authService.signOut();

    // Check if the widget is still mounted before accessing context
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(S.of(context).successfully_logged_out),
    ));
  }

  @override
  Widget build(BuildContext context) {
    // Wait for the provider to load
    return Consumer<UserProvider>(
      builder: (context, userProvider, child) {
        if (userProvider.isLoading) {
          return Scaffold(
            appBar: AppBar(title: Text("Profile")),
            body: Center(child: CircularProgressIndicator()),
          );
        }

        return Scaffold(
          // Floating action button for printing when debuging
          // floatingActionButton: FloatingActionButton(onPressed: () async {
          //   int text = await _authService.getCurrentLevelNumber();
          //   print(text.toString());
          // }),
          appBar: AppBar(
            title: Text("Profile"),
            leading: IconButton(
              onPressed: () {
                AutoRouter.of(context).navigate(
                  GameRoute(),
                );
              },
              icon: Icon(Icons.arrow_back),
            ),
            actions: [
              // Log out button and confirmation popup
              IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text(
                          "Confirm Logout",
                        ),
                        content: Text("Do you really want to log out?"),
                        actions: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context)
                                      .pop(); // Close the dialog
                                },
                                child: Text("Cancel"),
                              ),
                              TextButton(
                                onPressed: () {
                                  logout();
                                  Navigator.of(context)
                                      .pop(); // Close the dialog
                                  AutoRouter.of(context).navigate(AuthGate());
                                },
                                child: Text("Logout"),
                              ),
                            ],
                          ),
                        ],
                      );
                    },
                  );
                },
                icon: Icon(Icons.logout),
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: RefreshIndicator(
              // This function is called when the user completes the pull gesture
              onRefresh: () => userProvider.loadUserData(),
              child: ListView(children: [
                Column(
                  children: <Widget>[
                    // Display the user email from provider
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          userProvider.email,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        IconButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text("Change Email"),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      TextField(
                                        controller: _changeEmailController
                                          ..text = userProvider.email,
                                        decoration: InputDecoration(
                                          hintText: "Enter new email",
                                        ),
                                      ),
                                      SizedBox(height: 16),
                                      TextButton(
                                        onPressed: () async {
                                          final validation =
                                              _userService.validateEmail(
                                                  email: _changeEmailController
                                                      .text,
                                                  context: context);
                                          if (!validation.isValid) {
                                            _userService.showValidationError(
                                                context,
                                                validation.errorMessage!);
                                            return;
                                          }
                                          final success =
                                              await userProvider.updateEmail(
                                            _changeEmailController.text,
                                          );
                                          if (success) {
                                            _userService.showValidationError(
                                                context,
                                                S
                                                    .of(context)
                                                    .notification_changed_email_successfully);
                                          }
                                          Navigator.of(context).pop();
                                        },
                                        child: Text("Change"),
                                      ),
                                    ],
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text("Close"),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          icon: Icon(Icons.edit),
                        )
                      ],
                    ),
                    const SizedBox(height: 16),
                    // Display the username from provider
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Text(
                          "Username: ${userProvider.username}",
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        IconButton(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text("Change username"),
                                      content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          TextField(
                                            controller:
                                                _changeUsernameController
                                                  ..text =
                                                      userProvider.username,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyLarge,
                                            autofocus: true,
                                            decoration: InputDecoration(
                                              hintText: "Input new username",
                                            ),
                                          ),
                                          TextButton(
                                            onPressed: () async {
                                              final validation =
                                                  _userService.validateUsername(
                                                      username:
                                                          _changeUsernameController
                                                              .text,
                                                      context: context);
                                              if (!validation.isValid) {
                                                _userService
                                                    .showValidationError(
                                                        context,
                                                        validation
                                                            .errorMessage!);
                                                return;
                                              }
                                              final success = await userProvider
                                                  .updateUsername(
                                                _changeUsernameController.text,
                                              );
                                              if (success) {
                                                _userService.showValidationError(
                                                    context,
                                                    S
                                                        .of(context)
                                                        .notification_changed_username_successfully);
                                              }
                                              Navigator.of(context).pop();
                                            },
                                            child: Text("Change"),
                                          ),
                                        ],
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text("Close"),
                                        ),
                                      ],
                                    );
                                  });
                            },
                            icon: Icon(Icons.edit))
                      ],
                    ),
                    const SizedBox(height: 16),
                    // Show current user level
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Text(
                          "Level: ${userProvider.currentLevel}",
                          style: Theme.of(context).textTheme.bodyLarge,
                        )
                      ],
                    )
                  ],
                ),
              ]),
            ),
          ),
        );
      },
    );
  }
}
