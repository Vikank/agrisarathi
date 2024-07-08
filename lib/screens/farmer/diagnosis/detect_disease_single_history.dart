import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:fpo_assist/controllers/farmer/disease_detection_video_controller.dart';
import 'package:fpo_assist/utils/api_constants.dart';
import 'package:get/get.dart';

import '../../../controllers/farmer/disease_detection_history_controller.dart';
import '../../../models/single_disease_history_model.dart';

class SingleDiseaseHistory extends StatelessWidget {
  final SingleDiseaseHistoryModel diseaseData;

  SingleDiseaseHistory({required this.diseaseData});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Diagnosis",
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.w700, fontFamily: "Bitter"),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 190,
                width: double.infinity,
                child: Image.network(ApiEndPoints.baseUrl+ diseaseData.diseaseResults!.first.images!,
                    fit: BoxFit.cover, width: double.infinity)
              ),
              diseaseData.diseaseResults!.first.symptom != "" ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 16,
                  ),
                  Text("Symptoms", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14, fontFamily: "Bitter"),),
                  SizedBox(
                    height: 8,
                  ),
                  Text("${diseaseData.diseaseResults!.first.symptom}"),
                ],
              ) :  SizedBox.shrink(),
              SizedBox(
                height: 16,
              ),
              Visibility(
                visible: diseaseData.diseaseResults!.first.cropId != 5 && diseaseData.diseaseResults!.first.cropId != 73,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Treatments before Sowing", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14, fontFamily: "Bitter"),),
                    SizedBox(
                      height: 8,
                    ),
                    Text("${diseaseData.diseaseResults!.first.treatmentbefore}"),
                    SizedBox(
                      height: 16,
                    ),
                    Text("Treatments in field", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14, fontFamily: "Bitter"),),
                    SizedBox(
                      height: 8,
                    ),
                    Text("${diseaseData.diseaseResults!.first.treatmentfield}"),
                    SizedBox(
                      height: 16,
                    ),
                  ],
                ),
              ),
              Visibility(
                visible: diseaseData.diseaseResults!.first.cropId == 5 || diseaseData.diseaseResults!.first.cropId == 73,
                child: Column(
                  children: [
                    Text("Treatment", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14, fontFamily: "Bitter"),),
                    SizedBox(
                      height: 8,
                    ),
                    Text("${diseaseData.diseaseResults!.first.treatment}"),
                    SizedBox(height: 16,),
                  ],
                ),
              ),
              Text("Sustainable methods", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14, fontFamily: "Bitter"),),
              SizedBox(
                height: 8,
              ),
              Text("${diseaseData.diseaseResults!.first.suggestiveproduct}"),
            ],
          ),
        ),
      ),
    );
  }
}
