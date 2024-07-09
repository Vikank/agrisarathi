import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

import '../../../controllers/farmer/disease_detection_video_controller.dart';
import '../../../widgets/custom_elevated_button.dart';

class HowToClick extends StatelessWidget {
  int serviceProviderId;
  int cropId;
  String landId;
  String filterType;
  HowToClick(
      {required this.serviceProviderId,
      required this.cropId,
      required this.landId,
      required this.filterType,
      super.key});

  final DiseaseDetectionVideoController controller =
      Get.put(DiseaseDetectionVideoController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Tutorial".tr,
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.w700, fontFamily: "Bitter"),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 13),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                          border: Border.all(width: 1, color: Colors.grey)),
                      child: Image.asset(
                        "assets/images/take_a_pic_leaf.png",
                        height: 44,
                        width: 42,
                      ),
                    ),
                    Text(
                      "Take_a_Pic".tr,
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          fontFamily: "NotoSans"),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 13),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                          border: Border.all(width: 1, color: Colors.grey)),
                      child: Image.asset(
                        "assets/images/diagnosis.png",
                        height: 44,
                        width: 42,
                      ),
                    ),
                    Text(
                      "Get_Diagnosis".tr,
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          fontFamily: "NotoSans"),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 13),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                          border: Border.all(width: 1, color: Colors.grey)),
                      child: Image.asset(
                        "assets/images/get_medicines.png",
                        height: 44,
                        width: 42,
                      ),
                    ),
                    Text(
                      "Get_Medicines".tr,
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          fontFamily: "NotoSans"),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 24,
            ),
            Text(
              "Learn_with_video_how_to_do_it".tr,
              style: TextStyle(
                  fontFamily: "Bitter",
                  fontSize: 14,
                  fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 16,
            ),
            Obx(() {
              if (controller.isLoading.value) {
                return Center(child: CircularProgressIndicator());
              } else if (controller.errorMessage.isNotEmpty) {
                return Center(child: Text(controller.errorMessage.value));
              } else if (controller.chewieController.value == null) {
                return Center(child: Text('Failed_to_load_video'.tr));
              } else {
                return Container(
                  height: 180,
                  child: Chewie(controller: controller.chewieController.value!),
                );
              }
            }),
            Spacer(),
            Row(
              children: [
                Expanded(
                  child: CustomElevatedButton(
                    buttonColor: Colors.green,
                    onPress: () {
                      controller.openGallery(serviceProviderId: serviceProviderId, cropId: cropId, landId : landId, filterType: filterType);
                    },
                    widget: Text(
                      "Gallery".tr,
                      style: TextStyle(
                          fontFamily: 'NotoSans',
                          fontSize: 15,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
                SizedBox(width: 10,),
                Expanded(
                  child: CustomElevatedButton(
                    buttonColor: Colors.green,
                    onPress: () {
                      controller.openCamera(serviceProviderId: serviceProviderId, cropId: cropId, landId : landId, filterType: filterType);
                    },
                    widget: Text(
                      "Camera".tr,
                      style: TextStyle(
                          fontFamily: 'NotoSans',
                          fontSize: 15,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
