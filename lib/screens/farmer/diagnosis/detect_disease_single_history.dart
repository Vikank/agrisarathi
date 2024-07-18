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
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Diagnosis".tr,
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.w700, fontFamily: "Bitter"),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              diseaseData.diseaseResults!.first.disease == ""
                  ? SizedBox.shrink()
                  : Container(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                width: double.infinity,
                height: 37,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(5),
                    ),
                    color: Color(0xffEAFAEB)),
                child: Text(
                  "${diseaseData.diseaseResults!.first.disease}",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      fontFamily: "Bitter"),
                ),
              ),
              SizedBox(height: 16,),
              SizedBox(
                  height: 190,
                  width: double.infinity,
                  child: Image.network(
                      ApiEndPoints.baseUrl +
                          diseaseData.diseaseResults!.first.images!,
                      fit: BoxFit.cover,
                      width: double.infinity)),
              diseaseData.diseaseResults!.first.treatment == "" &&
                      diseaseData.diseaseResults!.first.treatmentbefore == "" &&
                      diseaseData.diseaseResults!.first.treatmentfield == "" &&
                      diseaseData.diseaseResults!.first.suggestiveproduct ==
                          "" &&
                      diseaseData.diseaseResults!.first.symptom != ""
                  ? Text(
                      diseaseData.diseaseResults!.first.symptom!,
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          fontFamily: "Bitter"),
                    )
                  : SizedBox.shrink(),
              diseaseData.diseaseResults!.first.symptom != ""
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 16,
                        ),
                        Text(
                          "Symptoms".tr,
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              fontFamily: "Bitter"),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text("${diseaseData.diseaseResults!.first.symptom}"),
                      ],
                    )
                  : SizedBox.shrink(),
              SizedBox(
                height: 16,
              ),
              Visibility(
                visible: diseaseData.diseaseResults!.first.cropId != 5 &&
                    diseaseData.diseaseResults!.first.cropId != 73,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    diseaseData.diseaseResults!.first.treatmentbefore != ""
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Treatments_before_Sowing".tr,
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                    fontFamily: "Bitter"),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                  "${diseaseData.diseaseResults!.first.treatmentbefore}"),
                              SizedBox(
                                height: 16,
                              ),
                            ],
                          )
                        : SizedBox.shrink(),
                    diseaseData.diseaseResults!.first.treatmentfield != ""
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Treatments_in_field".tr,
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                    fontFamily: "Bitter"),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                  "${diseaseData.diseaseResults!.first.treatmentfield}"),
                              SizedBox(
                                height: 16,
                              ),
                            ],
                          )
                        : SizedBox.shrink(),
                  ],
                ),
              ),
              diseaseData.diseaseResults!.first.treatment != ""
                  ? Visibility(
                      visible: diseaseData.diseaseResults!.first.cropId == 5 ||
                          diseaseData.diseaseResults!.first.cropId == 73,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Treatments".tr,
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                                fontFamily: "Bitter"),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                              "${diseaseData.diseaseResults!.first.treatment}"),
                          SizedBox(
                            height: 16,
                          ),
                        ],
                      ),
                    )
                  : SizedBox.shrink(),
              diseaseData.diseaseResults!.first.suggestiveproduct != ""
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Sustainable_methods".tr,
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              fontFamily: "Bitter"),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                            "${diseaseData.diseaseResults!.first.suggestiveproduct}"),
                      ],
                    )
                  : SizedBox.shrink(),
              SizedBox(height: 24),
              if (diseaseData.productDiseaseResults != null &&
                  diseaseData.productDiseaseResults!.isNotEmpty)
                _buildProductResultsSection(diseaseData.productDiseaseResults!),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProductResultsSection(List<ProductDiseaseResults> products) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Recommended_Products'.tr,
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontFamily: "Bitter")),
        SizedBox(height: 10),
        ListView.builder(
          shrinkWrap: true,
          itemCount: products.length,
          itemBuilder: (context, index) {
            var product = products[index];
            return ListTile(
              leading: Image.network(
                'http://64.227.166.238:8000${product.productimage}',
                width: 50,
                height: 50,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  width: 50,
                  height: 50,
                  color: Colors.grey[300],
                  child: Icon(Icons.error),
                ),
              ),
              title: Text(product.productname ?? 'N/A',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Bitter")),
              subtitle: Text(
                  '${product.category ?? 'N/A'} - ${product.price ?? 'N/A'}',
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      fontFamily: "NanoSans")),
            );
          },
        ),
      ],
    );
  }
}
