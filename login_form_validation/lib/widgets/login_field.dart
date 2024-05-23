import 'package:flutter/material.dart';
import 'package:login_form_validation/colors/palette.dart';

class LoginField extends StatelessWidget {
  const LoginField({
    super.key,
    required this.hintText,
    required this.controller,
    required this.keyboardType,
    this.obscureText = false,
  });

  final String hintText;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxWidth: 400,
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        obscureText: obscureText,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(25),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Palette.borderColor,
              width: 3,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Palette.gradient2,
              width: 3,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          hintText: hintText,
        ),
      ),
    );
  }
}
