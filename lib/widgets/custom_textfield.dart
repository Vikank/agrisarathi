import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hint;
  final TextEditingController controller;
  final TextInputType inputType;
  final bool obscureText;
  final ValueChanged<String>? onChanged;
  final Function(String?)? validator;

  CustomTextField(
      {required this.hint,
      required this.controller,
      this.inputType = TextInputType.text,
      this.obscureText = false,
      this.onChanged,
      this.validator});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      validator: validator != null ? (value) => validator!(value) : null,
      onChanged: onChanged,
      controller: controller,
      keyboardType: inputType,
      decoration: InputDecoration(
        isDense: true,
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0xff959CA3)),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0xff959CA3)),
        ),
        hintStyle:
            const TextStyle(fontWeight: FontWeight.w300, color: Colors.grey),
        hintText: hint,
      ),
    );
  }
}
