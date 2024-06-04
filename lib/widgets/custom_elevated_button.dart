import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  CustomElevatedButton(
      {required this.buttonColor, required this.onPress, required this.widget});

  final void Function()? onPress;
  final Color buttonColor;
  final Widget widget;

  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPress,
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: buttonColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        minimumSize: const Size(double.infinity, 42),
      ),
      child: widget,
    );
  }
}

Widget progressIndicator() {
  return const SizedBox(
    height: 20,
    width: 20,
    child: CircularProgressIndicator(color: Colors.white,),
  );
}
