import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:guess_the_toilet/l10n/s.dart';

@RoutePage()
class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).welcome_text_1),
      ),
    );
  }
}

//  // Display Text
//               Text("displayLarge", style: textTheme.displayLarge),
//               Text("displayMedium", style: textTheme.displayMedium),
//               Text("displaySmall", style: textTheme.displaySmall),
//               Divider(),

//               // Headline Text
//               Text("headlineLarge", style: textTheme.headlineLarge),
//               Text("headlineMedium", style: textTheme.headlineMedium),
//               Text("headlineSmall", style: textTheme.headlineSmall),
//               Divider(),

//               // Title Text
//               Text("titleLarge", style: textTheme.titleLarge),
//               Text("titleMedium", style: textTheme.titleMedium),
//               Text("titleSmall", style: textTheme.titleSmall),
//               Divider(),

//               // Body Text
//               Text("bodyLarge", style: textTheme.bodyLarge),
//               Text("bodyMedium", style: textTheme.bodyMedium),
//               Text("bodySmall", style: textTheme.bodySmall),
//               Divider(),

//               // Label Text
//               Text("labelLarge", style: textTheme.labelLarge),
//               Text("labelMedium", style: textTheme.labelMedium),
//               Text("labelSmall", style: textTheme.labelSmall),
