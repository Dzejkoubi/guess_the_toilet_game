import 'package:flutter/material.dart';

class AppTheme {
  // 🎨 Colors
  static const Color primaryColor = Color(0xFFBDBDBD);
  static const Color primaryColorDark = Color(0xFF222222);
  static const Color secondaryColor = Color(0xFF424242);
  static const Color tertiaryColor = Color(0xFFFFFFFF);
  static const Color accentColor = Color(0xFF388E3C);
  static const Color errorColor = Color(0xFFD32F2F);
  static const Color importantColor = Color.fromARGB(255, 78, 140, 254);

  // ** Base Text Styles **
  static final TextTheme baseTextTheme = TextTheme(
    //Display large - app welcome,
    //Title large - titles
    //Body large - main text
    //Body medium - secondary text
    //Label large - labels (not signed up)

    displayLarge: TextStyle(
      fontFamily: 'Lexend',
      fontWeight: FontWeight.bold,
    ),
    titleLarge: TextStyle(
      fontFamily: 'Lexend',
      fontSize: 24,
      fontWeight: FontWeight.bold,
    ),
    titleMedium: TextStyle(
      fontFamily: 'Lexend',
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
    bodyLarge: TextStyle(
      fontFamily: 'Lexend',
      fontSize: 18,
    ),
    bodyMedium: TextStyle(
      fontFamily: 'Lexend',
      fontSize: 16,
    ),
  );

  // ** Base Theme  **
  static final ThemeData baseTheme = ThemeData(
    textTheme: baseTextTheme,
    // Button for important actions
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: importantColor, // Default button color
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20), // Default corner radius
        ),
        padding: const EdgeInsets.symmetric(
            vertical: 12, horizontal: 24), // Button padding
        textStyle: baseTextTheme
            .titleMedium, // Use titleMedium as the button text style
      ),
    ),
    // Button for secondary actions
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: accentColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        side: const BorderSide(color: accentColor, width: 2),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
        textStyle: baseTextTheme.titleMedium,
      ),
    ),
    // Button for text actions - less noticable links
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
        textStyle: baseTextTheme.bodySmall,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: tertiaryColor,
      errorStyle: baseTextTheme.bodyMedium?.copyWith(color: errorColor),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: secondaryColor, width: 1),
      ),
      hintStyle: baseTextTheme.bodyMedium?.copyWith(color: Colors.grey),
      hintFadeDuration: Duration(milliseconds: 50),
    ),
  );

  // ** Light Theme **
  static final ThemeData lightTheme = baseTheme.copyWith(
    brightness: Brightness.light,
    scaffoldBackgroundColor: primaryColor,
    primaryColor: primaryColorDark,
    textTheme: baseTextTheme.apply(
      bodyColor: primaryColorDark,
      displayColor: primaryColorDark,
    ),
  );

  // ** Dark Theme **
  static final ThemeData darkTheme = baseTheme.copyWith(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: primaryColorDark,
    primaryColor: primaryColor,
    textTheme: baseTextTheme.apply(
      bodyColor: primaryColor,
      displayColor: primaryColor,
    ),
    inputDecorationTheme: baseTheme.inputDecorationTheme.copyWith(
      fillColor: primaryColorDark,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: secondaryColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: primaryColor, width: 2),
      ),
    ),
  );
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

