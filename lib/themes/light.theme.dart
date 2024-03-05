import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData lightTheme = ThemeData(
  textTheme: GoogleFonts.manropeTextTheme(),
  primaryColor: const Color(0xFF9399F9),
  brightness: Brightness.light,
  colorScheme: const ColorScheme.light(
    background: Color.fromARGB(255, 246, 246, 246),
    primary: Color(0xFF9399F9),
    secondary: Color(0xFF5F6CFA),
    tertiary: Color(0xFFB0B0B0),
  ),
  inputDecorationTheme: const InputDecorationTheme(
    labelStyle: TextStyle(
      color: Color(0xFF1A1A1A),
    ),
  ),
);
