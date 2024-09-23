import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fpo_assist/screens/farmer/production/vegetable_production/rewards_screen.dart';
import 'package:fpo_assist/widgets/custom_elevated_button.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';

import '../../../../utils/api_constants.dart';

class SubmitTaskController extends GetxController {
  final storage = FlutterSecureStorage();
  final int landId;
  final int filterId;
  final String preferenceNumber;
  final bool isLast;

  Rx<File?> image = Rx<File?>(null);
  RxBool isSubmitting = false.obs;
  RxString error = ''.obs;
  RxBool success = false.obs;

  SubmitTaskController(
      {required this.landId,
      required this.filterId,
      required this.preferenceNumber,
      required this.isLast});

  Future<void> pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      image.value = File(pickedFile.path);
    }
  }

  Future<void> submitTask() async {
    if (image.value == null) {
      error.value = 'Please select an image';
      return;
    }

    isSubmitting.value = true;
    error.value = '';
    success.value = false;

    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            '${ApiEndPoints.baseUrlTest}MarkVegetableStageCompleteAPIView'),
      );
      String? accessToken = await storage.read(key: 'access_token');
      if (accessToken == null) {
        throw Exception('Access token not found');
      }
      request.headers['Authorization'] = 'Bearer $accessToken';

      request.fields['filter_type'] = filterId.toString();
      request.fields['preference_number'] = preferenceNumber;
      request.fields['land_id'] = landId.toString();

      var pic =
          await http.MultipartFile.fromPath('submit_task', image.value!.path);
      request.files.add(pic);

      var response = await request.send();
      log("heyyyyy${response.toString()}");
      if (response.statusCode == 200) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        var responseBody = await response.stream.bytesToString();
        var decodedResponse = json.decode(responseBody);
        log("heyyyyy data aaya${decodedResponse.toString()}");
        await prefs.setString('coins', decodedResponse['total_coins'].toString());
        success.value = true;
        // for popup
        Get.back();
        Get.off(() => RewardsScreen(), binding: BindingsBuilder(() {
          Get.put(RewardsController(
              coins: decodedResponse["coins_added"],
              landId: landId,
              filterId: filterId,
              isLast: isLast)); // Replace 10 with your dynamic coin value
        }));
      } else {
        error.value = 'Failed to submit task. Please try again.';
      }
    } catch (e) {
      error.value = 'An error occurred. Please try again.';
    } finally {
      isSubmitting.value = false;
    }
  }
}

class SubmitTaskPopup extends StatelessWidget {
  final int landId;
  final int filterId;
  final String preferenceNumber;
  final bool isLast;

  SubmitTaskPopup(
      {required this.landId,
      required this.filterId,
      required this.preferenceNumber,
      required this.isLast});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SubmitTaskController(
        landId: landId,
        filterId: filterId,
        preferenceNumber: preferenceNumber,
        isLast: isLast));

    return Dialog(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Submit Task',
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                              fontFamily: "Bitter")),
                    ],
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () => Get.back(),
                ),
              ],
            ),
            Text('Please upload picture of Task',
                style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w400,
                    fontFamily: "NotoSans",
                    color: Colors.black)),
            SizedBox(
              height: 16,
            ),
            Obx(() => controller.image.value != null
                ? Image.file(controller.image.value!, height: 150)
                : GestureDetector(
              onTap: controller.pickImage,
                  child: Container(
                      height: 150,
                      decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Colors.grey)
                      ),
                      child: Center(child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset("assets/icons/upload_image_icon.png", height: 40, width: 40,),
                          Text('Upload here', style: TextStyle(
                              fontSize: 16,
                              decoration: TextDecoration.underline,
                              fontWeight: FontWeight.w400,
                              fontFamily: "NotoSans",
                              color: Colors.green)),
                        ],
                      )),
                    ),
                )),
            // SizedBox(height: 16),
            // ElevatedButton(
            //   onPressed: controller.pickImage,
            //   child: Text('Select Image'),
            // ),
            SizedBox(height: 16),
            Obx(() => controller.error.value.isNotEmpty
                ? Text(controller.error.value,
                    style: TextStyle(color: Colors.red))
                : SizedBox.shrink()),
            Obx(() => controller.success.value
                ? Text('Task submitted successfully!',
                    style: TextStyle(color: Colors.green))
                : SizedBox.shrink()),
            SizedBox(height: 16),
            Obx(() => CustomElevatedButton(
                  buttonColor: Colors.green,
                  onPress: controller.isSubmitting.value
                      ? null
                      : controller.submitTask,
                  widget: Text(controller.isSubmitting.value
                      ? 'Submitting...'
                      : 'SUBMIT'),
                )),
          ],
        ),
      ),
    );
  }
}
