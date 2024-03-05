import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String labelText;
  final IconData prefixIcon;
  final bool isObscure;

  const CustomTextField({
    super.key,
    required this.labelText,
    required this.prefixIcon,
    this.isObscure = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: TextField(
        decoration: InputDecoration(
          labelText: labelText,
          hintStyle: const TextStyle(color: Colors.grey),
          prefixIcon: Icon(prefixIcon, color: Colors.grey),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
        ),
        obscureText: isObscure,
      ),
    );
  }
}
