import 'package:flutter/material.dart';

import 'app_colors.dart';

abstract class AppTheme {
  static ThemeData get lightTheme {
    const colorScheme = ColorScheme.light(
      primary: AppColors.brandPrimary,
      onPrimary: AppColors.onPrimary,
      primaryContainer: AppColors.lightSubtleOrange,
      onPrimaryContainer: AppColors.lightOnPrimaryContainer,
      secondary: AppColors.brandPrimary,
      onSecondary: AppColors.onPrimary,
      secondaryContainer: AppColors.lightSubtleOrange,
      onSecondaryContainer: AppColors.lightOnPrimaryContainer,
      surface: AppColors.lightSurface,
      onSurface: AppColors.lightPrimaryText,
      surfaceContainerHighest: AppColors.lightSubtleOrange,
      onSurfaceVariant: AppColors.lightSecondaryText,
      outline: AppColors.lightBorder,
      outlineVariant: AppColors.lightBorder,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: AppColors.lightBackground,
      dividerColor: AppColors.lightBorder,
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.lightSurface,
        foregroundColor: AppColors.lightPrimaryText,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        titleTextStyle: TextStyle(
          color: AppColors.lightPrimaryText,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      cardTheme: const CardThemeData(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
          side: BorderSide(color: AppColors.lightBorder, width: 1),
        ),
        color: AppColors.lightSurface,
      ),
      chipTheme: const ChipThemeData(
        backgroundColor: AppColors.lightSurface,
        selectedColor: AppColors.lightSubtleOrange,
        side: BorderSide(color: AppColors.lightBorder),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        labelStyle: TextStyle(color: AppColors.lightPrimaryText),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: AppColors.brandPrimary,
          foregroundColor: AppColors.onPrimary,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.brandPrimary,
          foregroundColor: AppColors.onPrimary,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: AppColors.lightSurface,
        indicatorColor: AppColors.lightSubtleOrange,
        iconTheme: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const IconThemeData(color: AppColors.brandPrimary);
          }
          return const IconThemeData(color: AppColors.lightSecondaryText);
        }),
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppColors.lightPrimaryText,
            );
          }
          return const TextStyle(
            fontSize: 12,
            color: AppColors.lightSecondaryText,
          );
        }),
      ),
      segmentedButtonTheme: SegmentedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return AppColors.lightSubtleOrange;
            }
            return AppColors.lightSurface;
          }),
          foregroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return AppColors.lightOnPrimaryContainer;
            }
            return AppColors.lightSecondaryText;
          }),
          side: WidgetStateProperty.all(
            const BorderSide(color: AppColors.lightBorder),
          ),
        ),
      ),
    );
  }

  static ThemeData get darkTheme {
    const colorScheme = ColorScheme.dark(
      primary: AppColors.brandPrimary,
      onPrimary: AppColors.onPrimary,
      primaryContainer: AppColors.darkSubtleOrange,
      onPrimaryContainer: AppColors.darkOnPrimaryContainer,
      secondary: AppColors.brandPrimary,
      onSecondary: AppColors.onPrimary,
      secondaryContainer: AppColors.darkSubtleOrange,
      onSecondaryContainer: AppColors.darkOnPrimaryContainer,
      surface: AppColors.darkSurface,
      onSurface: AppColors.darkPrimaryText,
      surfaceContainerHighest: AppColors.darkSubtleOrange,
      onSurfaceVariant: AppColors.darkSecondaryText,
      outline: AppColors.darkBorder,
      outlineVariant: AppColors.darkBorder,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: AppColors.darkBackground,
      dividerColor: AppColors.darkBorder,
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.darkSurface,
        foregroundColor: AppColors.darkPrimaryText,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        titleTextStyle: TextStyle(
          color: AppColors.darkPrimaryText,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      cardTheme: const CardThemeData(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
          side: BorderSide(color: AppColors.darkBorder, width: 1),
        ),
        color: AppColors.darkSurface,
      ),
      chipTheme: const ChipThemeData(
        backgroundColor: AppColors.darkSurface,
        selectedColor: AppColors.darkSubtleOrange,
        side: BorderSide(color: AppColors.darkBorder),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        labelStyle: TextStyle(color: AppColors.darkPrimaryText),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: AppColors.brandPrimary,
          foregroundColor: AppColors.onPrimary,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.brandPrimary,
          foregroundColor: AppColors.onPrimary,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: AppColors.darkSurface,
        indicatorColor: AppColors.darkSubtleOrange,
        iconTheme: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const IconThemeData(color: AppColors.brandPrimary);
          }
          return const IconThemeData(color: AppColors.darkSecondaryText);
        }),
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppColors.darkPrimaryText,
            );
          }
          return const TextStyle(
            fontSize: 12,
            color: AppColors.darkSecondaryText,
          );
        }),
      ),
      segmentedButtonTheme: SegmentedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return AppColors.darkSubtleOrange;
            }
            return AppColors.darkSurface;
          }),
          foregroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return AppColors.darkOnPrimaryContainer;
            }
            return AppColors.darkSecondaryText;
          }),
          side: WidgetStateProperty.all(
            const BorderSide(color: AppColors.darkBorder),
          ),
        ),
      ),
    );
  }
}
