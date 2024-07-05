import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DiseaseDetectionHistory extends StatelessWidget {
  const DiseaseDetectionHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Disease Diagnosis",
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.w700, fontFamily: "Bitter"),
        ),
      ),
    );
  }
}
