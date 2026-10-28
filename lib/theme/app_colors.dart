import 'package:flutter/material.dart';

abstract class AppColors {
  // Brand Color
  static const Color brandPrimary = Color(0xFFF16334);
  static const Color onPrimary = Color(0xFF202020);

  // Accessible Text Color on Light Subtle Containers / White (7.82:1 on #FFFFFF, 7.38:1 on #FFF1EC)
  static const Color lightOnPrimaryContainer = Color(0xFF8F3000);

  // Accessible Text Color on Dark Subtle Containers (8.00:1 on #292321)
  static const Color darkOnPrimaryContainer = Color(0xFFFFB68F);

  // Light Theme Colors
  static const Color lightBackground = Color(0xFFFFFFFF);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightSubtleOrange = Color(0xFFFFF1EC);
  static const Color lightPrimaryText = Color(0xFF202020);
  static const Color lightSecondaryText = Color(0xFF666666);
  static const Color lightBorder = Color(0xFFEEEEEE);

  // Dark Theme Colors
  static const Color darkBackground = Color(0xFF171717);
  static const Color darkSurface = Color(0xFF222222);
  static const Color darkSubtleOrange = Color(0xFF292321);
  static const Color darkPrimaryText = Color(0xFFFFFFFF);
  static const Color darkSecondaryText = Color(0xFFBDBDBD);
  static const Color darkBorder = Color(0xFF363636);
}
