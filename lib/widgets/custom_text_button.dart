import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  CustomTextButton({required this.buttonText,
    required this.buttonColor,
    required this.size,
    required this.onPress});

  final void Function()? onPress;
  final String buttonText;
  final Color buttonColor;
  final double size;

  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
      onPressed: onPress,
      child: Text(
        buttonText,
        style: TextStyle(fontFamily: 'NatoSans', fontSize: size, fontWeight: FontWeight.w500, color: buttonColor),
      ),
    );
  }
}
