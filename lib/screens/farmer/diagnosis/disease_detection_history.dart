import 'package:flutter/material.dart';
import 'package:fpo_assist/utils/api_constants.dart';
import 'package:fpo_assist/utils/helper_functions.dart';
import 'package:get/get.dart';

import '../../../controllers/farmer/disease_detection_history_controller.dart';
import '../detect_disease/disease_result_screen.dart';
import 'detect_disease_single_history.dart';

class DiseaseDetectionHistory extends StatelessWidget {
  final DiseaseDetectionHistoryController controller = Get.put(DiseaseDetectionHistoryController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Disease_Diagnosis".tr,
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.w700, fontFamily: "GoogleSans"),
        ),
      ),
      body:  Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24),
        child: Obx(() {
          if (controller.isLoading.value) {
            return Center(child: CircularProgressIndicator());
          } else if (controller.diseaseHistory.value == null ||
              controller.diseaseHistory.value!.diseaseDetails == null) {
            return Center(child: Text('No data available'));
          } else {
            return ListView.separated(
              itemCount: controller.diseaseHistory.value!.diseaseDetails!.length,
              separatorBuilder: (context, index) => SizedBox(
                height: 16,
              ),
              itemBuilder: (context, index) {
                var details = controller.diseaseHistory.value!.diseaseDetails![index];
                return GestureDetector(
                  onTap: () async {
                    var singleDiseaseData = await controller.fetchSingleDiseaseHistory(details.id!);
                    if (singleDiseaseData != null) {
                      Get.to(() => SingleDiseaseHistory(diseaseData: singleDiseaseData));
                    } else {
                      Get.snackbar('Error', 'Failed to fetch disease details');
                    }
                  },
                  child: Container(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: Image.network(
                            '${ApiEndPoints.imageBaseUrl}${details.uploadedImage}',
                            width: 155,
                            height: 95,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                Container(
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[300],
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Icon(Icons.error),
                                ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(details.diseaseName ?? 'Unknown Disease', style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              fontFamily: "GoogleSans",
                              color: Color(0xff1C1C1C)
                            ),),
                            Text(details.serviceProvider ?? 'Unknown Provider', style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                                fontFamily: "GoogleSans",
                              color: Color(0xff64748B)
                            ),),
                            // Text(HelperFunctions().formatDate(details.d), style: TextStyle(
                            //     fontWeight: FontWeight.w400,
                            //     fontSize: 12,
                            //     fontFamily: "GoogleSans",
                            //   color: Color(0xff1C1C1C)
                            // ),),
                          ],
                        )
                      ],
                    ),
                  ),
                );
              },
            );
          }
        }),
      ),
    );
  }
}
