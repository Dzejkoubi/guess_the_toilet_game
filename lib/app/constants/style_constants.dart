import 'package:flutter/material.dart';

class AppConstants {
  // Colors - Greyscale Theme
  static const Color primaryColor = Color(0xFFBDBDBD); // Light Grey - Tiles
  static const Color primaryColorAccent = Color(0xFF9E9E9E); // Mid Grey
  static const Color secondaryColor = Color(0xFF757575); // Darker Grey
  static const Color tertiaryColor = Color(0xFF424242); // Very Dark Grey
  static const Color backgroundColor = Color(0xFFF5F5F5); // Off-white - Walls
  static const Color highlightColor = Color(0xFFE0E0E0); // Light Highlight
  static const Color shadowColor = Colors.black26; // Shadow Color
  static const Color borderColor = Color(0xFF616161); // Border color

  // Border Radius
  static const BorderRadius borderRadiusSmall =
      BorderRadius.all(Radius.circular(8));
  static const BorderRadius borderRadiusMedium =
      BorderRadius.all(Radius.circular(16));
  static const BorderRadius borderRadiusLarge =
      BorderRadius.all(Radius.circular(24));

  // Shadows
  static const List<BoxShadow> boxShadow = [
    BoxShadow(
      color: shadowColor,
      blurRadius: 8,
      spreadRadius: 1,
      offset: Offset(0, 4), // Slight shadow for depth
    ),
  ];

  static const List<BoxShadow> subtleShadow = [
    BoxShadow(
      color: shadowColor,
      blurRadius: 3,
      offset: Offset(0, 2), // Subtle shadow
    ),
  ];

  // Padding and Margins
  static const EdgeInsetsGeometry defaultPadding = EdgeInsets.all(16.0);
  static const EdgeInsetsGeometry defaultMargin = EdgeInsets.all(16.0);
  static const EdgeInsetsGeometry smallPadding = EdgeInsets.all(8.0);
  static const EdgeInsetsGeometry largePadding = EdgeInsets.all(24.0);

  // Typography
  static const TextStyle headingStyle = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: tertiaryColor,
  );

  static const TextStyle bodyTextStyle = TextStyle(
    fontSize: 16,
    color: secondaryColor,
  );

  static const TextStyle captionTextStyle = TextStyle(
    fontSize: 12,
    color: primaryColorAccent,
  );

  // Button Styles
  static final ButtonStyle primaryButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: secondaryColor,
    foregroundColor: Colors.white,
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
    shape: RoundedRectangleBorder(
      borderRadius: borderRadiusMedium,
    ),
    elevation: 5,
  );

  static final ButtonStyle outlineButtonStyle = OutlinedButton.styleFrom(
    side: BorderSide(color: borderColor, width: 1.5),
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
    shape: RoundedRectangleBorder(
      borderRadius: borderRadiusMedium,
    ),
  );

  // Divider
  static const Divider divider = Divider(
    color: borderColor,
    thickness: 1,
  );
}
