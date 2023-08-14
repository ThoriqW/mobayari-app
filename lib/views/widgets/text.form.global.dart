import 'package:flutter/material.dart';

import '../../utils/global.colors.dart';

class TextFormGlobal extends StatelessWidget {
  const TextFormGlobal(
      {super.key,
      required this.controller,
      required this.text,
      required this.textInputType,
      required this.obscure,
      this.validator});
  final TextEditingController controller;
  final String text;
  final TextInputType textInputType;
  final bool obscure;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: textInputType,
      obscureText: obscure,
      validator: validator,
      decoration: InputDecoration(
        hintText: text,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16.0, vertical: 15.0),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: GlobalColors.stroke, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: GlobalColors.mainColor, width: 2),
        ),
      ),
      style: const TextStyle(fontWeight: FontWeight.bold),
    );
  }
}
