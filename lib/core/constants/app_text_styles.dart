import 'package:flutter/material.dart';

/// Estilos de texto padronizados do aplicativo
class AppTextStyles {
  AppTextStyles._();

  static const TextStyle titleLarge = TextStyle(
    fontSize: 35,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle titleMedium = TextStyle(
    fontSize: 25,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle titleSmall = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );

  // Subtítulos
  static const TextStyle subtitle = TextStyle(
    fontSize: 18,
    color: Colors.grey,
  );

  static const TextStyle subtitleBold = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );

  // Corpo de texto
  static const TextStyle bodyLarge = TextStyle(
    fontSize: 16,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontSize: 14,
  );

  static const TextStyle bodySmall = TextStyle(
    fontSize: 13,
    color: Colors.grey,
  );

  // Botões
  static const TextStyle buttonText = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle buttonTextWhite = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );

  // Links
  static const TextStyle linkText = TextStyle(
    fontSize: 15,
    color: Color(0xFF9399F9),
    decoration: TextDecoration.none,
  );

  static const TextStyle greyText = TextStyle(
    fontSize: 15,
    color: Colors.grey,
  );

  // Cards
  static const TextStyle cardTitle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle cardDescription = TextStyle(
    fontSize: 14,
  );
}
