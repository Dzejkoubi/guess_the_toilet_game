import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:guess_the_toilet/app/router/router.gr.dart';
import 'package:guess_the_toilet/l10n/app_localization.dart';

@RoutePage()
class WelcomeScreen extends StatelessWidget {
  WelcomeScreen({super.key});
  String username = 'John Doe';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.hello(username),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                AutoRouter.of(context).push(
                  RoadmapRoute(),
                );
              },
              child: const Text('Go to Roadmap'),
            ),
          ],
        ),
      ),
    );
  }
}
