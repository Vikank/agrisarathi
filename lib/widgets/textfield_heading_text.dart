import 'package:flutter/material.dart';
import 'package:fpo_assist/utils/color_constants.dart';

class TextfieldHeadingText extends StatelessWidget {
  final String textData;
  const TextfieldHeadingText(
      {super.key, required this.textData});

  @override
  Widget build(BuildContext context) {
    return Text(
      textData,
      style: TextStyle(
          color: ColorConstants.fieldNameColor,
          fontSize: 12,
          fontFamily: 'GoogleSans',
          fontWeight: FontWeight.w400),
    );
  }
}
