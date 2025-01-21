import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:guess_the_toilet/app/router/router.gr.dart';

@RoutePage()
class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome'),
      ),
      body: Center(
        child: Column(
          children: [
            const Text('Welcome to the app!'),
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
