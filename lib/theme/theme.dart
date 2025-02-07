import 'package:flutter/material.dart';

class AppTheme {
  // 🎨 Colors
  static const Color primaryColor = Color(0xFFBDBDBD);
  static const Color primaryColorDark = Color(0xFF222222);
  static const Color secondaryColor = Color(0xFF424242);
  static const Color tertiaryColor = Color(0xFFFFFFFF);
  static const Color accentColor = Color(0xFF388E3C);
  static const Color errorColor = Color(0xFFD32F2F);

  // ** Base Text Styles **
  static final TextTheme baseTextTheme = TextTheme(
    //Display large - app welcom, title large - titles,
    //Body large - main text, body medium - secondary text
    //Label large - labels(not signed up)

    displayLarge: TextStyle(
      fontWeight: FontWeight.bold,
    ),
    titleLarge: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
    ),
    titleMedium: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
    bodyLarge: TextStyle(
      fontSize: 18,
    ),
    bodyMedium: TextStyle(
      fontSize: 16,
    ),
  );

  // ** Base Theme  **
  static final ThemeData baseTheme = ThemeData(
    textTheme: baseTextTheme,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: accentColor, // Default button color
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20), // Default corner radius
        ),
        padding: const EdgeInsets.symmetric(
            vertical: 12, horizontal: 24), // Button padding
        textStyle: baseTextTheme
            .titleMedium, // Use titleMedium as the button text style
      ),
    ),
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
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
        textStyle: baseTextTheme.bodySmall,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: tertiaryColor,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: secondaryColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: accentColor, width: 2),
      ),
      hintStyle: baseTextTheme.bodyMedium?.copyWith(color: Colors.grey),
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
        borderSide: const BorderSide(color: accentColor, width: 2),
      ),
    ),
  );
}
