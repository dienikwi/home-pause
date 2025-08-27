import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Estilos de texto padronizados do aplicativo
class AppTextStyles {
  AppTextStyles._();

  static TextStyle titleLarge = GoogleFonts.manrope(
    fontSize: 35,
    fontWeight: FontWeight.w500,
  );

  static TextStyle titleMedium = GoogleFonts.manrope(
    fontSize: 25,
    fontWeight: FontWeight.bold,
  );

  static TextStyle titleSmall = GoogleFonts.manrope(
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );

  // Subtítulos
  static TextStyle subtitle = GoogleFonts.manrope(
    fontSize: 18,
    color: Colors.grey,
  );

  static TextStyle subtitleBold = GoogleFonts.manrope(
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );

  // Corpo de texto
  static TextStyle bodyLarge = GoogleFonts.manrope(
    fontSize: 16,
  );

  static TextStyle bodyMedium = GoogleFonts.manrope(
    fontSize: 14,
  );

  static TextStyle bodySmall = GoogleFonts.manrope(
    fontSize: 13,
    color: Colors.grey,
  );

  // Botões
  static TextStyle buttonText = GoogleFonts.manrope(
    fontSize: 18,
    fontWeight: FontWeight.w600,
  );

  static TextStyle buttonTextWhite = GoogleFonts.manrope(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );

  // Links
  static TextStyle linkText = GoogleFonts.manrope(
    fontSize: 15,
    color: const Color(0xFF9399F9),
    decoration: TextDecoration.none,
  );

  static TextStyle greyText = GoogleFonts.manrope(
    fontSize: 15,
    color: Colors.grey,
  );

  // Cards
  static TextStyle cardTitle = GoogleFonts.manrope(
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );

  static TextStyle cardDescription = GoogleFonts.manrope(
    fontSize: 14,
  );
}
