import 'package:flutter/material.dart';

class ColorPalette {
  // Brand Green
  static const Color primaryColor = Color(0xFF2E7D32); // Rich Emerald Green
  static const Color primaryVariant = Color(0xFF1B5E20); // Darker Forest Green

  // Core neutrals (keep the same)
  static const Color backgroundColor = Color(0xFFFFFFFF);
  static const Color scaffoldBackground = Color(0xFFF5F5F5);
  static const Color cardColor = Color(0xFFFFFFFF);
  static const Color borderColor = Color(0xFFE0E0E0);

  // Text & icons
  static const Color textPrimary = Color(0xFF000000);
  static const Color textSecondary = Color(0xFF666666);
  static const Color hintText = Color(0xFF9E9E9E);
  static const Color iconActive = Color(0xFF000000);
  static const Color textColor = Color(0xFFFFFFFF);
  static const Color amber = Color(0xFFF57C00);
  // static const Color amber = Colors.amber;

  // Feedback
  static const Color successColor = Color(0xFF2E7D32);
  static const Color errorColor = Color(0xFFB00020);

  // Example button fills
  static const Color buttonPrimary = Color(0xFF4CAF50);
  static const Color buttonSecondary = Color(0xFFFFFFFF);
}

const Color hintTextColor = ColorPalette.hintText;
const Color darkText = ColorPalette.textPrimary;
const Color whiteText = ColorPalette.textColor;
const Color darkGreen = ColorPalette.primaryVariant;
const Color lightGreen = ColorPalette.buttonPrimary;
const Color backgroundColor = ColorPalette.backgroundColor;
const Color amber = ColorPalette.amber;
const Color scaffoldBackground = ColorPalette.scaffoldBackground;
const Color lighHintText = Color.fromARGB(255, 213, 210, 210);
