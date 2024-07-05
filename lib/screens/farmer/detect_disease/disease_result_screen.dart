import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:fpo_assist/controllers/farmer/disease_detection_video_controller.dart';
import 'package:fpo_assist/utils/api_constants.dart';
import 'package:get/get.dart';

class DiseaseResultScreen extends StatelessWidget {

  DiseaseDetectionVideoController controller = Get.put(DiseaseDetectionVideoController());
  final CarouselController _controller = CarouselController();


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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 190,
              width: double.infinity,
              child: CarouselSlider(
                items: controller.diseaseResultModel.images!
                    .map((item) => Image.network(ApiEndPoints.imageBaseUrl+item.diseaseFile!,
                    fit: BoxFit.cover, width: double.infinity))
                    .toList(),
                carouselController: _controller,
                options: CarouselOptions(
                    viewportFraction: 1,
                    enlargeCenterPage: true,
                    onPageChanged: (index, reason) {
                      controller.currentCarousel.value = index;
                    }),
              ),
            ),
            Obx(() {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: controller.diseaseResultModel.images!.asMap().entries.map((entry) {
                  return GestureDetector(
                    onTap: () => _controller.animateToPage(entry.key),
                    child: Container(
                      width: 8.0,
                      height: 8.0,
                      margin:
                      EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color:
                          controller.currentCarousel.value == entry.key
                              ? Colors.green
                              : Colors.grey[100]),
                    ),
                  );
                }).toList(),
              );
            }),
            SizedBox(
              height: 16,
            ),
            Text("Symptoms", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14, fontFamily: "Bitter"),),
            SizedBox(
              height: 8,
            ),
            Text("${controller.diseaseResultModel.disease}"),
            SizedBox(
              height: 16,
            ),
            Text("Treatments before Sowing", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14, fontFamily: "Bitter"),),
            SizedBox(
              height: 8,
            ),
            Text("${controller.diseaseResultModel.reason}"),
            SizedBox(
              height: 16,
            ),
            Text("Treatments in field", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14, fontFamily: "Bitter"),),
            SizedBox(
              height: 8,
            ),
            Text("${controller.diseaseResultModel.symptom}"),
            SizedBox(
              height: 16,
            ),
            Text("Sustainable methods", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14, fontFamily: "Bitter"),),
            SizedBox(
              height: 8,
            ),
            Text("${controller.diseaseResultModel.treatment}"),
          ],
        ),
      ),
    );
  }
}
