import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home_pause/core/constants/app_colors.dart';
import 'package:home_pause/core/constants/app_dimensions.dart';

ThemeData lightTheme = ThemeData(
  textTheme: GoogleFonts.manropeTextTheme(),
  primaryColor: AppColors.primary,
  brightness: Brightness.light,
  colorScheme: const ColorScheme.light(
    surface: AppColors.background,
    primary: AppColors.primary,
    secondary: AppColors.secondary,
    tertiary: AppColors.tertiary,
    onPrimary: AppColors.textLight,
    onSecondary: AppColors.textLight,
    onSurface: AppColors.textPrimary,
  ),
  inputDecorationTheme: InputDecorationTheme(
    labelStyle: const TextStyle(
      color: AppColors.textSecondary,
    ),
    hintStyle: const TextStyle(
      color: AppColors.textSecondary,
    ),
    fillColor: AppColors.textFieldBackground,
    filled: true,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppDimensions.radiusLarge),
      borderSide: BorderSide.none,
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppDimensions.radiusLarge),
      borderSide: BorderSide.none,
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppDimensions.radiusLarge),
      borderSide: const BorderSide(
        color: AppColors.primary,
        width: 2.0,
      ),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppDimensions.radiusLarge),
      borderSide: const BorderSide(
        color: AppColors.error,
        width: 2.0,
      ),
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.primary,
      foregroundColor: AppColors.textLight,
      elevation: AppDimensions.elevationLow,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
      ),
      minimumSize: const Size(
        AppDimensions.buttonWidth,
        AppDimensions.buttonHeight,
      ),
    ),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    selectedItemColor: AppColors.primary,
    unselectedItemColor: AppColors.textSecondary,
    type: BottomNavigationBarType.fixed,
    elevation: AppDimensions.elevationMedium,
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: AppColors.surfaceWhite,
    foregroundColor: AppColors.textPrimary,
    elevation: 0,
    centerTitle: true,
  ),
  cardTheme: CardTheme(
    color: AppColors.surfaceWhite,
    elevation: AppDimensions.elevationLow,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
    ),
  ),
);
