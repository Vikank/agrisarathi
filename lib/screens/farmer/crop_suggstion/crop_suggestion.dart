import 'package:flutter/material.dart';
import 'package:get/get.dart';


class CropSuggestion extends StatelessWidget {
  const CropSuggestion({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Crop Suggestion".tr,
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.w700, fontFamily: "Bitter"),
        ),
      ),
      body: Column(
        children: [

        ],
      ),
    );
  }
}
