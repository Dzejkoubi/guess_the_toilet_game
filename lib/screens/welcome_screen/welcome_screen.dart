import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:guess_the_toilet/l10n/s.dart';

@RoutePage()
class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
        body: Center(
      child: Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Display Text
              Text("displayLarge", style: textTheme.displayLarge),
              Text("displayMedium", style: textTheme.displayMedium),
              Text("displaySmall", style: textTheme.displaySmall),
              Divider(),

              // Headline Text
              Text("headlineLarge", style: textTheme.headlineLarge),
              Text("headlineMedium", style: textTheme.headlineMedium),
              Text("headlineSmall", style: textTheme.headlineSmall),
              Divider(),

              // Title Text
              Text("titleLarge", style: textTheme.titleLarge),
              Text("titleMedium", style: textTheme.titleMedium),
              Text("titleSmall", style: textTheme.titleSmall),
              Divider(),

              // Body Text
              Text("bodyLarge", style: textTheme.bodyLarge),
              Text("bodyMedium", style: textTheme.bodyMedium),
              Text("bodySmall", style: textTheme.bodySmall),
              Divider(),

              // Label Text
              Text("labelLarge", style: textTheme.labelLarge),
              Text("labelMedium", style: textTheme.labelMedium),
              Text("labelSmall", style: textTheme.labelSmall),
            ],
          ),
          Expanded(
            child: SizedBox(),
          ),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    S.of(context).welcome_text_1,
                    style: Theme.of(context).textTheme.bodyLarge,
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    S.of(context).welcome_text_2,
                    style: Theme.of(context).textTheme.bodyLarge,
                  )
                ],
              ),
            ],
          ),
          Expanded(
            child: SizedBox(),
          ),
          Text(S.of(context).welcome__continue_as_guest),
          Expanded(
            child: SizedBox(),
          ),
          GoogleBtn1(
            onPressed: () {},
          ),
          AppleBtn1(
            onPressed: () {},
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    ));
  }
}

class GoogleBtn1 extends StatelessWidget {
  final Function() onPressed;
  const GoogleBtn1({
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 54,
        margin: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
        ),
        child: TextButton(
          style: ButtonStyle(
              shape: WidgetStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)))),
          onPressed: onPressed,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network(
                "https://firebasestorage.googleapis.com/v0/b/flutterbricks-public.appspot.com/o/crypto%2Fsearch%20(2).png?alt=media&token=24a918f7-3564-4290-b7e4-08ff54b3c94c",
                width: 20,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(S.of(context).welcome__continue_with_google,
                  style: TextStyle(color: Colors.black, fontSize: 16)),
            ],
          ),
        ));
  }
}

class AppleBtn1 extends StatelessWidget {
  final Function() onPressed;
  const AppleBtn1({
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 54,
        margin: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
        ),
        child: TextButton(
          style: ButtonStyle(
              shape: WidgetStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)))),
          onPressed: onPressed,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network(
                "https://firebasestorage.googleapis.com/v0/b/flutterbricks-public.appspot.com/o/socials%2Fapple-black-logo.png?alt=media&token=c44581fa-6fd2-4ae2-bd85-18bfbe6386d2",
                width: 20,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(S.of(context).welcome__continue_with_apple,
                  style: TextStyle(color: Colors.black, fontSize: 16)),
            ],
          ),
        ));
  }
}
